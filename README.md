CeesPU - A homemade CPU for the mojo
====================================

A 32 bit cpu made for the mojo v3 fpga. Primarely coded in lucid. The design is largely based of the mips, and microblaze architectures. 
It consists of a three stage pipeline, and has thirty or so instructions.

CPU Architecture
----------------

The CPU is generally 32-bit: that is the width of registers, the size of each
instruction word. The size of memory locations are 16 bit due to a limitation in the amount of available memory.

An instruction is 32 bits wide. The opcode is 6 bits an register 5, and an immidiate 16 bits.
There are two main types of of instructions:
```
TypeA:  Opcode RegD RegA RegB
TypeB:  Opcode RegD RegA Immidiate
```
There are 32 32-bit registers. 

| Type          | Are           | Cool  |
| ------------- |:-------------:| -----:|
| Type A        | right-aligned | $1600 |
| Type B        | centered      |   $12 |
| Type C        | are neat      |    $1 |
