#pragma once
#include "ceespu_cas.h"
#include <ctype.h>

typedef struct lexer_list_st {
  char *lexer;
  struct lexer_list_st *next;
} lexer_list;

void lexical_analysis(FILE *file, token *tk_array);
lexer_list *string_tokenizer(char *str, char *delim);
void string_unescaper(char *string);
void print_lexer_list(lexer_list *tokens);
