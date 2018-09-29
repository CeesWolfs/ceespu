// Copyright (c) 2018 <Cees Wolfs>

#include "ceespu.h"
#include "receive.h"
#include "video.h"

#include <thread>

std::thread input_thread;

namespace helpers {

inline uint32_t swap32(uint32_t k) {
  return ((k << 24) | ((k & 0x0000FF00) << 8) | ((k & 0x00FF0000) >> 8) |
          (k >> 24));
}

inline uint16_t swap16(uint16_t k) { return ((k << 8) | (k >> 8)); }

inline uint32_t getBits(uint32_t val, const uint8_t upperbit,
                        const uint8_t lowerbit) {
  return (val >> lowerbit) & ((1 << ((upperbit + 1) - lowerbit)) - 1);
}

inline bool getBit(uint32_t val, const uint8_t bit) { return val >> bit & 0x1; }

}  // namespace helpers

Ceespu::Ceespu() {}

Ceespu::~Ceespu() {}

void Ceespu::init(Video* screen) {
  memset(&this->memory[0], 0, 65536);
  memcpy(&this->memory[CEESPU_FONT_MEMORY_OFFSET / 4], font, 2048);
  for (int i = 0; i < 2048; i += 4) {
    this->memory[(CEESPU_COLOUR_MEMORY_OFFSET + i) / 4].word = 0x0f0f0f0f;
  }
  this->pc = 0;
  this->carry = false;
  this->enable_interrupt = true;
  this->immidiate_valid = false;
  this->interrupt = false;
  for (size_t i = 0; i < 31; i++) {
    Regs[i] = 0;
  }
  this->screen = screen;
}

