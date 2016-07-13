#include "file_parser.h"
#include "tokenizer.h"
/*
Copyrigth (c) CeesPU project 2016

file_parser.c : the file parser for the CeesPu assembler 

Author : Cees Wolfs
Version : v.0.1 3-06-16

*/
struct {
	const char *name;
	short address;
} registerMap[] = {
		{ "c1", 0 },
		{ "c2", 1 },
		{ "c3", 2 },
		{ "c4", 3 },
		{ "c5", 4 },
		{ "c6", 5 },
		{ "c7", 6 },
		{ "c8", 7 },
		{ "c9", 8 },
		{ "c10", 9 },
		{ "c11", 10 },
		{ "c12", 11 },
		{ "c13", 12 },
		{ "c14", 13 },
		{ "c15", 14 },
		{ "r16", 15 },
		{ "c17", 16 },
		{ "c18", 17 },
		{ "c19", 18 },
		{ "c20", 19 },
		{ "c21", 20 },
		{ "c22", 21 },
		{ "c23", 22 },
		{ "c24", 23 },
		{ "c25", 24 },
		{ "c26", 25 },
	    { "c27", 26 },
	    { "c28", 27 },
	    { "c29", 28 },
	    { "c30", 29 },
	    { "c31", 30 },
		{ NULL, 0 } };
