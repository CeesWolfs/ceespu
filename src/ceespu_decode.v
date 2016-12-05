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
`define regd 	   I_instruction[25:21]
`define rega_sel   I_instruction[20:16]
`define regb_sel   I_instruction[15:11]
`define imm_value  I_instruction[15:0]
`define C_bit	   I_instruction[26]
`define IMM_bit    I_instruction[30] 
`define SE_bit     I_instruction[0]
`define SHF_bits   I_instruction[15:14]
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
`define LOAD      6'b100???
`define IMM       6'b101010
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

module ceespu_decode(
    input I_clk,
    input I_rst,
    input I_flush,
    input I_stall,
    input [31:0] I_regA,
    input [31:0] I_regB,
    input [31:0] I_instruction,
    input [13:0] I_PC,
    output reg [31:0] O_dataA = 0,
    output reg [31:0] O_dataB = 0,
	output reg [3:0]  O_aluop = 0,
    output reg O_we = 0,
    output reg O_isBranch = 0,
	output reg [4:0] O_regD = 0,
    output reg [1:0] O_selCin = 0,
    output reg [3:0] O_selMem = 0,
    output reg [2:0] O_branchOp = 0,
    output reg [1:0] O_selWe = 0,
    output reg O_memE = 0,
    output reg [3:0] O_memWe = 0,
    output reg [13:0] O_PC = 0,
	output reg [13:0] O_branchAddress = 0,
    output [15:0] O_memAddress
    );

    reg [15:0] imm; // contains the immidiate from immidiate I_instruction
    reg imm_valid;  // indicates wether the immidiate is valid
  
    wire [31:0] immidiate;
    assign immidiate = imm_valid ? {imm, `imm_value} : {{16{I_instruction[15]}}, `imm_value}; 
    
	assign O_memAddress = I_instruction[28] ? ({I_instruction[25:21], I_instruction[10:0]} + I_regA[15:0]) : (`imm_value + I_regA[15:0]);
	 
    always @* begin 
	   O_memE = 0;
	   O_memWe = 0;
	   if (! I_stall ) begin
		  if (I_instruction[31:29] == 3'b100) begin
		    O_memE = 1;
		  end
        else if (I_instruction[31:28] == 4'b1101) begin
		    O_memE = 1;
			 case (I_instruction[27:26])
			   2'd0: 
				  begin 
				    O_memWe = 4'b1111;
				  end
				2'd1: 
				  begin 
				    if (O_memAddress[0]) begin
                  O_memWe = 4'b1100; 
                end
                else begin
                  O_memWe = 4'b0011;
                end
				  end
				2'd2:
				  begin 
				    if (O_memAddress[1:0] == 2'b11) begin
                  O_memWe = 4'b1000; 
                end
					 if (O_memAddress[1:0] == 2'b10) begin
                  O_memWe = 4'b0100; 
                end
					 if (O_memAddress[1:0] == 2'b01) begin
                  O_memWe = 4'b0010; 
                end
                else begin
                  O_memWe = 4'b0001;
                end
				  end
				endcase
		  end
		end
    end
	 
	 always @(posedge I_clk) begin
	   if (I_rst | I_flush) begin
		  O_dataA = 0;
		  O_dataB = 0;
		  O_aluop = 0;
		  imm_valid = 0;
		  O_we = 0;
		  O_regD = 0;
		  O_isBranch = 0;
		  O_selCin = 0;
		  O_selMem = 0;
		  O_branchOp = 0;
		  O_selWe = 0;
		  O_PC <= 0;
		end
		else if (! I_stall ) begin
		  O_dataA = I_regA;
		  O_dataB = I_regB;
		  O_aluop = `ALU_ADD;
		  O_regD = `regd;
		  O_we = 1;
		  O_useA = 0;
		  O_useB = 0;
		  O_canForward = 0;
		  imm_valid = 0;
		  O_isBranch = 0;
		  O_selCin = 0;
		  O_selMem = 0;
		  O_branchOp = 0;
		  O_selWe = 0;
		  O_PC <= I_PC;
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
          `LOAD:
            begin
               O_selWe = 1;
               case(I_instruction[28:26]) 
					  0: O_selMem = 0;
					  1: O_selMem = {3'b101, O_memAddress[1]};
					  2: O_selMem = {2'b11,  O_memAddress[1:0]};
					  3: O_selMem = {3'b001, O_memAddress[1]};
					  4: O_selMem = {2'b01,  O_memAddress[1:0]};
					  default: O_selMem = 0;
					endcase
             end
          `STORE:
            begin
              O_we = 0;
            end
			 `BRANCH:
			   begin
				  O_isBranch = 1;
				  O_branchOp = `branch_condition;
				  O_we = `LINK_bit ? 1'b1 : 1'b0;
				  O_branchAddress = I_instruction[15:2];
				  if (`LINK_bit) begin
                O_regD = 19;
                O_selWe = 3;
              end
				  if (I_instruction[1]) begin
				    O_branchAddress = I_regA[15:2];
				  end
				end
			  default:
			    begin
				 end
			endcase 
		  end
		end
endmodule