void Ceespu::emulateCycle() {
  if (this->interrupt & this->enable_interrupt) {
    this->Regs[17] = this->pc + 4;
    this->pc = this->int_vector;
    this->enable_interrupt = false;
    this->interrupt = false;
  } else {
    uint8_t rd, ra, rb, opcode;
    uint16_t address;
    int32_t immidiate;
    uint32_t instruction = this->getWord(this->pc);
    uint64_t result;
    this->pc += 4;
    opcode = helpers::getBits(instruction, 31, 26);
    rd = helpers::getBits(instruction, 25, 21);
    ra = helpers::getBits(instruction, 20, 16);
    rb = helpers::getBits(instruction, 15, 11);
    if ((opcode >= 52 && opcode <= 54) || ((opcode >= 56) && (opcode <= 62))) {
      immidiate = this->immidiate_valid
                      ? ((this->immidiate_reg << 16) |
                         helpers::getBits(instruction, 25, 21) << 11 |
                         helpers::getBits(instruction, 10, 0))
                      : static_cast<int16_t>(
                            helpers::getBits(instruction, 25, 21) << 11 |
                            helpers::getBits(instruction, 10, 0));
    } else {
      immidiate = this->immidiate_valid ? ((this->immidiate_reg << 16) |
                                           helpers::getBits(instruction, 15, 0))
                                        : static_cast<int16_t>(instruction);
    }
    this->immidiate_valid = false;
    switch (opcode) {
      case ADD:
        result = Regs[ra] + Regs[rb];
        this->carry = result < Regs[ra];
        Regs[rd] = result;
        break;
      case ADC:
        result = Regs[ra] + Regs[rb] + this->carry;
        this->carry = result < Regs[ra];
        Regs[rd] = result;
      case SUB:
        result = Regs[rb] - Regs[ra];
        this->carry = result > Regs[ra];
        Regs[rd] = result;
      case SBB:
        result = Regs[rb] - Regs[ra] - this->carry;
        this->carry = result > Regs[ra];
        Regs[rd] = result;
        break;
      case OR:
        Regs[rd] = Regs[ra] | Regs[rb];
        break;
      case AND:
        Regs[rd] = Regs[ra] & Regs[rb];
        break;
      case XOR:
        Regs[rd] = Regs[ra] ^ Regs[rb];
        break;
      case SE:
        Regs[rd] = helpers::getBit(instruction, 0)
                       ? static_cast<int16_t>(Regs[ra])
                       : static_cast<int8_t>(Regs[ra]);
        break;
      case SHF:
        switch (helpers::getBits(instruction, 15, 14)) {
          case 0:
            Regs[rd] = Regs[ra] << Regs[rb];
            break;
          case 1:
            Regs[rd] = Regs[ra] >> Regs[rb];
            break;
          case 2:
            Regs[rd] = static_cast<int32_t>(Regs[ra]) >> Regs[rb];
            break;
          default:
            crash(this, "Malformed instruction, malformed shift opcode");
            break;
        }
        break;
      case MUL:
        Regs[rd] = Regs[ra] * Regs[rb];
        break;
      case ADDI:
        result = Regs[ra] + immidiate;
        this->carry = result < Regs[ra];
        Regs[rd] = result;
        break;
      case ADCI:
        result = Regs[ra] + immidiate + this->carry;
        this->carry = result < Regs[ra];
        Regs[rd] = result;
      case SUBI:
        result = immidiate - Regs[ra];
        this->carry = result > immidiate;
        Regs[rd] = result;
      case SBBI:
        result = immidiate - Regs[ra] - this->carry;
        this->carry = result > immidiate;
        Regs[rd] = result;
        break;
      case ORI:
        Regs[rd] = Regs[ra] | immidiate;
        break;
      case ANDI:
        Regs[rd] = Regs[ra] & immidiate;
        break;
      case XORI:
        Regs[rd] = Regs[ra] ^ immidiate;
        break;
      case SHFI:
        switch (helpers::getBits(instruction, 15, 14)) {
          case 0:
            Regs[rd] = Regs[ra] << helpers::getBits(immidiate, 4, 0);
            break;
          case 1:
            Regs[rd] = Regs[ra] >> helpers::getBits(immidiate, 4, 0);
            break;
          case 2:
            Regs[rd] = static_cast<int32_t>(Regs[ra]) >>
                       helpers::getBits(immidiate, 4, 0);
            break;
          default:
            crash(this, "Malformed instruction, malformed shift opcode");
            break;
        }
        break;
      case MULI:
        Regs[rd] = Regs[ra] * immidiate;
        break;
      case LW:
        Regs[rd] = getWord(Regs[ra] + immidiate);
        break;
      case LH:
        Regs[rd] = static_cast<int32_t>(getHalfword(Regs[ra] + immidiate));
        break;
      case LB:
        Regs[rd] = static_cast<int32_t>(getByte(Regs[ra] + immidiate));
        break;
      case LHU:
        Regs[rd] = getHalfword(Regs[ra] + immidiate);
        break;
      case LBU:
        Regs[rd] = getByte(Regs[ra] + immidiate);
        break;
      case SETI:
        this->immidiate_reg = helpers::getBits(instruction, 15, 0);
        this->immidiate_valid = true;
        break;
      case EI:
        this->enable_interrupt = helpers::getBit(instruction, 0);
        break;
      case SW:
        address = Regs[ra] + immidiate;
        storeWord(address, Regs[rb]);
        break;
      case SH:
        address = Regs[ra] + immidiate;
        storeHalfword(address, Regs[rb]);
        break;
      case SB:
        address = Regs[ra] + immidiate;
        storeByte(address, Regs[rb]);
        break;
      case BEQ:
        this->pc = (Regs[ra] == Regs[rb]) ? static_cast<uint16_t>(immidiate)
                                          : this->pc;
        break;
      case BNE:
        this->pc = (Regs[ra] != Regs[rb]) ? static_cast<uint16_t>(immidiate)
                                          : this->pc;
        break;
      case BGT:
        this->pc =
            (static_cast<int32_t>(Regs[ra]) > static_cast<uint32_t>(Regs[rb]))
                ? (static_cast<uint16_t>(immidiate))
                : this->pc;
        break;
      case BGE:
        this->pc =
            (static_cast<int32_t>(Regs[ra]) >= static_cast<int32_t>(Regs[rb]))
                ? (static_cast<uint16_t>(immidiate))
                : this->pc;

        break;
      case BGU:
        this->pc = (Regs[ra] > Regs[rb]) ? (static_cast<uint16_t>(immidiate))
                                         : this->pc;
        break;
      case BGEU:
        this->pc = (Regs[ra] >= Regs[rb]) ? (static_cast<uint16_t>(immidiate))
                                          : this->pc;

        break;
      case BC:
        this->pc =
            (this->carry) ? (static_cast<uint16_t>(immidiate)) : this->pc;
        break;
      case B:
        Regs[rd] = helpers::getBit(instruction, 0) ? (this->pc) : Regs[rd];
        this->pc = helpers::getBit(instruction, 1)
                       ? static_cast<uint16_t>(Regs[ra])
                       : static_cast<uint16_t>(immidiate & ~0x3);
        if (helpers::getBit(instruction, 1) && ra == 17)
          this->enable_interrupt = true;
        break;
      default:
        crash(this, "Invalid opcode");
        break;
    }
  }
}

