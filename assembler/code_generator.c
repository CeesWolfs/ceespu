#include "code_generator.h"

void code_generation(instr* instr_array, int num_instr, char* binary) {
  uint32_t instruction;
  for (int x = 0; x < num_instr; x++) {
    instruction = 0;
    instruction += instr_array->op << 26;
    instruction += instr_array->rd << 21;
    instruction += instr_array->ra << 16;
    instruction += instr_array->rb << 11;
    instruction += instr_array->imm;
    instruction += instr_array->funct;
    memcpy(binary + instr_array->address, &instruction, sizeof(uint32_t));
    instr_array++;
  }
}
