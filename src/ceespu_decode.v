`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date:    17:44:23 11/11/2016
// Design Name:
// Module Name:    ceespu_decode
// Project Name:
// Target Devices:
// Tool versions:
// Description:
//
// Dependencies:
//
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//
//////////////////////////////////////////////////////////////////////////////////

`define opcode	   I_instruction[31:26]
`define regd 	     I_instruction[25:21]
`define rega_sel   I_instruction[20:16]
`define regb_sel   I_instruction[15:11]
`define imm_value  I_instruction[15:0]
`define C_bit	     I_instruction[26]
`define IMM_bit    I_instruction[30] 
`define SE_bit     I_instruction[0]
`define SHF_bits   I_instruction[7:6]
`define LINK_bit   I_instruction[0]
`define branch_condition I_instruction[28:26]

`define ADD       6'b0?000?
`define SUB       6'b0?001?
`define LOGIC_OR  6'b0?0100
`define LOGIC_AND 6'b0?0101
`define LOGIC_XOR 6'b0?0110
`define SEXT      6'b000111
`define SHF       6'b0?1000
`define MUL       6'b0?1001
`define DIV       6'b0?1010
`define LOAD      6'b100???
`define IMM       6'b101010
`define EINT      6'b101011
`define STORE     6'b1101??
`define BRANCH    6'b111???

