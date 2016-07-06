/*
Copyrigth (c) CeesPU project 2016

cas.c : the entry point for the CeesPu assembler 

Author : Cees Wolfs
Version : v.0.1 3-06-16

*/
#include "hashtable.h"
#include "file_parser.h"
#include "coe_format.h" 
int main(int argc, char **argv)
{
	FILE *assembly;
	FILE *out;
	int coefile;	
	if (argc != 3) {
		printf("Incorrect number of arguments");
		exit(1);
	}
	else {

		// Open I/O files
		// Check that files opened properly

		assembly = fopen(argv[1], "r");
		if (assembly == NULL) {
			printf("Input file could not be opened.");
			exit(1);
		}
		out = fopen(argv[2], "wb");
		if (out == NULL) {
			printf("Output file could not opened.");
			exit(1);
		}
	    size_t optind;
        for (optind = 3; optind < argc && argv[optind][0] == '-'; optind++) {
            switch (argv[optind][1]) {
            case 'c': coefile = 1; break;
            default:
                fprintf(stderr, "Usage: cas [inputfile] [outputfile] [-c for xilinx .coe output] \n");
                exit(EXIT_FAILURE);
            }   
        }
    }
	// !debug

	hashtable_t *reg_instr = ht_create(65536);
	hashtable_t *labels = ht_create(65536);
	int Size;
	unsigned char binary[65536];
	memset(binary, 0, sizeof(binary));
	BuildTable(reg_instr);
	ParseLabels(assembly, labels, binary,&Size);
	ParseFile(assembly, reg_instr, labels, binary);	
	if (!coefile) {
		fwrite(binary, sizeof(char), Size, out);
		return;
	}
	GenerateCoeFile(binary, out);
	getchar();
	
}

