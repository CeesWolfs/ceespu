#include "ceespu_assembler.h"

using namespace ELFIO;

bool inline is16bit(int x)
{
    return ((short)x == x);
}

bool ispowerof2(unsigned int x)
{
    return x && !(x & (x - 1));
}

inline int roundUp(int n, int a)
{
    // align value n to alignment a, works only for powers of 2
    // fails miserably otherwise
    return ((n & (a - 1)) == 0) ? n : n + a & ~(a - 1);
}

uint8_t Tokenize(std::string& str, uint8_t& curtoken, uint8_t start)
{
    // check if we reached the end of our string
    if(curtoken == str.length()) {
        return 0;
    }

    // Get the size of the next token in the string skipping all delimeters
    curtoken = str.find_first_not_of(" ,()\t", start);
    std::string::size_type pos = str.find_first_of(" ,()\t", curtoken);

    if(curtoken == (uint8_t)-1) {
        return 0;
    }

    if(pos == std::string::npos) {
        pos = str.length();
    }

    // check if the token is ; meaning the rest of the line is comment
    if(str[curtoken] == ';') {
        return 0;
    }

    return pos - curtoken;
}

uint64_t getImmidiate(char* immidiate, uint8_t size)
{
    if(size > 11 || size < 1) {
        return -1;
    }
    char buf[12];
    char* endptr = buf;
    errno = 0;
    memcpy(buf, immidiate, size);
    buf[size] = 0;
    long int imm = (strtol(buf, &endptr, 0) & 0xffffffff);
    if(errno != 0 || (endptr == buf)) {
        return -1;
    }
    return imm;
}

std::string getLabel(char* label, uint8_t size)
{
    if(label[size - 1] != ':') {
        return std::string();
    }
    return std::string(label, size - 1);
}

uint8_t getDirective(char* directive, uint8_t size)
{
    if(!(directive[0] == '.')) {
        return INVALID;
    }
    directive++;
    uint8_t left = 0;
    uint8_t right = 11 - 1;
    while(left < right) {
        uint8_t middle = (left + right) / 2;
        if(strncmp(directive, directives[middle], size - 1) == 0) {
            return middle;
        }
        if(strncmp(directive, directives[middle], size - 1) > 0) {
            left = middle + 1;
        } else {
            right = middle - 1;
        }
    }
    return INVALID;
}

InstructionInfo getInstruction(char* mnemonic, uint8_t size)
{
    uint8_t left = 0;
    mnemonic[size] = '\0';
    if(size > 5) {
        return invalid_instruction;
    }
    uint8_t right = nInstrs - 1;
    while(left <= right) {
        uint8_t middle = (left + right) / 2;
        if(strcmp(mnemonic, instr[middle].Mnemonic) == 0) {
            return instr[middle];
        }
        if(strcmp(mnemonic, instr[middle].Mnemonic) > 0) {
            left = middle + 1;
        } else {
            right = middle - 1;
        }
    }
    return invalid_instruction;
}

uint8_t getRegister(char* reg, uint8_t size)
{
    if(size > 3 || size < 2) {
        return -1;
    }
    if(reg[0] != 'c') {
        return -1;
    }
    if(size == 2) {
        if(isdigit(reg[1]) != 0) {
            return reg[1] - '0';
        }
        return -1;
    }
    int regnum = ((reg[1] - '0') * 10 + (reg[2] - '0'));
    if((regnum < 32) && (regnum > -1)) {
        return regnum;
    }
    if(reg[1] == 's' && reg[2] == 'p') {
        return 18; // Ceespu stack pointer
    }
    if(reg[1] == 'l' && reg[2] == 'r') {
        return 19; // Ceespu link register
    }
    return -1; // invalid register
}

void parseLabel(std::string& label, uint32_t lineNum, std::map<std::string, uint32_t>& symboltable, symbol_section_accessor& symbolwriter,uint32_t offset)
{
    // Check if the label is already defined
    if( !symboltable.insert(std::make_pair(label, offset)).second) {
        // Error label already defined
        
    }
}

