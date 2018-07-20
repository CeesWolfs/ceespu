//==================================================================================================
//  Filename      : ceespu_decode.v
//  Created On    : 2018-07-17 17:42:55
//  Last Modified : 2018-07-19 23:21:40
//  Revision      : 
//  Author        : Cees Wolfs
//
//  Description   : Decoder for the ceespu
//
//
//==================================================================================================
`timescale 1ns / 1ps
`include "ceespu_constants.vh"


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
  reg [15:0] imm_hi = 0;  // contains the immidiate from seti instruction
  reg imm_valid = 0;  // indicates wether the immidiate is valid

  reg [31:0] immidiate = 0;

  reg [31:0] dataA, dataB;
  reg [13:0] branchAddress;
  reg [4:0] regD;
  reg [3:0] aluop; 
  reg [2:0] branchOp, selMem;
  reg [1:0] selWb, selCin;
  reg we, isBranch, memE, memWe, set_imm_valid, did_interrupt, set_interrupts_enabled;


  assign  O_regA = `rega_sel;
  assign  O_regB = `regb_sel;

  always @* begin
    casez (`opcode)
      `STORE,`C_BRANCH : immidiate[15:0] = {`regd, I_instruction[10:0]};
      default : immidiate[15:0] = `imm_value; 
    endcase
    immidiate[31:16] = imm_valid ? imm_hi : {16{immidiate[15]}};
    set_interrupts_enabled = 0; 
    $display("imm_value is %h at PC:%d from regd:%b", immidiate, I_PC, `regd, $time);
    if (I_int && interrupts_enabled && !I_justBranched) begin
      isBranch = 1;
      branchOp = 3'b111;
      we = 1;
      regD = 17;
      branchAddress = I_int_vector;
      $display("interrupt 0x%h, called at %d, c17 = %h", O_branchAddress, $time, O_PC);
      selWb = 2'b10;
      did_interrupt = 1;
      set_imm_valid = 0;
      dataA = 32'hxxxx;
      dataB = 32'hxxxx;
      aluop = 32'hxxxx;
      selCin = 2'bxx;
      selMem = 2'bxx;
      memE = 0;
      memWe = 1'bx;
    end
    else begin
      dataA = I_regA;
      dataB = I_regB;
      aluop = `ALU_ADD;
      regD = `regd;
      we = 1 && (`regd != 5'h0);
      set_imm_valid = 0;
      did_interrupt = 0;
      isBranch = 0;
      branchAddress = 13'dx;
      selCin = 2'bxx;
      selMem = 2'bxx;
      memE = 0;
      memWe = 1'bx;
      branchOp = `branch_condition;
      selWb = 0;
      //$display("----------------------------------\ndecode instruction: opcode %b",`opcode);
      casez (`opcode)
        `ADD:
          begin
            selCin = `C_bit ? 2'd1 : 2'd0;
            dataB = `IMM_bit ? immidiate : I_regB;
          end
        `SUB:
          begin
            selCin = `C_bit ? 2'd2 : 2'd3;
            dataA = ~ I_regA;
            dataB = `IMM_bit ? immidiate : I_regB;
          end
        `LOGIC_OR:
          begin
            aluop = `ALU_OR;
            dataB = `IMM_bit ? immidiate : I_regB;
          end
        `LOGIC_AND:
          begin
            aluop = `ALU_AND;
            dataB = `IMM_bit ? immidiate : I_regB;
          end
        `LOGIC_XOR:
          begin
            aluop = `ALU_XOR;
            dataB = `IMM_bit ? immidiate : I_regB;
          end
        `SEXT:
          begin
            aluop = `SE_bit ? `ALU_SEXT16 : `ALU_SEXT8;
          end
        `SHF:
          begin
            case (`SHF_bits)
              0: aluop = `ALU_SHL;
              1: aluop = `ALU_SHR;
              2: aluop = `ALU_SAR;
              3: aluop = `ALU_SHL;
            endcase
            dataB = `IMM_bit ? immidiate : I_regB;
          end
        `MUL:
          begin
            aluop = `ALU_MUL;
            dataB = `IMM_bit ? immidiate : I_regB;
            $display("mul c%d = %d * %d, rega %d, regb %d", `regd, O_dataA, O_dataB, `rega_sel, `regb_sel);
          end
        `IMM:
          begin
            we = 0;
            set_imm_valid = 1;
          end
        `EINT:
          begin
            we = 0;
          end
        `LOAD:
          begin
            selWb = 1;
            memE =  1;
            selMem = I_instruction[28:26];
            dataB = immidiate;
          end
        `STORE:
          begin
            memE = 1;
            memWe = 1;
            selMem = I_instruction[27:26];
            we = 0;
            dataB = immidiate;
          end
        `C_BRANCH:
          begin
            isBranch = 1;
            branchAddress = immidiate[15:2];
          end
        `BRANCH:
          begin
            isBranch = 1;
            we = `LINK_bit ? 1'b1 : 1'b0;
            if (`LINK_bit) begin
              selWb = 2;
            end
            if (I_instruction[1]) begin
              branchAddress = I_regA[15:2];
            end else begin
              branchAddress = immidiate[15:2];
            end
            if (O_regA == 17) begin
              set_interrupts_enabled = 1;
            end
          end
        default:
          begin
            $display("Error invalid opcode at PC:%h", O_PC);
            we = 0;
          end
      endcase
    end
  end

  always @(posedge I_clk) begin
    imm_hi <= `imm_value;
    if (I_rst || I_flush) begin
      imm_valid <= 0;
      O_we <= 0;
      O_memE <= 0;
      O_isBranch <= 0;
      O_int_ack <= 1'b0;
      $display("bubble or branch O_PC = %h", O_PC);
    end
    else if (! I_stall ) begin
      if (did_interrupt) begin
        interrupts_enabled <= 0;
      end
      else if(`opcode == `EINT) begin
        interrupts_enabled <= I_instruction[0];
        O_int_ack <= 0;
      end else begin 
        interrupts_enabled <= set_interrupts_enabled;
      end
      O_int_ack <= did_interrupt;
      O_storeData <= I_regB;
      O_PC <= I_PC;
      O_dataA <= dataA;
      O_dataB <= dataB;
      O_aluop <= aluop;
      O_regD <= regD;
      O_we <= we;
      imm_valid <= set_imm_valid;
      O_isBranch <= isBranch;
      O_branchAddress <= branchAddress;
      O_selCin <= selCin;
      O_selMem <= selMem;
      O_memE <= memE;
      O_memWe <= memWe;
      O_branchOp <= branchOp;
      O_selWb <= selWb;
    end
  end
endmodule
