// Copyright 2018 <Cees Wolfs>
#include "ceespu_assembler.h"

bool inline is16bit(int x) { return (x < 65536) && !(x < -65536); }

bool ispowerof2(unsigned int x) { return x && !(x & (x - 1)); }

inline int roundUp(int n, int a) {
  // align value n to alignment a, works only for powers of 2
  // fails miserably otherwise
  return ((n & (a - 1)) == 0) ? n : (n + a) & ~(a - 1);
}

uint32_t hashString(const std::string& key) {
  uint32_t hash = 0;
  for (const char& c : key) {
    hash += c;
    hash += hash << 10;
    hash ^= hash >> 6;
  }
  hash += hash << 3;
  hash ^= hash >> 11;
  hash += hash << 15;
  return hash;
}

void Function::applyFixup(ObjectFile& object, uint16_t offset, uint8_t type,
                          uint16_t value) {
  if (type == REL_LO12) {
    object.data[offset + 2] |= value >> 14;
    object.data[offset + 1] |= ((value >> 11) & 0xE0);
    object.data[offset + 1] |= ((value >> 8) & 0x5);
    object.data[offset] = value & 0xff;
  } else if (type == REL_LO16) {
    object.data[offset + 1] |= value >> 8;
    object.data[offset] |= value & 0xff;
  }
}

void Function::fixup(ObjectFile& object) {
  int previous_top = object.relocation_table.size();
  // fix all the relocation, add symbol entries to undefined symbols as needed
  for (auto& reloc : local_relocation_table) {
    Relocation relocation = {static_cast<uint8_t>(-1), reloc.rel_offset,
                             reloc.type};
    bool local = false;
    // check if the relocation is to a local lable
    for (auto& label : local_symbol_table) {
      if (label.name == reloc.label) {
        local = true;
        applyFixup(object, reloc.rel_offset, reloc.type, label.offset);
        break;
      }
    }
    if (local) {
		object.relocation_table.push_back(relocation);
    } else {
      // check if already in string_table
      std::size_t index = object.findSymbol(reloc.label);
      if (index == -1) {
        index = object.insertSymbol(reloc.label, -1, LABEL_UNDEFINED);
      }
      relocation.symbol_index = index;
      // keep relocations to undefined symbol at the front to ease linker
	  if (object.relocation_table.size() == 0) {
		  object.relocation_table.push_back(relocation);
	  }
	  else {
		  object.relocation_table.insert(object.relocation_table.begin()+previous_top, 1, relocation);
	  }
    }
  }
  symbol_entry.relocation_length = local_relocation_table.size();
  symbol_entry.size = object.data.size() - symbol_entry.addr;
}

void Function::newFunction(Symbol& new_symbol) {
  local_symbol_table.clear();
  local_relocation_table.clear();
  symbol_entry = new_symbol;
  rel_offset = 0;
}

ObjectFile::ObjectFile() {
  insertSymbol("dummy_sy", 0, 0);
  current_function = new Function(symbol_table[0]);
  abs_offset = 0;
}

std::size_t ObjectFile::findSymbol(const std::string& name) {
  uint32_t hash = hashString(name);
  std::size_t index = 0;
  for (Symbol& symbol : symbol_table) {
    if (symbol.hash == hash) {
      // possible hit label
      if (!strncmp(name.data(), string_section.data() + symbol.string_offset,
                   name.size())) {
        return index;
      }
    }
    index++;
  }
  return -1;
}

std::size_t ObjectFile::insertSymbol(const std::string& name, uint16_t offset,
                                     uint8_t type) {
  uint32_t hash = hashString(name);
  Symbol label = {hash,
                  type,
                  offset,
                  0,
	              static_cast<uint16_t>(relocation_table.size()),
	              0,
                  static_cast<uint16_t>(string_section.size()),
                  static_cast<uint8_t>(name.length())};
  std::copy(name.begin(), name.end(), std::back_inserter(string_section));
  std::size_t index = symbol_table.size();
  symbol_table.push_back(label);
  return index;
}