uint32_t parseInstruction(std::string& line, uint8_t& curtoken, bool& immset, InstructionInfo instruction)
{
    // get the next token
    uint8_t token_len = Tokenize(line, curtoken, curtoken);
    uint8_t rd = 0, ra = 0, rb = 0;
    uint16_t imm = 0;
    uint32_t instr = 0;

    switch(instruction.Type) {
    case A0: {
        rd = getRegister(&line[curtoken], token_len);
        if(rd == 0xff) {
            return -1;
        }
        token_len = Tokenize(line, curtoken, curtoken + token_len);
        ra = getRegister(&line[curtoken], token_len);
        if(ra == 0xff) {
            return -1;
        }
        token_len = Tokenize(line, curtoken, curtoken + token_len);
        rb = getRegister(&line[curtoken], token_len);
        if(rb == 0xff) {
            return -1;
        }
        break;
    }
    case A2: {
        rd = getRegister(&line[curtoken], token_len);

        if(rd == 0xff) {
            return -1;
        }
        token_len = Tokenize(line, curtoken, curtoken + token_len);
        ra = getRegister(&line[curtoken], token_len);
        if(ra == 0xff) {
            return -1;
        }
        break;
    }
    case B0: {
        rd = getRegister(&line[curtoken], token_len);
        if(rd == 0xff) {
            return -1;
        }
        token_len = Tokenize(line, curtoken, curtoken + token_len);
        ra = getRegister(&line[curtoken], token_len);
        if(ra == 0xff) {
            return -1;
        }
        token_len = Tokenize(line, curtoken, curtoken + token_len);
        uint64_t immidiate = getImmidiate(&line[curtoken], token_len);
        if(!is16bit(immidiate)) {
            return -1;
        }
        imm = immidiate;
        break;
    }
    case B1: {
        ra = getRegister(&line[curtoken], token_len);
        token_len = Tokenize(line, curtoken, curtoken + token_len);
        if(ra == 0xff) {
            return -1;
        }
        rb = getRegister(&line[curtoken], token_len);
        token_len = Tokenize(line, curtoken, curtoken + token_len);
        if(rd == 0xff) {
            return -1;
        }
        token_len = Tokenize(line, curtoken, curtoken + token_len);
        uint64_t immidiate = getImmidiate(&line[curtoken], token_len);
        if(!is16bit(immidiate)) {
            return -1;
        }
        imm = immidiate & 0x3FF;
        rd = (immidiate >> 11) & 0x1F;
        break;
    }
    case B2: {
        uint64_t immidiate = getImmidiate(&line[curtoken], token_len);
        if(!is16bit(immidiate)) {
            return -1;
        }
        imm = immidiate;
        if(instruction.Opcode == 0x2a) {
            immset = true;
        }
        break;
    }
    case B3: {
        rd = getRegister(&line[curtoken], token_len);
        if(rd == 0xff) {
            return -1;
        }
        token_len = Tokenize(line, curtoken, curtoken + token_len);
        uint64_t immidiate = getImmidiate(&line[curtoken], token_len);
        if(!is16bit(immidiate)) {
            return -1;
        }
        imm = immidiate;
        token_len = Tokenize(line, curtoken, curtoken + token_len);
        ra = getRegister(&line[curtoken], token_len);
        if(ra == 0xff) {
            return -1;
        }
        break;
    }
    case B4: {
        ra = getRegister(&line[curtoken], token_len);
        if(ra == 0xff) {
            return -1;
        }
        token_len = Tokenize(line, curtoken, curtoken + token_len);
        uint64_t immidiate = getImmidiate(&line[curtoken], token_len);
        if(!is16bit(immidiate)) {
            return -1;
        }
        token_len = Tokenize(line, curtoken, curtoken + token_len);
        rb = getRegister(&line[curtoken], token_len);
        if(rb == 0xff) {
            return -1;
        }
        imm = immidiate & 0x3FF;
        rd = (immidiate >> 11) & 0x1F;
        break;
    }
    }
    instr |= instruction.Opcode << 26;
    instr |= rd << 21;
    instr |= ra << 16;
    instr |= rb << 11;
    instr |= imm;
    instr |= instruction.FuncCode;
    return instr;
}

