CeesPU - A homemade CPU for the mojo
====================================

A 32 bit cpu made for the mojo v3 fpga. Primarely coded in lucid. The design is largely based of the mips, and microblaze architectures. 
It consists of a three stage pipeline, and has thirty or so instructions.

CPU Architecture
----------------

The CPU is generally 32-bit: that is the width of registers, the size of each
instruction word. The size of memory locations are 16 bit due to a limitation in the amount of available memory.

There are three main types of of instructions
| Tables        | Are           | Cool  |
| ------------- |:-------------:| -----:|
| col 3 is      | right-aligned | $1600 |
| col 2 is      | centered      |   $12 |
| zebra stripes | are neat      |    $1 |
