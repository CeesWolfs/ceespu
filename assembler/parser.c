#include "parser.h"

int roundUp(int n) {
  return ((n & 0x3) == 0) ? n
                          : n + 4 & ~0x3;  // Make sure labels are word aligned
}

int parse(token* tk_array, instr* instr_array, hashtable_t* labels,
          label_to_be_replaced* replace_labels, char* binary) {
  token* cur_token = tk_array;
  int num_instr = 0;
  uint32_t memory_index = 0;
  while (cur_token->code_line != 0) {
    if (cur_token->type == INSTR) {
      instr_array->op = instr_table[cur_token->value].opcode;
      instr_array->funct = instr_table[cur_token->value].funct;
      instr_array->address = memory_index;
      instr_array->symbol = NULL;
      instr_array->rd = 0;
      instr_array->ra = 0;
      instr_array->rb = 0;
      instr_array->imm = 0;
      switch (instr_table[cur_token->value].type) {
        case TYPE_A1:
          for (int x = 0; x < 3; x++) {
            cur_token++;
            if (cur_token->type != REG)
              print_err_msg(cur_token->code_line, ERR_TYPE_ARG);
            if (x == 0) instr_array->rd = cur_token->value;
            if (x == 1) instr_array->ra = cur_token->value;
            if (x == 2) instr_array->rb = cur_token->value;
          }
          if ((cur_token + 1)->type == REG | (cur_token + 1)->type == IMM |
              (cur_token + 1)->type == SYMBOL)
            print_err_msg(cur_token->code_line, ERR_MANY_ARG);
          break;
        case TYPE_A2:
          for (int x = 0; x < 2; x++) {
            cur_token++;
            if (cur_token->type != REG)
              print_err_msg(cur_token->code_line, ERR_TYPE_ARG);
            if (x == 0) instr_array->rd = cur_token->value;
            if (x == 1) instr_array->ra = cur_token->value;
          }
          if ((cur_token + 1)->type == REG | (cur_token + 1)->type == IMM |
              (cur_token + 1)->type == SYMBOL)
            print_err_msg(cur_token->code_line, ERR_MANY_ARG);
          break;
        case TYPE_A3:
          cur_token++;
          if (cur_token->type != REG)
            print_err_msg(cur_token->code_line, ERR_TYPE_ARG);
          if (instr_array->op >> 3 == 0x7)
            instr_array->ra = cur_token->value;
          else
            instr_array->rd = cur_token->value;
          if ((cur_token + 1)->type == REG | (cur_token + 1)->type == IMM |
              (cur_token + 1)->type == SYMBOL)
            print_err_msg(cur_token->code_line, ERR_MANY_ARG);
          break;
        case TYPE_B0:
          for (int x = 0; x < 2; x++) {
            cur_token++;
            if (cur_token->type != REG)
              print_err_msg(cur_token->code_line, ERR_TYPE_ARG);
            if (x == 0) instr_array->rd = cur_token->value;
            if (x == 1) instr_array->ra = cur_token->value;
          }
          cur_token++;
          if (cur_token->type == IMM) {
            instr_array->imm = cur_token->value;

          } else if (cur_token->type == SYMBOL) {
            instr_array->symbol = cur_token->value_str;
          } else {
            print_err_msg(cur_token->code_line, ERR_TYPE_ARG);
          }
          if ((cur_token + 1)->type == REG && instr_array->rb == 0) {
            cur_token++;
            instr_array->rb = cur_token->value;
          }
          if ((cur_token + 1)->type == REG | (cur_token + 1)->type == IMM |
              (cur_token + 1)->type == SYMBOL)
            print_err_msg(cur_token->code_line, ERR_MANY_ARG);
          break;
        case TYPE_B1:
          for (int x = 0; x < 2; x++) {
            cur_token++;
            if (cur_token->type != REG)
              print_err_msg(cur_token->code_line, ERR_TYPE_ARG);
            if (x == 0) instr_array->ra = cur_token->value;
            if (x == 1) instr_array->rb = cur_token->value;
          }
          cur_token++;
          if (cur_token->type == IMM) {
            instr_array->imm = cur_token->value;

          } else if (cur_token->type == SYMBOL) {
            instr_array->symbol = cur_token->value_str;
          } else {
            print_err_msg(cur_token->code_line, ERR_TYPE_ARG);
          }
          if ((cur_token + 1)->type == REG && instr_array->rb == 0) {
            cur_token++;
            instr_array->rb = cur_token->value;
          }
          if ((cur_token + 1)->type == REG | (cur_token + 1)->type == IMM |
              (cur_token + 1)->type == SYMBOL)
            print_err_msg(cur_token->code_line, ERR_MANY_ARG);
          break;
        case TYPE_B2:
          cur_token++;
          if (cur_token->type == IMM) {
            instr_array->imm = cur_token->value;

          } else if (cur_token->type == SYMBOL) {
            instr_array->symbol = cur_token->value_str;
          } else {
            print_err_msg(cur_token->code_line, ERR_TYPE_ARG);
          }
          if ((cur_token + 1)->type == REG | (cur_token + 1)->type == IMM |
              (cur_token + 1)->type == SYMBOL)
            print_err_msg(cur_token->code_line, ERR_MANY_ARG);
          break;
        case TYPE_B3:
          cur_token++;
          if (cur_token->type != REG)
            print_err_msg(cur_token->code_line, ERR_TYPE_ARG);
          instr_array->rd = cur_token->value;
          cur_token++;
          if (cur_token->type == IMM) {
            instr_array->imm = cur_token->value;
            if ((cur_token + 1)->type == REG) {
              cur_token++;
              instr_array->ra = cur_token->value;
              if ((cur_token + 1)->type == REG | (cur_token + 1)->type == IMM |
                  (cur_token + 1)->type == SYMBOL)
                print_err_msg(cur_token->code_line, ERR_MANY_ARG);
            }
          } else if (cur_token->type == SYMBOL) {
            instr_array->symbol = cur_token->value_str;
            if ((cur_token + 1)->type == REG) {
              cur_token++;
              instr_array->ra = cur_token->value;
              if ((cur_token + 1)->type == REG | (cur_token + 1)->type == IMM |
                  (cur_token + 1)->type == SYMBOL)
                print_err_msg(cur_token->code_line, ERR_MANY_ARG);
            }
          } else if (cur_token->type == REG) {
            instr_array->ra = cur_token->value;
            if ((cur_token + 1)->type == REG | (cur_token + 1)->type == IMM |
                (cur_token + 1)->type == SYMBOL)
              print_err_msg(cur_token->code_line, ERR_MANY_ARG);
          } else
            print_err_msg(cur_token->code_line, ERR_TYPE_ARG);
          break;
        case TYPE_B4:
          cur_token++;
          if (cur_token->type != REG)
            print_err_msg(cur_token->code_line, ERR_TYPE_ARG);
          instr_array->rb = cur_token->value;
          cur_token++;
          if (cur_token->type == IMM) {
            instr_array->imm = cur_token->value & 0x3ff;
            instr_array->rd = cur_token->value >> 11;
            if ((cur_token + 1)->type == REG) {
              cur_token++;
              instr_array->ra = cur_token->value;
              if ((cur_token + 1)->type == REG | (cur_token + 1)->type == IMM |
                  (cur_token + 1)->type == SYMBOL)
                print_err_msg(cur_token->code_line, ERR_MANY_ARG);
            }
          } else if (cur_token->type == SYMBOL) {
            instr_array->symbol = cur_token->value_str;
            if ((cur_token + 1)->type == REG) {
              cur_token++;
              instr_array->ra = cur_token->value;
              if ((cur_token + 1)->type == REG | (cur_token + 1)->type == IMM |
                  (cur_token + 1)->type == SYMBOL)
                print_err_msg(cur_token->code_line, ERR_MANY_ARG);
            }
          } else if (cur_token->type == REG) {
            instr_array->ra = cur_token->value;
            if ((cur_token + 1)->type == REG | (cur_token + 1)->type == IMM |
                (cur_token + 1)->type == SYMBOL)
              print_err_msg(cur_token->code_line, ERR_MANY_ARG);
          } else
            print_err_msg(cur_token->code_line, ERR_TYPE_ARG);
          break;
        default:
          break;
      }
      memory_index += 4;
      num_instr++;
      instr_array++;
      goto next_token;
    }
    if (cur_token->type == LABEL) {
      memory_index = roundUp(memory_index);
      if (ht_set(labels, cur_token->value_str, memory_index) == ERR_DUP_LABEL)
        print_err_msg(cur_token->code_line, ERR_DUP_LABEL);
      printf("label %s found at 0x%X\n", cur_token->value_str, memory_index);
      goto next_token;
    }
    if (cur_token->type == DIRECTIVE) {
      switch (cur_token->value) {
        case DI_GLOBAL:
        case DI_EXTERN:
          cur_token++;
          break;
        case DI_SPACE:
          cur_token++;
          if (cur_token->type != IMM)
            print_err_msg(cur_token->code_line, ERR_TYPE_ARG);
          memory_index += cur_token->value;
          break;
        case DI_CODE:
        case DI_DATA:
          break;
        case DI_BYTE:
          if ((cur_token + 1)->type != IMM)
            print_err_msg(cur_token->code_line, ERR_TYPE_ARG);
          while ((cur_token + 1)->type == IMM) {
            cur_token++;
            if ((unsigned)cur_token->value > UINT8_MAX)
              print_err_msg(cur_token->code_line, ERR_INV_IMM);
            binary[memory_index] = cur_token->value;
            memory_index++;
          }
          break;
        case DI_HWORD:
          if ((cur_token + 1)->type != IMM && (cur_token + 1)->type != SYMBOL)
            print_err_msg(cur_token->code_line, ERR_TYPE_ARG);
          while ((cur_token + 1)->type == IMM |
                 (cur_token + 1)->type == SYMBOL) {
            cur_token++;
            if (cur_token->type == REG) {
              if ((unsigned)cur_token->value > UINT16_MAX)
                print_err_msg(cur_token->code_line, ERR_INV_IMM);
              memcpy(binary + memory_index, &cur_token->value, 2);
            }
            if (cur_token->type == SYMBOL) {
              replace_labels->address = memory_index;
              replace_labels->value = cur_token->value_str;
              replace_labels++;
            }
            memory_index += 2;
          }
          break;
        case DI_WORD:
          if ((cur_token + 1)->type != IMM)
            print_err_msg(cur_token->code_line, ERR_TYPE_ARG);
          while ((cur_token + 1)->type == IMM) {
            cur_token++;
            memcpy(binary + memory_index, &cur_token->value, 4);
            memory_index += 4;
          }
          break;
        case DI_ASCII:
          cur_token++;
          if (!cur_token->value_str)
            print_err_msg(cur_token->code_line, ERR_TYPE_ARG);
          memcpy(binary + memory_index, cur_token->value_str,
                 strlen(cur_token->value_str) + 1);
          memory_index += strlen(cur_token->value_str) + 1;
          break;
        case DI_ALIGN:
          cur_token++;
          memory_index = roundUp(memory_index);
          break;
        case DI_COMM:
          cur_token++;
          if (!cur_token->value_str)
            print_err_msg(cur_token->code_line, ERR_TYPE_ARG);
          if (ht_set(labels, cur_token->value_str, memory_index) ==
              ERR_DUP_LABEL)
            print_err_msg(cur_token->code_line, ERR_DUP_LABEL);
          printf("label %s found at 0x%X\n", cur_token->value_str,
                 memory_index);
          cur_token++;
          if (!cur_token->type == IMM) {
            print_err_msg(cur_token->code_line, ERR_TYPE_ARG);
          }
          int num = cur_token->value;
          cur_token++;
          if (!cur_token->type == IMM) {
            print_err_msg(cur_token->code_line, ERR_TYPE_ARG);
          }
          int Size = cur_token->value;
          memory_index += Size * num;
        default:
          break;
      }
      goto next_token;
    }
    if (cur_token->type == REG | cur_token->type == SYMBOL |
        cur_token->type == IMM) {
      print_err_msg(cur_token->code_line, ERR_INV_INST);
    }
  next_token:
    cur_token++;
  }
  replace_labels->address = -1;
  // printf("number of tokens = %d", (cur_token - tk_array));
  return num_instr;
}
