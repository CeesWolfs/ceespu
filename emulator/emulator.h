#pragma once
#define VMEM_SIZE (1 << 14)

typedef union _VirtualMem {
  int word[VMEM_SIZE];
  short hword[VMEM_SIZE * 2];
  char byte[VMEM_SIZE * 4];
} VirtualMem;

typedef struct _VirtualMachine {
  unsigned int RegFile[32];      // the register file
  VirtualMem *vmem;              // the virtual memory
  unsigned int PC;               // the program counter
  unsigned char carry_flag : 1;  // the carry bit
} VirtualMachine;