void ObjectFile::save(const std::string& filename) {
  struct Header obj_header;
  obj_header.reloc_start =
      sizeof(struct Header) + symbol_table.size() * sizeof(Symbol);
  obj_header.string_start =
      obj_header.reloc_start + relocation_table.size() * sizeof(Relocation);
  obj_header.data_start = obj_header.reloc_start + string_section.size();
  std::ofstream out(filename, std::ios_base::binary);
  out.write(reinterpret_cast<char*>(&obj_header), sizeof(struct Header));
  out.write(reinterpret_cast<char*>(&symbol_table[0]),
            symbol_table.size() * sizeof(Symbol));
  if(!relocation_table.empty())
  out.write(reinterpret_cast<char*>(&relocation_table[0]),
            relocation_table.size() * sizeof(Relocation));
  out.write(reinterpret_cast<char*>(&string_section[0]), string_section.size());
  out.write(reinterpret_cast<char*>(&data[0]), data.size());
  out.close();
}

uint8_t Tokenize(const std::string& str, uint8_t& curtoken, uint8_t start) {
  // check if we reached the end of our string
  if (curtoken == str.length()) {
    return 0;
  }

  // Get the size of the next token in the string skipping all delimeters
  curtoken = str.find_first_not_of(" ,()\t", start);
  std::string::size_type pos = str.find_first_of(" ,()\t", curtoken);

  if (curtoken == (uint8_t)-1) {
    return 0;
  }

  if (pos == std::string::npos) {
    pos = str.length();
  }

  // check if the token is ; meaning the rest of the line is comment
  if (str[curtoken] == ';') {
    return 0;
  }

  return pos - curtoken;
}

int64_t getImmidiate(const char* immidiate, uint8_t size) {
  // All 32-bit immidiates fit in 10 charachters
  if (size > 10 || size < 1) {
    return invalid_immidiate;
  }
  char buf[10];
  char* endptr = buf;
  errno = 0;
  memcpy(buf, immidiate, size);
  buf[size] = 0;
  // do the actual conversion
  int64_t imm = (strtol(buf, &endptr, 0) & 0xffffffff);
  if (errno != 0 || (endptr == buf)) {
    // Error occured thus immidiate is invalid
    return invalid_immidiate;
  }
  return imm;
}

std::string getLabel(char* label, uint8_t size) {
  // if the token ends with ':' it is a label
  if (label[size - 1] != ':') {
    // not a label return empty string
    return std::string();
  }
  // return the label without the ':' character
  return std::string(label, size - 1);
}

uint8_t getDirective(char* directive, uint8_t size) {
  // all directives start with '.'
  if (!(directive[0] == '.')) {
    return INVALID;
  }
  // skip the '.' character
  directive++;
  // perform binary search for directive in table
  int left = 0;
  int right = nDirect - 1;
  while (left <= right) {
    uint8_t middle = (left + right) / 2;
    if (strncmp(directive, directives[middle], size - 1) == 0) {
      // directive found
      return middle;
    }
    if (strncmp(directive, directives[middle], size - 1) > 0) {
      left = middle + 1;
    } else {
      right = middle - 1;
    }
  }
  // directive not in table, return invalid
  return INVALID;
}

InstructionInfo getInstruction(char* mnemonic, uint8_t size) {
  // strcmp requires null termination
  mnemonic[size] = '\0';
  if (size > 5) {
    return invalid_instruction;
  }
  // perform binary search on instruction table
  int left = 0;
  int right = nInstrs - 1;
  while (left <= right) {
    uint8_t middle = (left + right) / 2;
    if (strcmp(mnemonic, instr[middle].Mnemonic) == 0) {
      // found instruction
      return instr[middle];
    }
    if (strcmp(mnemonic, instr[middle].Mnemonic) > 0) {
      left = middle + 1;
    } else {
      right = middle - 1;
    }
  }
  // instruction not found return invalid
  return invalid_instruction;
}

uint8_t getRegister(const char* reg, uint8_t size) {
  if (size > 3 || size < 2) {
    return -1;
  }
  if (reg[0] != 'c') {
    return -1;
  }
  if (size == 2) {
    if (isdigit(reg[1]) != 0) {
      return reg[1] - '0';
    }
    return -1;
  }
  // bit of a hack, but it does work
  int regnum = ((reg[1] - '0') * 10 + (reg[2] - '0'));
  if ((regnum < 32) && (regnum >= 0)) {
    return regnum;
  }
  if (reg[1] == 'f' && reg[2] == 'p') {
    return 16;  // Ceespu stack pointer
  }
  if (reg[1] == 'i' && reg[2] == 'r') {
    return 17;  // Ceespu stack pointer
  }
  if (reg[1] == 's' && reg[2] == 'p') {
    return 18;  // Ceespu stack pointer
  }
  if (reg[1] == 'l' && reg[2] == 'r') {
    return 19;  // Ceespu link register
  }
  return -1;  // invalid register
}

