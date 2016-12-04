CeesPU - A homemade CPU for the mojo
====================================

A 32 bit cpu made for the mojo v3 fpga. Coded in verilog. The design is largely based of the mips, and microblaze architectures. 
It consists of a four stage pipeline, and has thirty or so instructions.

CPU Architecture
----------------

The CPU is generally 32-bit: that is the width of registers, the size of each
instruction word. The size of memory locations are 16 bit due to a limitation in the amount of available memory on the mojo baord(64 KB). 

An instruction is 32 bits wide. The opcode is 6 bits an register address 5, and an immidiate 16 bits.
There are two main types of instructions:
```
TypeA:  Opcode RegD RegA RegB
TypeB:  Opcode RegD RegA Immidiate
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
| MUL           | b001001       |    $1      |