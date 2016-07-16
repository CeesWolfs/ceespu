/*
Copyrigth (c) CeesPU project 2016

ceespu.c : the entry point for the CeesPu emulator 

Author : Cees Wolfs
Version : v.0.1 4-07-16

*/

#include "stdio.h"
#include "stdlib.h"
#include "string.h"
#include "emulator.h"

static inline unsigned short run_alu_op(short alu_op, short alu1, short alu2, short cin) {
	switch (alu_op) {
	        case 0: return alu1 + alu2;
		case 1: return alu1 + alu2 + cin;
	        case 2: return alu1 - alu2;
		case 3: return alu1 - alu2 - cin;
		case 4: return (int)(alu1 * alu2) >> 16;
		case 5: return alu1 * alu2;
		case 6: return alu1 << alu2;
		case 7: return alu1 >> alu2;
		case 8: return alu1 & alu2;
		case 9: return alu1 | alu2;
		case 10: return alu1 ^ alu2;
		case 11: return ~(alu1 ^ alu2);
		case 12: return ~(alu1 | alu2);
		case 13: return ~(alu1 & alu2);
		case 14: return ~alu1;
		case 15: return alu1;
	}
}

static inline unsigned char take_jump(unsigned char branch_condition, unsigned short a, unsigned short b) {
    switch (branch_condition){
   	    case 0: return (a == b);
   	    case 1: return (a != b);
   	    case 2: return (a <= b);
   	    case 3: return (a < b);
   	    case 4: return (a > b);
   	    case 5: return (a >= b);
   	    case 6: return (a && (1 << 15));
   	    case 7: return !(a && (1 << 15));
    }
}


static inline unsigned short vmem_get_word(VirtualMem* vm,unsigned short address) {
	return vm->mem[address >> 1]._words[address && 0x0001];
}

static inline unsigned char vmem_get_byte(VirtualMem* vm,unsigned short address) {
	return vm->mem[address >> 2]._bytes[address && 0x0003];
}

static inline void vmem_store_word(VirtualMem* vm,unsigned short address,unsigned short value) {
	vm->mem[address >> 1]._words[address && 0x0001] = value;
}

static inline void vmem_store_byte(VirtualMem* vm,unsigned short address,unsigned char value) {
	vm->mem[address >> 2]._words[address && 0x0003] = value;
}

VirtualMachine* vmachine_create() {
	VirtualMachine* vm = (VirtualMachine*)calloc(sizeof(VirtualMachine),1);
	if (!vm) {
		return NULL;
	}
	vm->vmem = calloc(VMEM_SIZE, sizeof(Data));
	vm->stack_pointer = 0x7fff;
	return vm;
}

void vmachine_dump(VirtualMachine* vm){
	for (int i = 0; i < 31; ++i)
	{
		printf("register: c%d 0x%04x\n", i,vm->RegFile[i]);
	}
	printf("PC: 0x%04x\n", vm->PC);
}

void vmachine_destroy(VirtualMachine* vm) {
	if(!vm) return;
	free(vm->vmem);
	free(vm);
}

void vmachine_run(VirtualMachine* vm) {
	unsigned int instruction,r1,r2,imm,op,cat;
	char isaluop;
	for (;;) {
		instruction = vm->vmem->mem[vm->PC++]._dword;
		cat = instruction & 0x03;
		op = (instruction  >> 2 ) & 0xf;
		rd = (instruction >> 6) & 0x1f;
		r1 = (instruction >> 11) & 0x1f;
		r2 = (instruction >> 16) & 0x1f;
		imm = instruction >> 16;
		isaluop = !(cat == 3);
		switch (cat) {
		        case 0: vm->RegFile[rd] = run_alu_op(op, vm->RegFile[r1], vm->RegFile[r2], vm->carry_flag); break;
			case 1: vm->RegFile[rd] = run_alu_op(op, vm->RegFile[r1], imm, vm->carry_flag); break;
			case 2: vm->RegFile[rd] = run_alu_op(op, imm, vm->RegFile[r1], vm->carry_flag); break;
			default: switch(op) {
			        case 0: vmem_store_word(vm->vmem, imm & 0x7fff, vm->RegFile[r1]);  
				case 1: if (imm && (1 << 15)) { vm->RegFile[r1] = vmem_get_word(vm->vmem, imm & 0x7fff); } else { vm->RegFile[r1] = vmem_get_word(vm->vmem, vm->RegFile[r2]); } break;
				case 2: vm->RegFile[18] = vm->PC; vm->PC = imm; break;
				case 8: if (take_jump(imm >> 14, vm->RegFile[r1], vm->RegFile[r2])) { vm->PC = imm & 0x3fff; continue; } break;
				case 9: if (take_jump(imm >> 14 + 4, vm->RegFile[r1], vm->RegFile[r2])) { vm->PC = imm && 0x3fff; continue; } break;
				case 10: goto stop;
				case 15: if (imm & (1 << 15)) { vm->PC = vm->RegFile[r1]; } else { vm->PC = imm; } continue;
				default: printf("Error non supported instruction at address %d\n", vm->PC); break;
			}
		}
	}
stop: 
	printf("Running program done...\n");
}

int main(int argc, char ** argv)
{
	FILE * binary;
	if (argc < 2) {
		printf("Error no input file\nUsage: ceespu <inputfile>");
		return;
	}
	binary = fopen(argv[1], "rb");
	if (!binary) {
		printf("Error input file couldn't be opened");
		return;
	}
	printf("Starting Machine Simulation...\n");
	VirtualMachine* vm = vmachine_create();
	if (!vm) {
		return;
	}
	printf("Machine Created...\n");
	
	
        fseek (binary , 0 , SEEK_END);
	int lSize = ftell (binary);
        rewind (binary);
	fread(vm->vmem, 1, lSize, binary);
	printf("File Read...\n");
	printf("Running program code...\n");
	vmachine_run(vm);
	vmachine_dump(vm);
	vmachine_destroy(vm);

}