void parseLabel(const std::string& label_name, int line_num,
                Function* function) {
  Label labelValue = {label_name, function->rel_offset};
  for (auto& label : function->local_symbol_table) {
    if (label.name == label_name) {
      fprintf(stderr, "Error duplicate label found on line%d\n", line_num);
      exit(1);
    }
  }
  function->local_symbol_table.push_back(labelValue);
}

uint32_t parseInstruction(const std::string& line, uint8_t& curtoken,
                          bool& immset, InstructionInfo instruction,
                          Function* function) {
  // get the next token
  uint8_t token_len = Tokenize(line, curtoken, curtoken);
  uint8_t rd = 0, ra = 0, rb = 0;
  uint16_t imm = 0;
  uint32_t instr = 0;

  switch (instruction.Type) {
    case A0: {
      rd = getRegister(&line[curtoken], token_len);
      if (rd == 0xff) {
        return -1;
      }
      token_len = Tokenize(line, curtoken, curtoken + token_len);
      ra = getRegister(&line[curtoken], token_len);
      if (ra == 0xff) {
        return -1;
      }
      token_len = Tokenize(line, curtoken, curtoken + token_len);
      rb = getRegister(&line[curtoken], token_len);
      if (rb == 0xff) {
        return -1;
      }
      break;
    }
    case A2: {
      rd = getRegister(&line[curtoken], token_len);
      if (rd == 0xff) {
        return -1;
      }
      token_len = Tokenize(line, curtoken, curtoken + token_len);
      ra = getRegister(&line[curtoken], token_len);
      if (ra == 0xff) {
        return -1;
      }
      break;
    }
    case A3: {
      ra = getRegister(&line[curtoken], token_len);
      if (ra == 0xff) {
        return -1;
      }
      break;
    }
    case B0: {
      rd = getRegister(&line[curtoken], token_len);
      if (rd == 0xff) {
        return -1;
      }
      token_len = Tokenize(line, curtoken, curtoken + token_len);
      ra = getRegister(&line[curtoken], token_len);
      if (ra == 0xff) {
        return -1;
      }
      token_len = Tokenize(line, curtoken, curtoken + token_len);
      uint64_t immidiate = getImmidiate(&line[curtoken], token_len);
      if (!is16bit(immidiate)) {
        // Not an immidiate push relocation
        LocRelocation reloc = {std::string(line, curtoken, token_len),
                               function->rel_offset, REL_LO16};
        function->local_relocation_table.push_back(reloc);
      } else {
        imm = immidiate;
      }
      break;
    }
    case B1: {
      ra = getRegister(&line[curtoken], token_len);
      token_len = Tokenize(line, curtoken, curtoken + token_len);
      if (ra == 0xff) {
        return -1;
      }
      rb = getRegister(&line[curtoken], token_len);
      if (rb == 0xff) {
        return -1;
      }
      token_len = Tokenize(line, curtoken, curtoken + token_len);
      uint64_t immidiate = getImmidiate(&line[curtoken], token_len);
      if (immidiate == invalid_immidiate) {
        // Not an immidiate push relocation
        LocRelocation reloc = {std::string(line, curtoken, token_len),
                               function->rel_offset, REL_LO12};
        function->local_relocation_table.push_back(reloc);
      } else {
        imm = immidiate & 0x7FF;
        rd = (immidiate >> 11) & 0x1F;
      }
      break;
    }
    case B2: {
      uint64_t immidiate = getImmidiate(&line[curtoken], token_len);
      if (immidiate == invalid_immidiate) {
        // Not an immidiate push relocation
        LocRelocation reloc = {std::string(line, curtoken, token_len),
                               function->rel_offset, REL_LO16};
        function->local_relocation_table.push_back(reloc);
        immidiate = 0;
      } else {
        imm = immidiate;
      }
      break;
    }
    case B3: {
      rd = getRegister(&line[curtoken], token_len);
      if (rd == 0xff) {
        return -1;
      }
      token_len = Tokenize(line, curtoken, curtoken + token_len);
      uint64_t immidiate = getImmidiate(&line[curtoken], token_len);
      if (immidiate == invalid_immidiate) {
        // Not an immidiate push relocation
        LocRelocation reloc = {std::string(line, curtoken, token_len),
                               function->rel_offset, REL_LO16};
        function->local_relocation_table.push_back(reloc);
        immidiate = 0;
      } else {
        imm = immidiate;
      }
      token_len = Tokenize(line, curtoken, curtoken + token_len);
      ra = getRegister(&line[curtoken], token_len);
      if (ra == 0xff) {
        return -1;
      }
      break;
    }
    case B4: {
      // store so rb goes first
      rb = getRegister(&line[curtoken], token_len);
      if (rb == 0xff) {
        return -1;
      }
      token_len = Tokenize(line, curtoken, curtoken + token_len);
      uint64_t immidiate = getImmidiate(&line[curtoken], token_len);
      if (immidiate == invalid_immidiate) {
        // Not an immidiate push relocation
        LocRelocation reloc = {std::string(line, curtoken, token_len),
                               function->rel_offset, REL_LO12};
        function->local_relocation_table.push_back(reloc);
        immidiate = 0;
      } else {
        imm = immidiate & 0x7FF;
        rd = (immidiate >> 11) & 0x1F;
      }
      token_len = Tokenize(line, curtoken, curtoken + token_len);
      ra = getRegister(&line[curtoken], token_len);
      if (ra == 0xff) {
        return -1;
      }
      break;
    }
    case B5: {
      uint64_t immidiate = getImmidiate(&line[curtoken], token_len);
      if (immidiate == invalid_immidiate) {
        // Not an immidiate push relocation
        LocRelocation reloc = {std::string(line, curtoken, token_len),
                               function->rel_offset, REL_LO12};
        function->local_relocation_table.push_back(reloc);
      } else {
        imm = immidiate & 0x7FF;
        rd = (immidiate >> 11) & 0x1F;
      }
      if (instruction.FuncCode & 0x1) {
        ra = 19;  // call
      }
      break;
    }
  }
  instr |= instruction.Opcode << 26;
  instr |= rd << 21;
  instr |= ra << 16;
  instr |= rb << 11;
  instr |= imm;
  instr |= instruction.FuncCode;
  if (Tokenize(line, curtoken, curtoken + token_len) != 0) {
    fprintf(stderr, "Error too many tokens\n");
    return -1;
  }
  return instr;
}

