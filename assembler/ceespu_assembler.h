// Copyright 2018 <Cees Wolfs>

#ifndef CEESPU_ASSEMBLER_H
#define CEESPU_ASSEMBLER_H

#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <elfio/elfio.hpp>
#include <iostream>
#include <string>
#include <string_view>
#include <unordered_map>
#include <vector>
#define MAX_LINE_LENGTH 120

const uint64_t invalid_directive = 0xC0C0C0C0C0C0C0C0;
const uint64_t invalid_immidiate = 0xC0C0C0C0C0C0C0C0;
enum { A0, A1, A2, A3, B0, B1, B2, B3, B4, B5 };

enum {
  ASCII = 0,
  BYTE = 1,
  COMM = 2,
  DATA = 3,
  EXTERN = 4,
  FILE_D = 5,
  GLOBL = 6,
  IDENT = 8,
  HWORD = 7,
  ALIGN = 9,
  SECTION = 10,
  SIZE = 11,
  SPACE = 12,
  TEXT = 13,
  TYPE = 14,
  WORD = 15,
  INVALID = 0xff
};

char directives[][8] = {"ascii", "byte",  "comm",  "data",    "extern",  "file",
                        "globl", "hword", "ident", "p2align", "section", "size",
                        "space", "text",  "type",  "word"};
typedef struct Label {
  uint16_t offset;
  uint8_t type;
  Label* base_label;
} Label;

enum {
  LABEL_GLOBL = 0x01,
  LABEL_UNDEFINED = 0x04,
  LABEL_LOCAL = 0x00,
  LABEL_EXTERN = 0x02
};

typedef struct Relocation {
  std::string label;
  uint16_t offset;
  uint8_t type;
} Relocation;

enum { REL_LO16 = 1, REL_LO12 = 2 };

struct InstructionInfo {
  char Mnemonic[5];
  uint8_t Type;
  uint8_t Opcode;
  uint8_t FuncCode;
};

const InstructionInfo invalid_instruction = {
    {-1, -1, -1, -1, -1}, 0xff, 0xff, 0xff};

InstructionInfo instr[] = {{{'a', 'd', 'c', 0, 0}, A0, (0x01), 0},
                           {{'a', 'd', 'd', 0, 0}, A0, (0x00), 0},
                           {{'a', 'd', 'c', 'i', 0}, B0, (0x11), 0},
                           {{'a', 'd', 'd', 'i', 0}, B0, (0x10), 0},
                           {{'a', 'n', 'd', 0, 0}, A0, (0x05), 0},
                           {{'a', 'n', 'd', 'i', 0}, A0, (0x15), 0},
                           {{'b', 0, 0, 0, 0}, B2, (0x3F), 0},
                           {{'b', 'c', 0, 0, 0}, B2, (0x3E), 0},
                           {{'b', 'e', 'q', 0, 0}, B1, (0x38), 0},
                           {{'b', 'g', 0, 0, 0}, B1, (0x3C), 0},
                           {{'b', 'g', 'e', 0, 0}, B1, (0x3D), 0},
                           {{'b', 'g', 'e', 'u', 0}, B1, (0x3B), 0},
                           {{'b', 'g', 'u', 0, 0}, B1, (0x3A), 0},
                           {{'b', 'n', 'e', 0, 0}, B1, (0x39), 0},
                           {{'b', 'x', 0, 0, 0}, A3, (0x3F), 0x02},
                           {{'c', 'a', 'l', 'l', 0}, B2, (0x3F), 0x01},
                           {{'l', 'b', 0, 0, 0}, B3, (0x22), 0},
                           {{'l', 'b', 'u', 0, 0}, B3, (0x24), 0},
                           {{'l', 'h', 0, 0, 0}, B3, (0x21), 0},
                           {{'l', 'h', 'u', 0, 0}, B3, (0x23), 0},
                           {{'l', 'w', 0, 0, 0}, B3, (0x20), 0},
                           {{'m', 'u', 'l', 0, 0}, A0, (0x09), 0},
                           {{'m', 'u', 'l', 'i', 0}, B0, (0x19), 0},
                           {{'o', 'r', 0, 0, 0}, A0, (0x04), 0},
                           {{'o', 'r', 'i', 0, 0}, B0, (0x14), 0},
                           {{'s', 'a', 'r', 0, 0}, A0, (0x08), 0x80},
                           {{'s', 'a', 'r', 'i', 0}, B0, (0x18), 0x80},
                           {{'s', 'b', 0, 0, 0}, B4, (0x36), 0},
                           {{'s', 'b', 'b', 0, 0}, A0, (0x03), 0},
                           {{'s', 'b', 'b', 'i', 0}, B0, (0x13), 0},
                           {{'s', 'e', 'b', 0, 0}, A2, (0x07), 0},
                           {{'s', 'e', 'h', 0, 0}, A2, (0x07), 0x01},
                           {{'s', 'e', 't', 'i', 0}, B5, (0x2A), 0},
                           {{'s', 'h', 0, 0, 0}, B4, (0x35), 0},
                           {{'s', 'h', 'l', 0, 0}, A0, (0x08), 0},
                           {{'s', 'h', 'l', 'i', 0}, B0, (0x18), 0},
                           {{'s', 'h', 'r', 0, 0}, A0, (0x08), 0x40},
                           {{'s', 'h', 'r', 'i', 0}, B0, (0x18), 0x40},
                           {{'s', 'u', 'b', 0, 0}, A0, (0x02), 0},
                           {{'s', 'u', 'b', 'i', 0}, B0, (0x12), 0},
                           {{'s', 'w', 0, 0, 0}, B4, (0x34), 0},
                           {{'x', 'o', 'r', 0, 0}, A0, (0x06), 0},
                           {{'x', 'o', 'r', 'i', 0}, B0, (0x16), 0}};

const int nInstrs = sizeof(instr) / sizeof(InstructionInfo);
const int nDirect = sizeof(directives) / sizeof(directives[0]);
#endif  // CEESPU_ASSEMBLER_H
