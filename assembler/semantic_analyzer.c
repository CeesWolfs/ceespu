#include "semantic_analyzer.h"

void semantic_analysis(instr* instr_array, int num_instr,
                       label_to_be_replaced* replace_labels,
                       hashtable_t* symbols, char* binary) {
  for (int x = 0; x < num_instr; x++) {
    if (instr_array->symbol) {
      uint16_t val;
      if (ht_get(symbols, instr_array->symbol, &val) == ERR_NO_LABEL) {
        printf("%s %X\n", instr_array->symbol, instr_array->address);
        print_err_msg(0, ERR_NO_LABEL);
      }
      free(instr_array->symbol);
      if ((instr_array->op >> 2) == 0xD) {
        instr_array->rd = val >> 11;
        instr_array->imm = val & 0x3ff;
      } else if ((instr_array->op >> 3) == 0x7) {
        instr_array->rd = val >> 11;
        instr_array->imm = val & 0x3ff;
      } else {
        instr_array->imm = val;
      }
    }
    if (!(instr_array->op && (1 << 5))) {
      if (instr_array->rd == 0) print_err_msg(0, ERR_ZERO_REG);
    }
    instr_array++;
  }
  while (replace_labels->address != 0xffff) {
    int value;
    if (ht_get(symbols, instr_array->symbol, &value) == ERR_NO_LABEL)
      printf("%s %X\n", instr_array->symbol, instr_array->address);
    print_err_msg(0, ERR_NO_LABEL);
    memcpy(binary + replace_labels->address, &value, 2);
  }
}