int main(int argc, char* argv[])
{
    if(argc < 2) {
        fprintf(stderr, "Error no input file specified\nUsage: %s <inputfile>\n", argv[0]);
        return 1;
    }
    std::ifstream input_file;
    std::string line;

    elfio elffile;
    elffile.create(ELFCLASS32, ELFDATA2MSB);

    section* str_sec = elffile.sections.add(".strtab");
    str_sec->set_type(SHT_STRTAB);
    str_sec->set_addr_align(0x1);
    string_section_accessor str_writer(str_sec);

    section* sym_sec = elffile.sections.add(".symtab");
    sym_sec->set_type(SHT_SYMTAB);
    sym_sec->set_info(2);
    sym_sec->set_link(str_sec->get_index());
    sym_sec->set_addr_align(2);
    sym_sec->set_entry_size(2);

    std::vector<Label> function_labels;

    section* text_sec = nullptr;
    section* data_sec = nullptr;

    symbol_section_accessor symbol_writer(elffile, sym_sec);

    // Another way to add symbol
    // symbol_writer.add_symbol(str_writer, "_start", 0x00000000, 0, STB_WEAK,
    // STT_FUNC, 0, text_sec->get_index());

    uint64_t offset = 0;
    uint32_t lineNum = 0;
    bool immset = false;
    input_file.open(argv[1]);
    if(!input_file) {
        fprintf(stderr, "Error input file could not be opened\n");
        return 1;
    }
    uint8_t curtoken = 0;
    while(std::getline(input_file, line)) {
        lineNum++;
        if(line.length() > 120) {
            fprintf(stderr, "Error max line length execeeded at line %d\n", lineNum);
            return 1;
        }
        int token_len = Tokenize(line, curtoken, 0);
        if(token_len == 0) {
            continue;
        }
        std::string label = getLabel(&line[curtoken], token_len);
        if(!label.empty()) {
            printf("line %d : label %.*s found\n", lineNum, (int)label.length(), label.data());
            parseLabel(label, symboltable, symbol_writer, offset);
            if(symbol_writer.get_symbol(label, value, size, bind, type, section_index, other)) {
                uint16_t addend = offset - value;
                function_labels.push_back({label, addend});
            }
            token_len = Tokenize(line, curtoken, curtoken + token_len);
            if(token_len == 0) {
                continue;
            }
        }
        uint8_t directive = getDirective(&line[curtoken], token_len);
        if(directive != INVALID) {
            printf("line %d : directive %d found\n", lineNum, directive);
            token_len = Tokenize(line, curtoken, curtoken + token_len);
            if(token_len == 0) {
                fprintf(stderr, "Error expected token after directive .%s\n", directives[directive]);
            }
            switch(directive) {
            case ALIGN: {
                uint64_t align = getImmidiate(&line[curtoken], token_len);
                if(!ispowerof2(align)) {
                    fprintf(stderr, "Error invalid alignement requested at line\n");
                }
                roundUp(offset, align);
                break;
            }
            case DATA: {
                // Create data section*
                section* data_sec = elffile.sections.add(".data");
                data_sec->set_type(SHT_PROGBITS);
                data_sec->set_flags(SHF_ALLOC | SHF_WRITE);
                data_sec->set_addr_align(0x4);
            }
            case TEXT: {
                // Create code section
                text_sec = elffile.sections.add(".text");
                text_sec->set_type(SHT_PROGBITS);
                text_sec->set_flags(SHF_ALLOC | SHF_EXECINSTR);
                text_sec->set_addr_align(0x4);
            }
            }
            if(directive == GLOBL) {
                symbol_writer.add_symbol(str_writer, &line[curtoken], offset, 0, STB_GLOBAL, STT_FUNC, 0,
                                         text_sec->get_index());
                function_labels.clear();
            }
            if(directive == ALIGN) {
                uint64_t align = getImmidiate(&line[curtoken], token_len);
                if(!ispowerof2(align)) {
                    fprintf(stderr, "Error invalid alignement requested at line\n");
                }
                offset = roundUp(offset, align);
            }
        }
        InstructionInfo instruction = getInstruction(&line[curtoken], token_len);
        if(instruction.Type != invalid_instruction.Type) {
            printf("line %d : instruction %s found of type : %d\n", lineNum, instruction.Mnemonic, instruction.Type);
            curtoken += token_len + 1;
            uint32_t instr = parseInstruction(line, curtoken, immset, instruction);
            if(instruction.Opcode != 0x2A) {
                immset = false;
            }
            offset += 4;
            if(instr == (uint32_t)-1) {
                fprintf(stderr, "Error invalid instruction %s at line %d\n", instruction.Mnemonic, lineNum);
                exit(1);
            }
            printf("%08X\n", instr);
            continue;
        }
    }
}