bool Ceespu::load(const char* file_path) {
  FILE* rom = fopen(file_path, "rb");
  if (rom == NULL) {
    std::puts("Failed to open ROM");
    return false;
  }
  fseek(rom, 0, SEEK_END);
  uint64_t rom_size = ftell(rom);
  rewind(rom);
  fread(&this->memory[0], sizeof(char), rom_size, rom);
  fclose(rom);
  return true;
}

void Ceespu::timerInterrupt() {
  this->interrupt = true;
  this->int_vector = 8;
}

void Ceespu::recieveInterrupt(char c) {
  this->interrupt = true;
  this->int_vector = 4;
  this->reveiced_char = c;
}

uint32_t Ceespu::getWord(uint16_t location) const {
  return helpers::swap32(this->memory[helpers::getBits(location, 15, 2)].word);
}

uint16_t Ceespu::getHalfword(uint16_t location) const {
  return helpers::swap16(this->memory[helpers::getBits(location, 15, 2)]
                             .hword[helpers::getBit(location, 1)]);
}

uint8_t Ceespu::getByte(uint16_t location) const {
  return this->memory[helpers::getBits(location, 15, 2)]
      .byte[helpers::getBits(location, 1, 0)];
}

void Ceespu::storeWord(uint16_t location, uint32_t data) {
  this->memory[location >> 2].word = helpers::swap32(data);
  if (location >= CEESPU_COLOUR_MEMORY_OFFSET &&
      location < CEESPU_FONT_MEMORY_OFFSET)
    this->screen->drawChar(*this,
                           ((location - CEESPU_COLOUR_MEMORY_OFFSET) / 2) % 80,
                           ((location - CEESPU_COLOUR_MEMORY_OFFSET) / 2) / 80);
  if (location >= CEESPU_TEXT_MEMORY_OFFSET)
    this->screen->drawChar(*this, (location - CEESPU_TEXT_MEMORY_OFFSET) % 80,
                           (location - CEESPU_TEXT_MEMORY_OFFSET) / 80);
}

void Ceespu::storeHalfword(uint16_t location, uint16_t data) {
  this->memory[location >> 2].hword[location & 2] = helpers::swap16(data);
  if (location >= CEESPU_COLOUR_MEMORY_OFFSET &&
      location < CEESPU_FONT_MEMORY_OFFSET)
    this->screen->drawChar(*this,
                           ((location - CEESPU_COLOUR_MEMORY_OFFSET) / 2) % 80,
                           ((location - CEESPU_COLOUR_MEMORY_OFFSET) / 2) / 80);
  if (location >= CEESPU_TEXT_MEMORY_OFFSET)
    this->screen->drawChar(*this, (location - CEESPU_TEXT_MEMORY_OFFSET) % 80,
                           (location - CEESPU_TEXT_MEMORY_OFFSET) / 80);
}

void Ceespu::storeByte(uint16_t location, uint8_t data) {
  this->memory[location >> 2].byte[location & 3] = data;
  if (location >= CEESPU_COLOUR_MEMORY_OFFSET &&
      location < CEESPU_FONT_MEMORY_OFFSET)
    this->screen->drawChar(*this,
                           ((location - CEESPU_COLOUR_MEMORY_OFFSET) / 2) % 80,
                           ((location - CEESPU_COLOUR_MEMORY_OFFSET) / 2) / 80);
  if (location >= CEESPU_TEXT_MEMORY_OFFSET)
    this->screen->drawChar(*this, (location - CEESPU_TEXT_MEMORY_OFFSET) % 80,
                           (location - CEESPU_TEXT_MEMORY_OFFSET) / 80);
  if (location == 65528) std::putc(data, stdout);
}

