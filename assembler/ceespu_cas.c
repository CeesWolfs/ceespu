// ceespu-cas.cpp : Defines the entry point for the console application.
//

#include "ceespu_cas.h"
#include "lexical_analysis.h"
#include "parser.h"
#include "semantic_analyzer.h"
#include "code_generator.h"
#include "hashtable.h"

const char * reg_table[32] = {
	"c0","c1","c2","c3","c4","c5","c6","c7",
	"c8","c9","c10","c11","c12","c13","c14","c15",
	"c16","c17","csp","clr","c20","c21","c22","c23",
	"c24","c25","c26","c27","c28","c29","c30","c31"
};

const inst_info const instr_table[44] = {
	{"add", TYPE_A1, 0x00, 0x0000},
	{"adc", TYPE_A1, 0x01, 0x0000},
	{"sub", TYPE_A1, 0x02, 0x0000},
	{"sbb", TYPE_A1, 0x03, 0x0000},
	{"or",  TYPE_A1, 0x04, 0x0000},
	{"and", TYPE_A1, 0x05, 0x0000},
	{"xor", TYPE_A1, 0x06, 0x0000},
	{"shl", TYPE_A1, 0x08, 0x0000},
	{"shr", TYPE_A1, 0x08, 0x0040},
	{"sar", TYPE_A1, 0x08, 0x0080},
	{"mul", TYPE_A1, 0x09, 0x0000},

	{"seb", TYPE_A2, 0x07, 0x0000},
	{"seh", TYPE_A2, 0x07, 0x0001},

	{"addi", TYPE_B0, 0x10, 0x0000},
	{"adci", TYPE_B0, 0x11, 0x0000},
	{"subi", TYPE_B0, 0x12, 0x0000},
	{"sbbi", TYPE_B0, 0x13, 0x0000},
	{"ori",  TYPE_B0, 0x14, 0x0000},
	{"andi", TYPE_B0, 0x15, 0x0000},
	{"xori", TYPE_B0, 0x16, 0x0000},
	{"shli", TYPE_B0, 0x18, 0x0000},
	{"shri", TYPE_B0, 0x18, 0x0040},
	{"sari", TYPE_B0, 0x18, 0x0080},
	{"muli", TYPE_B0, 0x19, 0x0000},

	{"imm", TYPE_B2, 0x2A, 0x0000},
	{"int", TYPE_B2, 0x2B, 0x0000},

	{"lw",  TYPE_B3, 0x20, 0x0000},
	{"lh",  TYPE_B3, 0x21, 0x0000},
	{"lb",  TYPE_B3, 0x22, 0x0000},
	{"lhu", TYPE_B3, 0x23, 0x0000},
	{"lbu", TYPE_B3, 0x24, 0x0000},
	{"sw",  TYPE_B4, 0x34, 0x0000},
	{"sh",  TYPE_B4, 0x35, 0x0000},
	{"sb",  TYPE_B4, 0x36, 0x0000},
	{"beq", TYPE_B1, 0x38, 0x0000},
	{"bne", TYPE_B1, 0x39, 0x0000},
	{"bgu", TYPE_B1, 0x3A, 0x0000},
	{"bgeu",TYPE_B1, 0x3B, 0x0000},
	{"bg",  TYPE_B1, 0x3C, 0x0000},
	{"bge", TYPE_B1, 0x3D, 0x0000},
	{"bc",  TYPE_B1, 0x3E, 0x0000},
	{"b",   TYPE_B2, 0x3F, 0x0000},
	{"bx",  TYPE_A3, 0x3F, 0x0002},
	{"call",TYPE_B2, 0x3F, 0x0001}
};

const char * directive_table[11] = {
	".globl", ".space", ".text", ".data",
	".byte", ".hword", ".word", ".ascii",
	".extern", ".align", ".comm"
};

void print_err_msg(uint32_t line, uint8_t error) {
	if (line > 0)
		fprintf(stderr, "line %d:\n", line);
	switch (error)
	{
	case ERR_TK_INV:
		fprintf(stderr, "lexical error -> invalid token\n");
		break;
	case ERR_TK_REG_INV:
		fprintf(stderr, "lexical error -> invalid register name\n");
		break;
	case ERR_TK_IMM_INV:
		fprintf(stderr, "lexical error -> invalid immidiate\n");
		break;
	case ERR_INV_DIRECT:
		fprintf(stderr, "lexical error -> invalid directive\n");
		break;
	case ERR_TK_SYMBOL_INV:
		fprintf(stderr, "lexical error -> invalid symbol\n");
		break;
	case ERR_TK_STRING_INV:
		fprintf(stderr, "lexical error -> invalid string literal\n");
		break;
	case ERR_INV_INST:
		fprintf(stderr, "syntax error -> invalid instruction\n");
		break;
	case ERR_TYPE_ARG:
		fprintf(stderr, "syntax error -> wrong argument type\n");
		break;
	case ERR_MANY_ARG:
		fprintf(stderr, "syntax error -> too many arguments\n");
		break;
	case ERR_INV_IMM:
		fprintf(stderr, "syntax error -> invalid size of immidiate\n");
		break;
	case ERR_DUP_LABEL:
		fprintf(stderr, "semantic error -> duplicate label found\n");
		break;
	case ERR_NO_LABEL:
		fprintf(stderr, "semantic error -> non existent label referenced\n");
		break;
	case ERR_ZERO_REG:
		fprintf(stderr, "semantic error -> register zero as target register\n");
		break;
	default: break;
	}
	exit(1);
}

int main(int argc, char ** argv)
{
    FILE *infile;
	FILE *out;
	token * tk_array = malloc(sizeof(token) * MAX_TOKENS);
	instr * instr_array = malloc(sizeof(instr) * (1 << 14));
	hashtable_t * labels = ht_create(HASTABLE_SIZE);
	label_to_be_replaced * replace_labels = malloc(sizeof(label_to_be_replaced) * 100);
	char * binary = calloc(1, 65536);
	char * outstring;
	if (argc < 2) {
		fprintf(stderr, "Error no input file\nUsage: ceespu-cas <inputfile>");
		return;
	}
	infile = fopen(argv[1], "r");
	if (!infile) {
		fprintf(stderr, "Error input file couldn't be opened");
		return;
	}
	cas_input_file = argv[1];
	outstring = malloc(strlen(argv[1]) + 4);
	strcpy(outstring, argv[1]);
	strcat(outstring,".bin");
	lexical_analysis(infile, tk_array);
	int num_instr = parse(tk_array, instr_array, labels, replace_labels, binary);
	semantic_analysis(instr_array, num_instr, replace_labels, labels, binary);
	code_generation(instr_array, num_instr, binary);
	out = fopen(outstring, "wb");
	fwrite(binary, sizeof(char), 65536, out);
	free(tk_array);
	free(instr_array);
	free(labels->table);
	free(binary);
}

