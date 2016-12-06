CeesPU - A homemade CPU for the mojo
====================================

A 32 bit cpu made for the mojo v3 fpga. Coded in verilog. The design is largely based of the mips, and microblaze architectures. 
It consists of a four stage pipeline, and has thirty or so instructions.

CPU Architecture
----------------

The CPU is generally 32-bit: that is the width of registers, the size of each
instruction word. The size of memory locations are 16 bit due to a limitation in the amount of available memory on the mojo baord(64 KB). 

An instruction is 32 bits wide. The opcode is 6 bits an register address 5, and an immidiate 16 bits.
There are three main types of instructions:
```
TypeA:  Opcode RegD RegA RegB 
TypeB:  Opcode RegD RegA Immidiate
TypeC:  Opcode RegA RegB Immidiate
```
There are 32 32-bit registers. 
 * c0           zero; unchangeable
 * c1-c11       saved registers for static variables (preserved accross function calls)
 * c12-c17      scratch temporary registers
 * c18          stack pointer
 * c19          function return address
 * c20          function return value
 * c20-c25      function args
 * c25-c31      scratch temporary registers

| Mnemonic      | Encoding      | Operation  |
| ------------- |:-------------:| :--------- |
| ADD           | b000000       | Add two registers Rd = Ra + Rb     |
| ADC           | b000001       | Addition with carry Rd = Ra + Rb + carry      |
| SUB           | b000010       | Subtraction Rd = Rb - Ra      |
| SBB           | b000011       | Subtraction with borrow Rd = Rb - Ra - carry     |
| OR            | b000100       | Bitwise or Rd = Ra | Rb      |
| AND           | b000101       | Bitwise and Rd = Ra & Rb      |
| XOR           | b000110       | Bitwise exclusive or Rd = Ra ^ Rb      |
| SHL           | b001000       | Bitshift to the left Rd = Ra << Rb     |
| SHR           | b001000       | Bitshift to the right Rd = Ra >> Rb    |
| SAR           | b001000       | Signed shift to the right Rd = Ra >> Rb |
| MUL           | b001001       | Multiply Rd = Ra * Rb      |
| SEB           | b000111       | Sign extend byte Rd = (int)(Ra & 0xff) | 
| SEH           | b000111       | Sign extend halfword Rd = (int)(Ra & 0xffff) | 
| ADDI          | b000000       | Add immidiate Rd = Ra + Imm     |
| ADCI          | b000001       | Addition with carry Rd = Ra + Imm + carry      |
| SUBI          | b000010       | Subtraction Rd = Imm - Ra      |
| SBBI          | b000011       | Subtraction with borrow Rd = Imm - Ra - carry     |
| ORI           | b000100       | Bitwise or Rd = Ra | Imm      |
| ANDI          | b000101       | Bitwise and Rd = Ra & Imm      |
| XORI          | b000110       | Bitwise exclusive or Rd = Ra ^ Imm      |
| SHLI          | b001000       | Bitshift to the left Rd = Ra << Imm     |
| SHRI          | b001000       | Bitshift to the right Rd = Ra >> Imm    |
| SARI          | b001000       | Signed shift to the right Rd = Ra >> Imm |
| MULI          | b001001       | Multiply Rd = Ra * Imm      |
| LW            | b100000       | Load word from memory Rd = Mem[Ra + Imm] |
| LH            | b100000       | Load halfword from memory Rd = (short)Mem[Ra + Imm] |
| LB            | b100000       | Load byte from memory Rd = (char)Mem[Ra + Imm] |
| LHU           | b100000       | Load unsigend halfword from memory Rd = (unsigned short)Mem[Ra + Imm] |
| LBU           | b100000       | Load unsigned byte from memory Rd = (byte)Mem[Ra + Imm] |
| SW            | b100000       | Store word in memory Mem[Ra + Imm] = Rb|
| SH            | b100000       | Store halfword in memory Mem[Ra + Imm] = (short)Rb |
| SB            | b100000       | Store byte in memory Mem[Ra + Imm] = (byte)Rb|
| BEQ           | b111000       | Branch if equal PC = Imm if(Ra == Rb)        |
| BNE           | b111001       | Branch if not equal PC = Imm if(Ra != Rb)        |
| BGU           | b111010       | Branch if  PC = Imm if(Ra > Rb)         |
| BGEU          | b111011       | Branch if equal PC = Imm if(Ra == Rb)        |
| BG            | b111100       | Branch if  PC = Imm if(Ra > Rb)         |
| BGE           | b111101       | Branch if equal PC = Imm if(Ra == Rb)        |
| BC            | b111110       | Branch if carry flag is set PC = Imm if(carry) |
| B             | b111111       | Unconditional branch PC = Imm                  |
| BX            | b111111       | Branch to register PC = Ra                     |
| CALL          | b111111       | Branch and set the link register LR= PC; PC = Imm |

Pipeline Stages
----------------
![alt tag](https://www.dropbox.com/home/Apps/drawio?preview=Ceespu.png)