void crash(Ceespu* cpu, const char* error) {
  cpu->running = false;
  std::fprintf(stderr, "Error cpu crashed while executing at PC:%04X\nReason: ",
               cpu->pc);
  std::fprintf(stderr, "%s", error);
  input_thread.join();
  std::fprintf(stderr,
               "\nDo you want a detailed dump of proccesor info? [Y/n] ");
  int ans = getchar();
  if (ans != 'Y' && ans != 'y') exit(1);
  std::fprintf(stderr, "Registers:\n");
  for (uint8_t reg = 0; reg < 32; reg++) {
    std::fprintf(stderr, "c%d : %08X\n", reg, cpu->Regs[reg]);
  }
  std::fprintf(stderr, "carryflag : %s\n", cpu->carry ? "on" : "off");
  std::fprintf(stderr, "int_flag : %s\n", cpu->interrupt ? "on" : "off");
  std::fprintf(stderr, "int_vector : %04X\n", unsigned(cpu->int_vector));
  std::fprintf(stderr, "immidiate_flag : %s\n",
               cpu->immidiate_valid ? "on" : "off");
  std::fprintf(stderr, "immidiate : %04X\n", cpu->immidiate_reg);
  std::fprintf(stderr, "Do you want to dump the memory file to disk? [Y/n] ");
  while ((ans = getchar()) != '\n' && ans != EOF) {
  }
  ans = getchar();
  if (ans == 'Y' || ans == 'y') {
    std::fprintf(stderr, "\nDumping ceespu memory to disk....\n");
    FILE* dumpfile = fopen("memdump.bin", "wb");
    fwrite(&cpu->memory[0], sizeof(Memory), CeespuMemorySize, dumpfile);
    std::fprintf(stderr, "Done!\n");
  }
  exit(1);
}

int main(int argc, char** argv) {
  if (argc != 2) {
    std::fprintf(stderr, "Usage: ceespu <ROM file>\n");
    return 1;
  }
#ifdef _WIN32
  uint64_t timer_time;
  uint64_t fps_time;
  QueryUnbiasedInterruptTime(&timer_time);
  fps_time = timer_time;
#endif
#ifdef __linux__
  timespec timer_time, curtime, fps_time;
  clock_gettime(CLOCK_REALTIME, &timer_time);
  fps_time = timer_time;
#endif
  SDL_Event event;
  Ceespu cpu;
  Video screen = Video();
  cpu.init(&screen);
  screen.init();
  if (!cpu.load(argv[1])) {
    exit(1);
  }
  cpu.running = true;
  input_thread = std::thread(receive_input, &cpu);
  uint64_t cycles = 0;
  for (;;) {
#ifdef _WIN32
    uint64_t curtime;
    if (cycles > 1000) {
      QueryUnbiasedInterruptTime(&curtime);
      if ((curtime - timer_time) > 10000) {
        timer_time = curtime;
        cpu.timerInterrupt();
      }
      if ((curtime - fps_time) > 200000) {
        fps_time = curtime;
        screen.update();
      }
      if (SDL_PollEvent(&event)) {
        switch (event.type) {
          case SDL_QUIT:
            exit(0);
          default:
            break;
        }
      }
      cycles = 0;
    }
#endif
#ifdef __linux__
    if (cycles > 1000) {
      clock_gettime(CLOCK_REALTIME, &curtime);
      if ((curtime.tv_nsec - timer_time.tv_nsec) > 1 * 1000 * 1000) {
        timer_time = curtime;
        cpu.timerInterrupt();
      }
      if ((curtime.tv_nsec - fps_time.tv_nsec) > 20 * 1000 * 1000) {
        fps_time = curtime;
        screen.update();
      }
      if (SDL_PollEvent(&event)) {
        switch (event.type) {
          case SDL_QUIT:
            exit(0);
          default:
            break;
        }
      }
      cycles = 0;
    }
#endif
    cpu.emulateCycle();
    cycles++;
  }
}