struct {
	const char *name;
	unsigned char function;
} AluOp[] = {
	{"add", 0},
	{"adc", 1},
	{"sub", 2},
	{"sbb", 3},
	{"mulh", 4},
	{"mul", 5},
	{"shl", 6},
	{"shr", 7},
	{"and", 8},
	{"or", 9},
	{"xor" ,10},
	{"xnor", 11},
	{"nor", 12},
	{"nand", 13},
	{"not",14},
	{ NULL, 0 }
};
struct {
	const char *name;
	unsigned char function;
} NonAluOp[] = {
	{"mov", 15},
	{"movi", 15},
	{"sw", 0},
	{"lw", 1},
	{"push", 2},
	{"pop", 3},
	{"call", 4},
	{"exit", 10},
	{"je", 8},
	{"jne", 8},
	{"jl", 8},
	{"jle", 8},
	{"jg", 9},
	{"jge", 9},
	{"js", 9},
	{"jns", 9},
	{"jmp", 15},
	{NULL, 0}
};
int IsAlu(char * op) {
	for (int d = 0; d < 15; d++) {
		if (!strcmp(AluOp[d].name, op)) {
			return 1;
		}
	}
	return 0;
}
void BuildTable(hashtable_t *hashtable) {
	for (int i = 0; registerMap[i].name != NULL; i++) { 
		ht_set(hashtable, registerMap[i].name, registerMap[i].address);
	}
	for (int i = 0; AluOp[i].name != NULL; i++) { 
		ht_set(hashtable, AluOp[i].name, AluOp[i].function);
	}
	for (int i = 0; NonAluOp[i].name != NULL; i++) { 
		ht_set(hashtable, NonAluOp[i].name, NonAluOp[i].function);
	}
	return;
}
void ParseEscapeSequences(char * string) {
	char * escape_sequence = strchr(string, '\\');
	while (1)
		{
		    char c;
			char * end;
			end = escape_sequence + 1;
			if (escape_sequence == NULL) {
				break;
			}			
			char es =  *(escape_sequence + 1);
			switch (es) {
			case 'n': c = '\n'; break;
			case 't': c = '\t';  break;
			case '0': c = '\0';  break;
			case 'r': c = '\r'; break;
			case '\\': c = '\\'; break;
			default: c = *(escape_sequence + 1);
			}
			*end = c;
			strcpy(escape_sequence, end);
			escape_sequence = strchr(escape_sequence, '\\');
			if (escape_sequence == NULL) {
				break;
			}	
	}
}
int ParseImmidiate(char * imm)
{
	uint8_t base;
	switch (*imm)
	{
	case '$':
		imm++;
		base = 16;
		break;
	case '%':
		imm++;
		base = 2;
		break;
	default:
		base = 10;
		break;
	}
	return strtol(imm, NULL, base);
}
void ParseLabels(FILE *fp, hashtable_t *labels, unsigned char * binary,  int * Size) {
	char line[256];
	char *tok_ptr, *ret, *token = NULL;
	int32_t line_num = 1;
	int16_t instruction_count = 0x00000000;
	int data_reached = 0;
	while (1) {
		if ((ret = fgets(line, 255, fp)) == NULL)
			break;
		line[255] = 0;

		tok_ptr = line;
		if (strlen(line) == 255) {
			printf("line %d: line is too long. ignoring line ...\n", line_num);
			line_num++;
			continue;
		}
		token = parse_token(tok_ptr, " \n\t,", &tok_ptr, NULL);

			/* blank line or comment begins here. go to the next line */
			if (token == NULL || *token == ';') {
				line_num++;
				free(token);
				continue;
			}
			printf("token: %s\n", token);
			if (token[strlen(token) - 1] == ':') {
				token[strlen(token) - 1] = '\0';
				ht_set(labels, token, instruction_count);
				printf("Found label %s at %d\n", token, instruction_count);
				if (data_reached) {
					token = parse_token(tok_ptr, " \n\t,", &tok_ptr, NULL);
					printf("token %s\n", token);
					if (!strcmp(token,".byte")) {
						token = parse_token(tok_ptr, " \n\t,", &tok_ptr, NULL);
						while (token != NULL)
						{
							uint8_t value = ParseImmidiate(token); 
							memcpy(binary + instruction_count, &value, sizeof(uint8_t));
							instruction_count += sizeof(uint8_t);
							token = parse_token(tok_ptr, " \n\t,", &tok_ptr, NULL);
						}
						continue;
					}
					if (!strcmp(token,".word")) {
						token = parse_token(tok_ptr, " \n\t,", &tok_ptr, NULL);
						while (token != NULL)
						{
							uint16_t value = ParseImmidiate(token); 
							memcpy(binary + instruction_count, &value, sizeof(uint16_t));
							instruction_count += sizeof(uint16_t);
							token = parse_token(tok_ptr, " \n\t,", &tok_ptr, NULL);
						}
						continue;
					}
					if (!strcmp(token,".dword")) {
						token = parse_token(tok_ptr, " \n\t,", &tok_ptr, NULL);
						while (token != NULL)
						{
							uint32_t value = ParseImmidiate(token); 
							memcpy(binary + instruction_count, &value, sizeof(uint32_t));
							instruction_count += sizeof(uint32_t);
							token = parse_token(tok_ptr, " \n\t,", &tok_ptr, NULL);
						}
						continue;
					}
					if (!strcmp(token,".ascii")) {
						token = parse_token(tok_ptr, "\"", &tok_ptr, NULL);
						ParseEscapeSequences(token);
						memcpy(binary + instruction_count, token, strlen(token) + 1);
						instruction_count += strlen(token) + 1;
					}
					continue;
				}
				continue;
			}
			if (!strcmp(token,".data")) {
				data_reached = 1;
				continue;
			}
			if (!strcmp(token, ".text")) {
				data_reached = 0;
				continue;
			}
			if (!data_reached) {
				instruction_count += 4;
				continue;
			}
	}
		rewind(fp);
		*Size = instruction_count;
		return;
}
void ParseFile(FILE * fp,hashtable_t * hashtable, hashtable_t * labels,unsigned char * binary) {
	char line[256];
	char *tok_ptr, *ret, *token = NULL;
	int32_t line_num = 0;
	int16_t instruction_count = 0x00000000;
	int data_reached = 0;
	while (1) {
		if ((ret = fgets(line, 255, fp)) == NULL)
			break;
		line[255] = 0;
		line_num++;
		tok_ptr = line;
		token = parse_token(tok_ptr, " \n\t,", &tok_ptr, NULL);
		if (strlen(line) == 255) {
			printf("line %d: line is too long. ignoring line ...\n", line_num);
			line_num++;
			continue;
		}
		/* blank line or comment begins here. go to the next line */
		if (token == NULL || *token == ';') {
				free(token);
				continue;
			}
		if (token[strlen(token) - 1] == ':') {
			continue;
		}
		if (!strcmp(token, ".data")) {
			data_reached = 1;
			continue;
		}
		if (!strcmp(token, ".text")) {
			data_reached = 0;
			continue;
		}
		if (!data_reached) {
			uint16_t cat, opcode, reg, reg1, reg2, imm = 0;
			uint32_t machine_code;
			if (IsAlu(token)) {
				ht_get(hashtable, token, &opcode);
				token = parse_token(tok_ptr, " \n\t,", &tok_ptr, NULL);
				if (!ht_get(hashtable, token, &reg)) {
					printf("Error line %d wrong operands", line_num);
					exit(0);
				}
				token = parse_token(tok_ptr, " \n\t,", &tok_ptr, NULL);
				if (ht_get(hashtable, token, &reg1)) {
					token = parse_token(tok_ptr, " \n\t,", &tok_ptr, NULL);
					if (ht_get(hashtable, token, &reg2)) {
						cat = 0;
					}
					else {
						imm = ParseImmidiate(token);
						cat = 1;
					}
				}
				else {
					imm = ParseImmidiate(token);
					token = parse_token(tok_ptr, " \n\t,", &tok_ptr, NULL);
					if (ht_get(hashtable, token, &reg1)) {
						cat = 2;
					}
					else {
						printf("Error line %d wrong operands", line_num);
						exit(1);
					}
				}
				if (cat == 0) {
					machine_code = cat;
					machine_code += opcode << 2;
					machine_code += reg2 << 6;
					machine_code += reg1 << 11;
					machine_code += reg << 16;
				}
				else {
					machine_code = cat;
					machine_code += opcode << 2;
					machine_code += reg << 6;
					machine_code += reg1 << 11;
					machine_code += imm << 16;
				}
			}
			else if (ht_get(hashtable, token, &opcode)) {
				cat = 3;
				if (!strcmp("mov", token)) {
					token = parse_token(tok_ptr, " \n\t,", &tok_ptr, NULL);
					if (!ht_get(hashtable, token, &reg)) {
						printf("Error line %d wrong operands", line_num);
						exit(13);
					}
					token = parse_token(tok_ptr, " \n\t,", &tok_ptr, NULL);
					if (!ht_get(hashtable, token, &reg1)) {
						printf("Error line %d wrong operands", line_num);
						exit(13);
					}
					machine_code = 0;
					machine_code += opcode << 2;
					machine_code += reg << 6;
					machine_code += reg1 << 11;
				}
				else if (!strcmp("movi", token)) {
					token = parse_token(tok_ptr, " \n\t,", &tok_ptr, NULL);
					ht_get(hashtable, token, &reg);
					token = parse_token(tok_ptr, " \n\t,", &tok_ptr, NULL);
					imm = ParseImmidiate(token);
					machine_code = 2;
					machine_code += opcode << 2;
					machine_code += reg << 11;					
					machine_code += imm << 16;
				}
				else if (!strcmp("sw", token)) {
					token = parse_token(tok_ptr, " \n\t,", &tok_ptr, NULL);
					if (ht_get(hashtable, token, &reg)) {
						token = parse_token(tok_ptr, " \n\t,", &tok_ptr, NULL);
						ht_get(hashtable, token, &reg1);
						machine_code = cat;
						machine_code += opcode << 2;
						machine_code += reg << 6;
						machine_code += reg1 << 11;
					}
					else if (ht_get(labels, token, &imm)) {
						token = parse_token(tok_ptr, " \n\t,", &tok_ptr, NULL);
						ht_get(hashtable, token, &reg1);
						machine_code = cat;
						machine_code += opcode << 2;
						machine_code += reg1 << 6;
						machine_code += ((imm / 2) + 1) << 16;
					}
					else {
						imm = ParseImmidiate(token);
						token = parse_token(tok_ptr, " \n\t,", &tok_ptr, NULL);
						ht_get(hashtable, token, &reg1);
						machine_code = cat;
						machine_code += opcode << 2;
						machine_code += reg1 << 6;
						machine_code += ((imm / 2) + 1) << 16;
					}
				}
				else if (!strcmp("lw", token)) {
					token = parse_token(tok_ptr, " \n\t,", &tok_ptr, NULL);
					if (ht_get(hashtable, token, &reg)) {
						token = parse_token(tok_ptr, " \n\t,", &tok_ptr, NULL);
						ht_get(hashtable, token, &reg1);
						machine_code = cat;
						machine_code += opcode << 2;
						machine_code += reg << 6;
						machine_code += reg1 << 11;
					}
					else if (ht_get(labels, token, &imm)) {
						token = parse_token(tok_ptr, " \n\t,", &tok_ptr, NULL);
						ht_get(hashtable, token, &reg1);
						machine_code = cat;
						machine_code += opcode << 2;
						machine_code += reg1 << 6;
						machine_code += ((imm / 2) + 1) << 16;
					}
					else {
						imm = ParseImmidiate(token);
						token = parse_token(tok_ptr, " \n\t,", &tok_ptr, NULL);
						ht_get(hashtable, token, &reg1);
						machine_code = cat;
						machine_code += opcode << 2;
						machine_code += reg1 << 6;
						machine_code += ((imm / 2) + 1) << 16;
					}
				}
				else if (!strcmp("push", token))
				{
					token = parse_token(tok_ptr, " \n\t,", &tok_ptr, NULL);
					if (ht_get(hashtable, token, &reg)) {
						machine_code = cat;
						machine_code += opcode << 2;
						machine_code += reg << 6;
					}
					else {
						imm = ParseImmidiate(token);
						machine_code = cat;
						machine_code += opcode << 2;
						machine_code += 1 << 12;
						machine_code += imm << 16;
					}
				}
				else if (!strcmp("pop", token)) {
					token = parse_token(tok_ptr, " \n\t,", &tok_ptr, NULL);
					ht_get(hashtable, token, &reg);
					machine_code = cat;
					machine_code += opcode << 2;
					machine_code += reg << 6;
				}
				else if (!strcmp("call", token)) {
					token = parse_token(tok_ptr, " \n\t,", &tok_ptr, NULL);
					if (ht_get(labels, token, &imm)) {
					}
					else {
						imm = ParseImmidiate(token);
					}
					machine_code = cat;
					machine_code += opcode << 2;
					machine_code += 18 << 6;
					machine_code += (imm / 4) << 16;
				}
				else if (!strcmp("je", token)) {
					token = parse_token(tok_ptr, " \n\t,", &tok_ptr, NULL);
					if (ht_get(labels, token, &imm)) {
					}
					else {
						imm = ParseImmidiate(token);
					}
					token = parse_token(tok_ptr, " \n\t,", &tok_ptr, NULL);
					ht_get(hashtable, token, &reg);
					token = parse_token(tok_ptr, " \n\t,", &tok_ptr, NULL);
					ht_get(hashtable, token, &reg1);
					machine_code = cat;
					machine_code += opcode << 2;
					machine_code += reg << 6;
					machine_code += reg1 << 11;
					machine_code += (imm / 4) << 16;
				}
				else if (!strcmp("jne", token)) {
					token = parse_token(tok_ptr, " \n\t,", &tok_ptr, NULL);
					if (ht_get(labels, token, &imm)) {
					}
					else {
						imm = ParseImmidiate(token);
					}
					token = parse_token(tok_ptr, " \n\t,", &tok_ptr, NULL);
					ht_get(hashtable, token, &reg);
					token = parse_token(tok_ptr, " \n\t,", &tok_ptr, NULL);
					ht_get(hashtable, token, &reg1);
					machine_code = cat;
					machine_code += opcode << 2;
					machine_code += reg << 6;
					machine_code += reg1 << 11;
					machine_code += 1 << 30;
					machine_code += (imm / 4) << 16;
				}
				else if (!strcmp("jle", token)) {
					token = parse_token(tok_ptr, " \n\t,", &tok_ptr, NULL);
					if (ht_get(labels, token, &imm)) {
					}
					else {
						imm = ParseImmidiate(token);
					}
					token = parse_token(tok_ptr, " \n\t,", &tok_ptr, NULL);
					ht_get(hashtable, token, &reg);
					token = parse_token(tok_ptr, " \n\t,", &tok_ptr, NULL);
					ht_get(hashtable, token, &reg1);
					machine_code = cat;
					machine_code += opcode << 2;
					machine_code += reg << 6;
					machine_code += reg1 << 11;
					machine_code += (imm / 4) << 16;
					machine_code += 2 << 30;
				}
				else if (!strcmp("jl", token)) {
					token = parse_token(tok_ptr, " \n\t,", &tok_ptr, NULL);
					if (ht_get(labels, token, &imm)) {
					}
					else {
						imm = ParseImmidiate(token);
					}
					token = parse_token(tok_ptr, " \n\t,", &tok_ptr, NULL);
					ht_get(hashtable, token, &reg);
					token = parse_token(tok_ptr, " \n\t,", &tok_ptr, NULL);
					ht_get(hashtable, token, &reg1);
					machine_code = cat;
					machine_code += opcode << 2;
					machine_code += reg << 6;
					machine_code += reg1 << 11;
					machine_code += 3 << 30;
					machine_code += (imm / 4) << 16;
				}
				else if (!strcmp("jg", token)) {
					token = parse_token(tok_ptr, " \n\t,", &tok_ptr, NULL);
					if (ht_get(labels, token, &imm)) {
					}
					else {
						imm = ParseImmidiate(token);
					}
					token = parse_token(tok_ptr, " \n\t,", &tok_ptr, NULL);
					ht_get(hashtable, token, &reg);
					token = parse_token(tok_ptr, " \n\t,", &tok_ptr, NULL);
					ht_get(hashtable, token, &reg1);
					machine_code = cat;
					machine_code += opcode << 2;
					machine_code += reg << 6;
					machine_code += reg1 << 11;
					machine_code += (imm / 4) << 16;
				}
				else if (!strcmp("jge", token)) {
					token = parse_token(tok_ptr, " \n\t,", &tok_ptr, NULL);
					if (ht_get(labels, token, &imm)) {
					}
					else {
						imm = ParseImmidiate(token);
					}
					token = parse_token(tok_ptr, " \n\t,", &tok_ptr, NULL);
					ht_get(hashtable, token, &reg);
					token = parse_token(tok_ptr, " \n\t,", &tok_ptr, NULL);
					ht_get(hashtable, token, &reg1);
					machine_code = cat;
					machine_code += opcode << 2;
					machine_code += reg << 6;
					machine_code += reg1 << 11;
					machine_code += 1 << 30;
					machine_code += (imm / 4) << 16;
				}
				else if (!strcmp("js", token)) {
					token = parse_token(tok_ptr, " \n\t,", &tok_ptr, NULL);
					if (ht_get(labels, token, &imm)) {
					}
					else {
						imm = ParseImmidiate(token);
					}
					token = parse_token(tok_ptr, " \n\t,", &tok_ptr, NULL);
					ht_get(hashtable, token, &reg);
					token = parse_token(tok_ptr, " \n\t,", &tok_ptr, NULL);
					ht_get(hashtable, token, &reg1);
					machine_code = cat;
					machine_code += opcode << 2;
					machine_code += reg << 6;
					machine_code += reg1 << 11;
					machine_code += 2 << 30;
					machine_code += (imm / 4) << 16;
				}
				else if (!strcmp("jns", token)) {
					token = parse_token(tok_ptr, " \n\t,", &tok_ptr, NULL);
					if (ht_get(labels, token, &imm)) {
					}
					else {
						imm = ParseImmidiate(token);
					}
					token = parse_token(tok_ptr, " \n\t,", &tok_ptr, NULL);
					ht_get(hashtable, token, &reg);
					token = parse_token(tok_ptr, " \n\t,", &tok_ptr, NULL);
					ht_get(hashtable, token, &reg1);
					machine_code = cat;
					machine_code += opcode << 2;
					machine_code += reg << 6;
					machine_code += reg1 << 11;
					machine_code += 3 << 30;
					machine_code += (imm / 4) << 16;
				}
				else if (!strcmp("exit", token)) {
					machine_code = cat;
					machine_code += opcode << 2;
				}
				else if (!strcmp("jmp", token)) {
					token = parse_token(tok_ptr, " \n\t,", &tok_ptr, NULL);
					if (ht_get(hashtable, token, &reg)) {
						machine_code = cat;
					    machine_code += opcode << 2;
						machine_code += reg << 6;
					    machine_code += 1 << 31;
					}
					else if (ht_get(labels, token, &imm)) {
						machine_code = cat;
						machine_code += opcode << 2;
					    machine_code += (imm / 4) << 16;
					}
					else {
						imm = ParseImmidiate(token);
						machine_code = cat;
						machine_code += opcode << 2;
					    machine_code += (imm / 4) << 16;
					}
					
				}
			}
			else {
				printf("Error unkwown mnenomic line %d", line_num);
				exit(1);
			}
			memcpy(binary + instruction_count, &machine_code, sizeof(uint32_t));
			instruction_count += 4;
		}
	}

}
