#include "lexical_analyzer.h"

void lexical_analysis(FILE * file, token * tk_array)
{
	uint32_t code_count = 0;
	uint32_t inst_count;
	lexer_list* line_lexicons = malloc(sizeof(lexer_list)); 
	token *cur_token = tk_array;
	void *to_free;
	char line[MAX_LINE_LEN];
	while (fgets(line, sizeof line, file) != NULL) {
		code_count++;
		line_lexicons = string_tokenizer(line, (char*)" ,()\n\t");
		if (line_lexicons == NULL) { //Empty line
			continue;
		}
		if (*line_lexicons->lexer == ';') { //Line is a comment .. go to the next line
			continue;
		}
		while (line_lexicons) {
			cur_token->code_line = code_count;
			if (line_lexicons->lexer[strlen(line_lexicons->lexer) - 1] == ':') { //Label
				line_lexicons->lexer[strlen(line_lexicons->lexer) - 1] = NULL;
				cur_token->type = LABEL;
				cur_token->value_str = line_lexicons->lexer;
				goto next_loop;
			}
			else if (*line_lexicons->lexer == ';') { // Comment go to next line
				break;
			}
			else if (*line_lexicons->lexer == '"') { //String literal
				cur_token->type = STRING_LITERAL;
				if (line_lexicons->lexer[strlen(line_lexicons->lexer) - 1] != '"')
					print_err_msg(code_count, ERR_TK_STRING_INV);
				line_lexicons->lexer++;
				line_lexicons->lexer[strlen(line_lexicons->lexer) - 1] = '\0';
				cur_token->value_str = line_lexicons->lexer;
				string_unescaper(cur_token->value_str);
				goto next_loop;
			}
			else if (*line_lexicons->lexer == '.') { //Assembler directive
				cur_token->type = DIRECTIVE;
				for (int i = 0; i < 10; i++) {
					if (strcmp(line_lexicons->lexer, directive_table[i]) == ERR_NO_ERROR) {
						cur_token->value = i;
						goto clean_next_loop;
					}
				}
				print_err_msg(code_count, ERR_INV_DIRECT);
			}
			else {
				for (int i = 0; i < 32; i++) { //Register name
					if (strcmp(line_lexicons->lexer, reg_table[i]) == ERR_NO_ERROR) {
						cur_token->type = REG;
						cur_token->value = i;
						goto clean_next_loop;
					}
				}

				for (int i = 0; i < 47; i++) { //Instruction name
					if (strcmp(line_lexicons->lexer, instr_table[i].name) == ERR_NO_ERROR) {
						cur_token->type = INSTR;
						cur_token->value = i;
						goto clean_next_loop;
					}
				}
				if (*line_lexicons->lexer == '+' | *line_lexicons->lexer == '-' | isdigit(*line_lexicons->lexer)) { //Immidiate
					int imm_value;
					char* endptr;
					imm_value = strtol(line_lexicons->lexer, &endptr, 0);
					imm_value += strtol(endptr, &endptr, 0);
					if((line_lexicons->lexer + strlen(line_lexicons->lexer) - endptr) == 0){
						cur_token->value = imm_value;
						cur_token->type = IMM;
						goto clean_next_loop;
					}
					print_err_msg(code_count, ERR_TK_IMM_INV);
				}
				if (strlen(line_lexicons->lexer) <= 31) {//Label
					for (int i = 0; i < strlen(line_lexicons->lexer); i++) {
						if (*(line_lexicons->lexer + i) != '+' && *(line_lexicons->lexer + i) != '-' && *(line_lexicons->lexer + i) != '.' && *(line_lexicons->lexer + i) != '_' && isalnum(*(line_lexicons->lexer + i)) == 0)
							print_err_msg(code_count, ERR_TK_INV);
					}
					cur_token->type = SYMBOL;
					cur_token->value_str = line_lexicons->lexer;
					goto next_loop;
				}
				else {
					print_err_msg(code_count, ERR_TK_SYMBOL_INV); //Invalid symbol
				}
			}
		clean_next_loop:
			free(line_lexicons->lexer);
		next_loop:
			cur_token++;
			to_free = line_lexicons;
			line_lexicons = line_lexicons->next;
			free(to_free);
		}
	}
	*cur_token++ = (token) { 0, 0, 0, 0 };
}

lexer_list* string_tokenizer(char* str, char* delim) {
        char* tok;
	char *quote = strchr(str, '"');
	char *second_quote;
	char *escaped_string;
        lexer_list* list = NULL;
        lexer_list *cur_list, *next_list;
	if (quote) {
		escaped_string = malloc(strlen(str));
		second_quote = strchr(quote + 1, '"');
		if (!second_quote)
			print_err_msg(0, ERR_TK_STRING_INV);
		*(second_quote + 1) = '\0';
		strcpy(escaped_string, quote);
		*(quote + 1) = '\0';
	}
    /* Extract a token from the string str*/
	tok = strtok(str, delim);
	
	while (tok != NULL) {
		/* For each token, create a new node and insert it in the string list*/
		next_list = (lexer_list*)malloc(sizeof(lexer_list));
		next_list->next = 0;
		next_list->lexer = (char*)malloc(strlen(tok) + 1);
		strcpy(next_list->lexer, tok);

		if (*tok == '"') {
			free(next_list->lexer);
			next_list->lexer = escaped_string;
		}

		/* Adding first token to the list */
		if (list == NULL)
			list = next_list;
		/* Connecting the token to the last token of the list */
		else
			cur_list->next = next_list;
		/* Updating state variables */
		cur_list = next_list;
		tok = strtok(NULL, delim);
	}
    return list;
}

void string_unescaper(char * string) {
	if (string == NULL) {
		return;
	}
	char * escape_sequence = strchr(string, '\\');
	while (escape_sequence)
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
	}
}