`define ALU_ADD    4'd0
`define ALU_OR     4'd1
`define ALU_AND    4'd2
`define ALU_XOR    4'd3
`define ALU_SEXT8  4'd4
`define ALU_SEXT16 4'd5
`define ALU_SHL    4'd6
`define ALU_SHR    4'd7
`define ALU_SAR    4'd8
`define ALU_MUL    4'd9
`define ALU_DIV    4'd10

module ceespu_decode(
         input I_clk,
         input I_rst,
         input I_flush,
         input I_stall,
         input I_justBranched,
         input I_int,
         input [1:0] I_int_vector,
         input [31:0] I_regA,
         input [31:0] I_regB,
         input [31:0] I_instruction,
         input [13:0] I_PC,
         output reg [31:0] O_dataA = 0,
         output reg [31:0] O_dataB = 0,
         output reg [31:0] O_storeData  = 0,
         output reg [3:0]  O_aluop = 0,
         output reg O_we = 0,
         output reg O_isBranch = 0,
         output reg [4:0] O_regD = 0,
         output reg [4:0] O_regA = 0,
         output reg [4:0] O_regB = 0,
         output reg [1:0] O_selCin = 0,
         output reg [2:0] O_selMem = 0,
         output reg [2:0] O_branchOp = 0,
         output reg [1:0] O_selWb = 0,
         output reg O_int_ack,
         output reg O_memE = 0,
         output reg O_memWe = 0,
         output reg [13:0] O_PC = 0,
         output reg [13:0] O_branchAddress = 0
       );

reg enable_interrupts = 1;
reg not_interrupt = 0;
reg [15:0] imm; // contains the immidiate from immidiate I_instruction
reg imm_valid = 0;  // indicates wether the immidiate is valid

wire [31:0] immidiate;
assign immidiate = imm_valid ? {imm, `imm_value} : {{16{I_instruction[15]}}, `imm_value};

always @* begin
  O_regA = `rega_sel; // defaults
  O_regB = `regb_sel;
  if (! I_stall ) begin
    if (I_instruction[31:29] == 3'b100) begin // LOAD
      O_regB = 0; // Do not use register b
    end
    else if (I_instruction[31:28] == 4'b1101) begin // STORE
      O_regB = `regd; // Store so register in wierd place
    end
    if (I_instruction[31:30] == 3'b01) begin // Alu immidiate operation
      O_regB = 0; // Do not use register b
    end
    if (I_instruction[31:29] == 3'b111) begin
      O_regB = `regd;
    end
  end
end

always @(posedge I_clk) begin
  O_storeData <= I_regB;
  not_interrupt <= I_justBranched;
  O_PC <= I_PC;
  if (I_rst | I_flush) begin
    imm_valid = 0;
    O_we = 0;
    O_memE = 0;
    O_isBranch = 0;
    O_int_ack = 1'b0;
    $display("bubble or branch O_memE = %d", O_memE);
  end
  else if (! I_stall ) begin
    O_dataA = I_regA;
    O_dataB = I_regB;
    O_aluop = `ALU_ADD;
    O_regD = `regd;
    O_we = 1 && (`regd != 5'h0);
    O_int_ack = 1'b0;
    imm_valid = 0;
    O_isBranch = 0;
    O_selCin = 0;
    O_selMem = 0;
    O_memE = 0;
    O_memWe = 0;
    O_branchOp = 0;
    O_selWb = 0;
    if (I_int && enable_interrupts &! I_justBranched) begin
      O_isBranch = 1;
      O_branchOp = 3'b111;
      O_we = 1'b1;
      O_regD = 17;
      O_branchAddress = I_int_vector;
      $display("int 0x%h, called at %d, 17 = %h", O_branchAddress, $time, O_PC);
      O_selWb = 2'b10;
      O_int_ack = 1'b1;
      enable_interrupts = 0;
    end
    else begin
      casez (`opcode)
        `ADD:
        begin
          O_selCin = `C_bit ? 2'd1 : 2'd0;
          O_dataB = `IMM_bit ? immidiate : I_regB;
        end
        `SUB:
        begin
          O_selCin = `C_bit ? 2'd2 : 2'd3;
          O_dataA = ~ I_regA;
          O_dataB = `IMM_bit ? immidiate : I_regB;
        end
        `LOGIC_OR:
        begin
          O_aluop = `ALU_OR;
          O_dataB = `IMM_bit ? immidiate : I_regB;
        end
        `LOGIC_AND:
        begin
          O_aluop = `ALU_AND;
          O_dataB = `IMM_bit ? immidiate : I_regB;
        end
        `LOGIC_XOR:
        begin
          O_aluop = `ALU_XOR;
          O_dataB = `IMM_bit ? immidiate : I_regB;
        end
        `SEXT:
        begin
          O_aluop = `SE_bit ? `ALU_SEXT16 : `ALU_SEXT8;
        end
        `SHF:
        begin
          case (`SHF_bits)
            0: O_aluop = `ALU_SHL;
            1: O_aluop = `ALU_SHR;
            2: O_aluop = `ALU_SAR;
            3: O_aluop = `ALU_SHL;
          endcase
          O_dataB = `IMM_bit ? immidiate : I_regB;
        end
        `MUL:
        begin
          O_aluop = `ALU_MUL;
          O_dataB = `IMM_bit ? immidiate : I_regB;
        end
        `IMM:
        begin
          O_we = 0;
          imm = `imm_value;
          imm_valid = 1;
        end
        `EINT:
        begin
          O_we = 0;
          enable_interrupts = I_instruction[0];
        end
        `LOAD:
        begin
          O_selWb = 1;
          O_memE =  1;
          O_selMem = I_instruction[28:26];
          O_dataB = immidiate;
          $display("selmem %b", O_selMem);
        end
        `STORE:
        begin
          O_memE = 1;
          O_memWe = 1;
          O_selMem = I_instruction[27:26];
          O_we = 0;
          O_regD = 0;
          O_dataB = immidiate;
        end
        `BRANCH:
        begin
          O_isBranch = 1;
          O_branchOp = `branch_condition;
          O_we = `LINK_bit ? 1'b1 : 1'b0;
          O_branchAddress = I_instruction[15:2];
          if (`LINK_bit) begin
            O_selWb = 2;
            O_regD = 19;
          end
          if (I_instruction[1]) begin
            O_branchAddress = I_regA[15:2];
          end
          if (O_regA == 17) begin
            enable_interrupts = 1;
          end
        end
        default:
        begin
        end
      endcase
    end
  end
end
endmodule
