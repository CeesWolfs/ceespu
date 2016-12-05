/*
Copyright (c) 2016 Cees Wolfs

 Permission is hereby granted, free of charge, to any person
 obtaining a copy of this software and associated documentation
 files (the "Software"), to deal in the Software without
 restriction, including without limitation the rights to use,
 copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the
 Software is furnished to do so, subject to the following
 conditions:

 The above copyright notice and this permission notice shall be
 included in all copies or substantial portions of the Software.

 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
 OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
 NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
 HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
 WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
 OTHER DEALINGS IN THE SOFTWARE.
*/

#include "stdio.h"
#include "stdlib.h"
#include "emulator.h"

VirtualMachine* vmachine_create() {
	VirtualMachine* vm = (VirtualMachine*)calloc(sizeof(VirtualMachine),1);
	if (!vm) {
		return NULL;
	}
	vm->vmem = calloc(1, sizeof(VirtualMem));
	vm->RegFile[18] = 0xfffc;
	return vm;
}

void vmachine_dump(VirtualMachine* vm){
	for (int i = 0; i < 32; ++i)
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
	unsigned int instruction,rd,ra,rb,op;
	int imm;
	char imm_valid = 0;
	unsigned short imm_value = 0;
	for (;;) {
		instruction = vm->vmem->word[(vm->PC) >> 2];
		op = (instruction >> 26) & 0x3f;
		rd = (instruction >> 21) & 0x1f;
		ra = (instruction >> 16) & 0x1f;
		rb = (instruction >> 11) & 0x1f;
		address_imm = (rd << 11) + imm & 0x7ff;
		imm = imm_valid ? (imm_value << 16) + (int)(instruction & 0xffff) : (signed)(instruction << 16) >> 16;
		imm_valid = 0;
		switch (op) {
		case 0x0:
			vm->RegFile[rd] = vm->RegFile[ra] + vm->RegFile[rb];
			vm->carry_flag = ((vm->RegFile[ra] + vm->RegFile[rb]) ^ vm->RegFile[ra])&((vm->RegFile[ra] + vm->RegFile[rb]) ^ vm->RegFile[rb]);
			break;
		case 0x1:
			vm->RegFile[rd] = vm->RegFile[ra] + vm->RegFile[rb] + vm->carry_flag;
			vm->carry_flag = ((vm->RegFile[ra] + vm->RegFile[rb] + vm->carry_flag) ^ vm->RegFile[ra])&((vm->RegFile[ra] + vm->RegFile[rb] + vm->carry_flag) ^ vm->RegFile[rb]);
			break;
		case 0x2:
			vm->RegFile[rd] = ~vm->RegFile[ra] + vm->RegFile[rb] + 1;
			vm->carry_flag = ((vm->RegFile[ra] + vm->RegFile[rb] + vm->carry_flag) ^ vm->RegFile[ra])&((vm->RegFile[ra] + vm->RegFile[rb] + vm->carry_flag) ^ vm->RegFile[rb]);
			break;
		case 0x3:
			vm->RegFile[rd] = ~vm->RegFile[ra] + vm->RegFile[rb] + !vm->carry_flag;
			vm->carry_flag = ((vm->RegFile[ra] + vm->RegFile[rb] + vm->carry_flag) ^ vm->RegFile[ra])&((vm->RegFile[ra] + vm->RegFile[rb] + vm->carry_flag) ^ vm->RegFile[rb]);
			break;
		case 0x4:
			vm->RegFile[rd] = vm->RegFile[ra] | vm->RegFile[rb];
			break;
		case 0x5:
			vm->RegFile[rd] = vm->RegFile[ra] & vm->RegFile[rb];
			break;
		case 0x6:
			vm->RegFile[rd] = vm->RegFile[ra] ^ vm->RegFile[rb];
			break;
		case 0x7:
			vm->RegFile[rd] = imm & 1 ? (int)(vm->RegFile[ra] & 0xffff) : (int)(vm->RegFile[ra] & 0xff);
			break;
		case 0x8:
			switch (imm & 0xC0)
			{
			case 0:
				vm->RegFile[rd] = vm->RegFile[ra] << vm->RegFile[rb];
				break;
			case 0x40:
				vm->RegFile[rd] = (unsigned)vm->RegFile[ra] >> (unsigned)vm->RegFile[rb];
				break;
			case 0x80:
				vm->RegFile[rd] = vm->RegFile[ra] >> vm->RegFile[rb];
				break;
			default:
				printf("invalid shift instruction at 0x%X", vm->PC);
				exit(1);
			}
			break;
		case 0x9:
			vm->RegFile[rd] = vm->RegFile[ra] * vm->RegFile[rb];
			break;
		case 0x10:
			vm->RegFile[rd] = vm->RegFile[ra] + imm;
			vm->carry_flag = ((vm->RegFile[ra] + imm) ^ vm->RegFile[ra])&((vm->RegFile[ra] + imm) ^ imm);
			break;
		case 0x11:
			vm->RegFile[rd] = vm->RegFile[ra] + imm + vm->carry_flag;
			vm->carry_flag = ((vm->RegFile[ra] + imm) ^ vm->RegFile[ra])&((vm->RegFile[ra] + imm) ^ imm);
			break;
		case 0x12:
			vm->RegFile[rd] = ~vm->RegFile[ra] + imm + 1;
			vm->carry_flag = ((vm->RegFile[ra] + imm) ^ vm->RegFile[ra])&((vm->RegFile[ra] + imm) ^ imm);
			break;
		case 0x13:
			vm->RegFile[rd] = ~vm->RegFile[ra] + imm + !vm->carry_flag;
			vm->carry_flag = ((vm->RegFile[ra] + imm) ^ vm->RegFile[ra])&((vm->RegFile[ra] + imm) ^ imm);
			break;
		case 0x14:
			vm->RegFile[rd] = vm->RegFile[ra] | imm;
			break;
		case 0x15:
			vm->RegFile[rd] = vm->RegFile[ra] & imm;
			break;
		case 0x16:
			vm->RegFile[rd] = vm->RegFile[ra] ^ imm;
			break;
		case 0x18:
			switch (imm & 0xC0)
			{
			case 0:
				vm->RegFile[rd] = vm->RegFile[ra] << imm;
				break;
			case 0x40:
				vm->RegFile[rd] = (unsigned)vm->RegFile[ra] >> (unsigned)imm;
				break;
			case 0x80:
				vm->RegFile[rd] = vm->RegFile[ra] >> imm;
				break;
			default:
				printf("invalid shift instruction at 0x%X", vm->PC);
				exit(1);
			}
			break;
		case 0x19:
			vm->RegFile[rd] = vm->RegFile[ra] * imm;
			break;
		case 0x2A:
			imm_valid = 1;
			imm_value = imm;
			break;
		case 0x2B:
			goto stop;
		case 0x20:
			vm->RegFile[rd] = vm->vmem->word[(vm->RegFile[ra] + imm) >> 2];
			break;
		case 0x21:
			vm->RegFile[rd] = (int)vm->vmem->hword[(vm->RegFile[ra] + imm) >> 1];
			break;
		case 0x22:
			vm->RegFile[rd] = (int)vm->vmem->byte[vm->RegFile[ra] + imm];
			break;
		case 0x24:
			vm->vmem->word[(vm->RegFile[ra] + imm) >> 2] = vm->RegFile[rd];
			break;
		case 0x25:
			vm->vmem->hword[(vm->RegFile[ra] + imm) >> 1] = vm->RegFile[rd];
			break;
		case 0x26:
			vm->vmem->byte[vm->RegFile[ra] + imm] = vm->RegFile[rd];
			break;
		case 0x30:
			vm->PC = (vm->RegFile[ra] == vm->RegFile[rb]) ? (imm - 4) : vm->PC;
			break;
		case 0x31:
			vm->PC = (vm->RegFile[rd] != vm->RegFile[ra]) ? (imm - 4) : vm->PC;
			break;
		case 0x32:
			vm->PC = (vm->RegFile[rd] > vm->RegFile[ra]) ? (imm - 4) : vm->PC;
			break;
		case 0x33:
			vm->PC = (vm->RegFile[rd] >= vm->RegFile[ra]) ? (imm - 4) : vm->PC;
			break;
		case 0x34:
			vm->PC = (vm->RegFile[rd] < vm->RegFile[ra]) ? (imm - 4) : vm->PC;
			break;
		case 0x35:
			vm->PC = (vm->RegFile[rd] <= vm->RegFile[ra]) ? (imm - 4) : vm->PC;
			break;
		case 0x36:
			vm->PC = ((unsigned)vm->RegFile[rd] > (unsigned)vm->RegFile[ra]) ? (imm - 4) : vm->PC;
			break;
		case 0x37:
			vm->PC = ((unsigned)vm->RegFile[rd] >= (unsigned)vm->RegFile[ra]) ? (imm - 4) : vm->PC;
			break;
		case 0x38:
			vm->PC = ((unsigned)vm->RegFile[rd] < (unsigned)vm->RegFile[ra]) ? (imm - 4) : vm->PC;
			break;
		case 0x39:
			vm->PC = ((unsigned)vm->RegFile[rd] <= (unsigned)vm->RegFile[ra]) ? (imm - 4) : vm->PC;
			break;
		case 0x3A:
			vm->PC = vm->carry_flag ? (imm - 4) : vm->PC;
			break;
		case 0x3B:
			vm->PC = !vm->carry_flag ? (imm - 4) : vm->PC;
			break;
		case 0x3C:
			vm->RegFile[19] = (imm & 0x0001) ? (vm->PC + 4) : vm->RegFile[19];
			vm->PC = (imm & 0x0002) ? vm->RegFile[rd] - 4 : (imm - 4) & 0xfffc;
			break;
		default:
			printf("invalid instruction at 0x%X", vm->PC);
			exit(1);
		}
		vm->PC += 4;
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
		printf("Error input file couldn't be opened!");
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