bool parseDirective(const std::string& line, int line_num, uint8_t& curtoken,
                    uint8_t token_len, uint8_t directive, ObjectFile& object) {
  switch (directive) {
    case ASCII: {
      size_t start = line.find_first_of("\"", curtoken);
      if (start == std::string::npos) {
        fprintf(stderr, "invalid ascii string on line %d\n", line_num);
        exit(1);
      }
      if (line.back() != '\"') {
        fprintf(stderr, "invalid string directive on line%d\n", line_num);
        exit(1);
      }
      for (int i = start + 1; i < line.length() - 1; ++i) {
        if (line[i] == '\\') {
          switch (line[++i]) {
            case 'n': {
              object.data.push_back('\n');
              break;
            }
            case 'r': {
              object.data.push_back('\r');
              break;
            }
            case '\"': {
              object.data.push_back('\"');
              break;
            }
          }
        }
        object.data.push_back(line[i]);
      }
      object.data.push_back(0);
      uint16_t start_index = object.abs_offset;
      object.abs_offset = object.data.size();
      object.current_function->rel_offset += object.data.size() - start_index;
      break;
    }
    case ALIGN: {
      uint64_t align = getImmidiate(&line[curtoken], token_len);
      if (align < 1 || align > 8) {
        fprintf(stderr, "Error invalid alignement requested at line%d\n",
                line_num);
      }
      object.abs_offset = roundUp(object.abs_offset, 1 << align);
      object.data.insert(object.data.end(),
                         object.abs_offset - object.data.size(), 0);
      break;
    }
    case DATA: {
      break;
    }
    case TEXT: {
      break;
    }
    case GLOBL: {
      std::string label_name = std::string(line, curtoken, token_len);
      std::size_t index = object.findSymbol(label_name);
      if (index != -1) {
        if (object.symbol_table[index].type == LABEL_UNDEFINED) {
          // symbol was undefined now define the label
          object.symbol_table[index].type = LABEL_GLOBL;
          object.symbol_table[index].addr = object.abs_offset;
        } else {
          // duplicate label
          fprintf(stderr, "Error duplicate label on line %d\n", line_num);
          exit(1);
        }
      } else {
        index = object.insertSymbol(label_name, object.abs_offset, LABEL_GLOBL);
      }
      object.current_function->fixup(object);
      object.current_function->newFunction(object.symbol_table[index]);
      break;
    }
    case SPACE: {
      uint64_t space = getImmidiate(&line[curtoken], token_len);
      if (space == invalid_immidiate) {
        printf("Error invalid immidiate after space directive\n");
        exit(1);
      }
      object.data.insert(object.data.end(), space, 0);
      object.abs_offset += space;
      object.current_function->rel_offset += space;
      break;
    }
    case WORD: {
      uint64_t value = getImmidiate(&line[curtoken], token_len);
      if (value == invalid_immidiate) {
        printf("Error invalid immidiate after word directive\n");
      }
      for (int i = 0; i <= 3; i++) {
        object.data.push_back((value >> (i * 8)) & 0xff);
      }
      object.abs_offset += 4;
      object.current_function->rel_offset += 4;
      break;
    }
    case HWORD: {
      uint64_t value = getImmidiate(&line[curtoken], token_len);
      if (value == invalid_immidiate) {
        printf("Error invalid immidiate after hword directive\n");
      }
      for (int i = 0; i <= 1; i++) {
        object.data.push_back((value >> (i * 8)) & 0xff);
      }
      object.abs_offset += 2;
      object.current_function->rel_offset += 2;
      break;
    }
    case BYTE: {
      uint64_t value = getImmidiate(&line[curtoken], token_len);
      if (value == invalid_immidiate) {
        printf("Error invalid immidiate after byte directive\n");
      }
      object.data.push_back(value & 0xff);
      object.abs_offset++;
      object.current_function->rel_offset++;
      break;
    }
    default:
      break;  // skip direcitves that are uniplemented
  }
  return false;
}

