#pragma once
#include <stdio.h>
#include <string.h>
#include "hashtable.h"

void BuildTable(hashtable_t * hashtable);
void ParseLabels(FILE * infile, hashtable_t *labels, unsigned char * binary, int * Size);
void ParseFile(FILE * infile, hashtable_t *hashtable, hashtable_t *labels, unsigned char * binary);
void ParseEscapeSequences(char * string);
long ParseImmidiate(char * imm);
int IsAlu(char * op);
