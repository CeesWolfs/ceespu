#pragma once

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <string.h>
#include <stdint.h>

#define HASTABLE_SIZE (1 << 16)
#define MAX_TOKENS (1 << 16)
#define MAX_LINE_LEN 256

#define DI_GLOBAL 0
#define DI_SPACE  1
#define DI_CODE   2
#define DI_DATA   3
#define DI_BYTE   4
#define DI_HWORD  5
#define DI_WORD   6
#define DI_ASCII  7
#define DI_EXTERN 8
#define DI_ALIGN  9
#define DI_COMM   10

/* ------------------------------ Error codes --------------------------------*/
#define ERR_NO_ERROR			(0x00)
#define ERR_TK_INV				(0x01)
#define ERR_TK_REG_INV			(0x02)
#define ERR_TK_IMM_INV			(0x03)
#define ERR_TK_SYMBOL_INV		(0x04)
#define ERR_TK_STRING_INV		(0x0A)
#define ERR_MISP_BRACKET		(0x05)		/* Misplaced Brackets	   		  */
#define ERR_MISP_COLON			(0x06)		/* Misplaced Colon	    		  */
#define ERR_MANY_ARG			(0x07)		/* Too many arguments	 	      */
#define ERR_FEW_ARG				(0x08)		/* Too few arguments	 	      */
#define ERR_TYPE_ARG			(0x09)		/* Incorrect argument type 		  */
#define ERR_MISS_INST			(0x10)		/* Missing instruction	    	  */
#define ERR_INV_INST			(0x11)		/* Invalid instruction	    	  */
#define ERR_INV_IMM				(0x12)		/* Invalid size of immediate 	  */
#define ERR_NO_LABEL			(0x13)		/* Label called nonexistent 	  */
#define ERR_DUP_LABEL			(0x14)		/* Duplicated label			 	  */
#define ERR_ZERO_REG			(0x15)		/* Register ZERO set as target 	  */
#define ERR_INV_DIRECT			(0x16)		/* Invalid directive 			  */
#define ERR_HELP_MENU			(0x17)		/* Display Help menu 			  */
#define ERR_VERSION				(0x18)		/* Display assembler's version	  */
#define ERR_ABOUT				(0x19)		/* Display assembler's version 	  */
#define ERR_NO_OUT_NAME			(0x20)		/* Absent output file name 		  */
#define ERR_NO_FILE				(0x21)		/* Absent input file name		  */
#define ERR_MANY_FILE			(0x22)		/* Too many input files			  */
#define ERR_INV_FILE			(0x23)		/* Couldn't find the input file	  */
#define ERR_INV_OUT_FILE		(0x24)		/* Couldn't open the output file  */
#define ERR_ANALYZE_DONE		(0x25)		/* Analysis has finished		  */

/* ---------- Instruction types ------------*/
#define TYPE_A1 (0x00) /* opcode rd, ra, rb */
#define TYPE_A2 (0x01) /* opcode rd, ra     */
#define TYPE_A3 (0x02) /* opcode ra         */
#define TYPE_B0 (0x07)
#define TYPE_B1 (0x03) /* opcode rd, ra, imm*/
#define TYPE_B2 (0x04) /* opcode imm    */
#define TYPE_B3 (0x05) /* opcode rd, imm, ra*/
#define TYPE_B4 (0x06) /* opcode rd, imm, ra*/
 
char * cas_input_file;

const char * reg_table[32];
const char * directive_table[11];

typedef enum token_type {INSTR, REG, IMM, STRING_LITERAL ,LABEL, SYMBOL, DIRECTIVE} token_type;

typedef struct label_to_be_replaced {
	uint16_t address;
	char * value;
} label_to_be_replaced;

typedef struct token_st {
	uint32_t code_line;
	token_type type;
	int value;
	char * value_str;
} token;

typedef struct instr_st {
	uint16_t address;
	uint8_t op;
	uint8_t rd;
	uint8_t ra;
	uint8_t rb;
	uint16_t imm;
	uint16_t funct;
	char * symbol;
} instr;

typedef struct {
    const char* name;
    uint8_t type;
    uint8_t opcode;
    uint16_t funct;
} inst_info;

const inst_info const instr_table[44];
void print_err_msg(uint32_t line, uint8_t error);