int main(int argc, char* argv[]) {
  if (argc < 2) {
    fprintf(stderr, "Error no input file specified\nUsage: %s <inputfile>\n",
            argv[0]);
    return 1;
  }
  std::string outputfile;
  if (argc == 3) {
    outputfile = argv[2];
  } else {
    outputfile = "output.o";
  }
  std::ifstream input_file;
  std::string line;
  ObjectFile object;
  int line_num = 0;
  bool immset = false;
  input_file.open(argv[1]);
  if (!input_file) {
    fprintf(stderr, "Error input file could not be opened\n");
    return 1;
  }
  uint8_t curtoken = 0;
  while (std::getline(input_file, line)) {
    line_num++;
    if (line.length() > 120) {
      fprintf(stderr, "Error max line length execeeded at line %d\n", line_num);
      return 1;
    }
    uint8_t token_len = Tokenize(line, curtoken, 0);
    if (token_len == 0) {
      continue;
    }
    std::string label = getLabel(&line[curtoken], token_len);
    if (!label.empty()) {
      parseLabel(label, line_num, object.current_function);
      token_len = Tokenize(line, curtoken, curtoken + token_len);
      if (token_len == 0) {
        continue;
      }
    }
    uint8_t directive = getDirective(&line[curtoken], token_len);
    if (directive != INVALID) {
      // printf("line %d : directive %d found\n", line_num, directive);
      token_len = Tokenize(line, curtoken, curtoken + token_len);
      parseDirective(line, line_num, curtoken, token_len, directive, object);
      token_len = Tokenize(line, curtoken, curtoken + token_len);
      if (token_len == 0) {
        continue;
      }
    }
    InstructionInfo instruction = getInstruction(&line[curtoken], token_len);
    if (instruction.Type != invalid_instruction.Type) {
      // printf("line %d : instruction %s found of type : %d\n",
      // line_num, instruction.Mnemonic, instruction.Type);
      curtoken += token_len + 1;
      uint32_t instr = parseInstruction(line, curtoken, immset, instruction,
                                        object.current_function);
      if (instruction.Opcode != 0x2A) {
        immset = false;
      }
      object.abs_offset += 4;
      object.current_function->rel_offset += 4;
      if (instr == (uint32_t)-1) {
        fprintf(stderr, "Error invalid instruction %s at line %d\n",
                instruction.Mnemonic, line_num);
        exit(1);
      }
      for (int i = 0; i <= 3; i++) {
        object.data.push_back((instr >> (i * 8)) & 0xff);
      }
      continue;
    }
    fprintf(stderr, "Error invalid token on line %d\n", line_num);
    exit(1);
  }
  object.current_function->fixup(object);
  object.save(outputfile);
  return 0;
}