`timescale 1ns / 1ps
`include "ceespu_constants.vh"
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
         output [4:0] O_regA,
         output [4:0] O_regB,
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

reg interrupts_enabled = 1;
reg [15:0] imm_hi;  // contains the immidiate from seti instruction
reg imm_valid = 0;  // indicates wether the immidiate is valid

reg [31:0] immidiate;

assign  O_regA = `rega_sel;
assign  O_regB = `regb_sel;

always @* begin
  if (`opcode == `C_BRANCH || `opcode == `STORE) begin
    immidiate[15:0] = {`regd, I_instruction[10:0]};
  end else begin
    immidiate[15:0] = `imm_value;
  end
  immidiate[31:16] = imm_valid ? {imm_hi, `imm_value} : {{16{immidiate}}, immidiate[15:0]};
end

always @(posedge I_clk) begin
  if (I_rst | I_flush) begin
    imm_valid = 0;
    O_we = 0;
    O_memE = 0;
    O_isBranch = 0;
    O_int_ack = 1'b0;
    $display("bubble or branch O_PC = %h", O_PC);
  end
  else if (! I_stall ) begin
    O_storeData <= I_regB;
    O_PC <= I_PC;
    O_dataA = I_regA;
    O_dataB = I_regB;
    O_aluop = `ALU_ADD;
    O_regD = `regd;
    O_we = 1 && (`regd != 5'h0);
    O_int_ack = 1'b0;
    imm_valid = 0;
    O_isBranch = 0;
    O_branchAddress = 13'dx;
    O_selCin = 2'bxx;
    O_selMem = 2'bxx;
    O_memE = 0;
    O_memWe = 0;
    O_branchOp = `branch_condition;
    O_selWb = 0;
    if (I_int && interrupts_enabled && !I_justBranched) begin
      O_isBranch = 1;
      O_branchOp = 3'b111;
      O_we = 1'b1;
      O_regD = 17;
      O_branchAddress = I_int_vector;
      $display("interrupt 0x%h, called at %d, c17 = %h", O_branchAddress, $time, O_PC);
      O_selWb = 2'b10;
      O_int_ack = 1'b1;
      interrupts_enabled = 0;
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
          imm_hi = `imm_value;
          imm_valid = 1;
        end
        `EINT:
        begin
          O_we = 0;
          interrupts_enabled = I_instruction[0];
        end
        `LOAD:
        begin
          O_selWb = 1;
          O_memE =  1;
          O_selMem = I_instruction[28:26];
          O_dataB = immidiate;
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
        `C_BRANCH:
        begin
          O_isBranch = 1;
          O_branchAddress = immidiate[15:2];
        end
        `BRANCH:
        begin
          O_isBranch = 1;
          O_we = `LINK_bit ? 1'b1 : 1'b0;
          if (`LINK_bit) begin
            O_selWb = 2;
          end
          if (I_instruction[1]) begin
            O_branchAddress = I_regA[15:2];
          end else begin
            O_branchAddress = immidiate[15:2];
          end
          if (O_regA == 17) begin
            interrupts_enabled = 1;
          end
        end
        default:
        begin
          $display("Error invalid opcode at PC:%h", O_PC);
          O_we = 0;
        end
      endcase
    end
  end
end
endmodule
