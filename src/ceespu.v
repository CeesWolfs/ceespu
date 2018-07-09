`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date:    22:50:08 11/14/2016
// Design Name:
// Module Name:    ceespu
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
module ceespu(
         input I_clk,
         input I_rst,
         input I_int,
         input [2:0] I_int_vector,
         input [31:0] I_imemData,
         output [15:0] O_imemAddress,
         input [31:0] I_dmemData,
         input I_dmemBusy,
         output O_int_ack,
         output [15:0] O_dmemAddress,
         output [31:0] O_dmemWData,
         output O_dmemE,
         output [3:0]  O_dmemWe
       );

wire [13:0] fetch_PC, dec_PC, ex_branchAddress, ex_PC;
wire branch, dec_stall, ex_stall, ex_busy;
wire [31:0] regA, regB, dec_dataA, dec_dataB, dec_storeData, wb_dataD, ex_aluResult;
reg  [31:0] aluA, aluB, storeData;
reg  [31:0] writeback_result;
reg  [31:0] instruction_memory = 0;
reg justBranched = 0;
wire [3:0] dec_aluop;
wire dec_we, dec_memE, dec_memWe, dec_isBranch, ex_we;
wire [4:0] dec_regD, ex_regD, dec_regA, dec_regB;
wire [1:0] dec_selCin, dec_selWb, ex_selWb;
wire [2:0] dec_selMem, ex_selMem;
wire [2:0] dec_branchOp;

reg stall = 0;
reg bubble = 0;
reg [1:0] forwardA = 0;
reg [1:0] forwardB = 0;

assign O_imemAddress[15:2] = fetch_PC;
assign O_imemAddress[1:0]  = 0;

ceespu_pc pc (
            .I_clk(I_clk),
            .I_rst(I_rst),
            .I_stall(stall),
            .I_branch(branch),
            .I_branchAddress(ex_branchAddress),
            .O_PC(fetch_PC)
          );
ceespu_decode decode (
                .I_clk(I_clk),
                .I_rst(I_rst),
                .I_flush(bubble | branch),
                .I_stall(ex_busy),
                .I_int(I_int),
                .I_justBranched(justBranched),
                .I_int_vector(I_int_vector),
                .I_regA(regA),
                .I_regB(regB),
                .I_instruction(instruction_memory),
                .I_PC(fetch_PC),
                .O_dataA(dec_dataA),
                .O_dataB(dec_dataB),
                .O_storeData(dec_storeData),
                .O_aluop(dec_aluop),
                .O_we(dec_we),
                .O_isBranch(dec_isBranch),
                .O_regD(dec_regD),
                .O_regA(dec_regA),
                .O_regB(dec_regB),
                .O_selCin(dec_selCin),
                .O_selMem(dec_selMem),
                .O_branchOp(dec_branchOp),
                .O_selWb(dec_selWb),
                .O_int_ack(O_int_ack),
                .O_memE(dec_memE),
                .O_memWe(dec_memWe),
                .O_PC(dec_PC),
                .O_branchAddress(ex_branchAddress)
              );
ceespu_execute execute (
                 .I_clk(I_clk),
                 .I_rst(I_rst),
                 .I_aluop(dec_aluop),
                 .I_we(dec_we),
                 .I_selWb(dec_selWb),
                 .I_branch(dec_isBranch),
                 .I_branchop(dec_branchOp),
                 .I_storeData(storeData),
                 .I_dataA(aluA),
                 .I_dataB(aluB),
                 .I_selCin(dec_selCin),
                 .I_regD(dec_regD),
                 .I_memE(dec_memE),
                 .I_memWe(dec_memWe),
                 .I_selMem(dec_selMem),
                 .I_PC(dec_PC),
                 .O_memAddress(O_dmemAddress),
                 .O_we(ex_we),
                 .O_aluResult(ex_aluResult),
                 .O_StoreData(O_dmemWData),
                 .O_selWb(ex_selWb),
                 .O_selMem(ex_selMem),
                 .O_memE(O_dmemE),
                 .O_memWe(O_dmemWe),
                 .O_PC(ex_PC),
                 .O_regD(ex_regD),
                 .O_busy(ex_busy),
                 .O_branch(branch)
               );
ceespu_writeback writeback (
                   .I_clk(I_clk),
                   .I_rst(I_rst),
                   .I_selWb(ex_selWb),
                   .I_selMem(ex_selMem),
                   .I_PC(ex_PC),
                   .I_aluResult(ex_aluResult),
                   .I_dmemData(I_dmemData),
                   .O_writeData(wb_dataD)
                 );
ceespu_regfile regfile (
                 .I_clk(I_clk),
                 .I_rst(I_rst),
                 .I_selA(dec_regA),
                 .I_selB(dec_regB),
                 .I_we(ex_we),
                 .I_selD(ex_regD),
                 .I_dataD(wb_dataD),
                 .O_dataA(regA),
                 .O_dataB(regB)
               );

always @(*) begin
  stall = 0;
  bubble = 0;
  aluB = dec_dataB;
  storeData = dec_storeData;
  if (dec_we & dec_memE & ((dec_regA == dec_regD) | (dec_regB == dec_regD)))  begin
    $display( "memory_stall rA = %d, rB = %d, rD = %d at %d", dec_regA, dec_regB, dec_regD, $time);
    stall = 1; // Memory Hazard stall!
    bubble = 1; // insert nop instruction to stall
  end
  stall =  stall | ex_busy | I_dmemBusy;
  case (forwardA)
    0: aluA = dec_dataA;
    1: aluA = ex_aluResult;
    2: aluA = writeback_result;
    3: aluA = 32'hx;
  endcase
  case (forwardB)
    0: storeData = dec_storeData;
    1: storeData = ex_aluResult;
    2: storeData = writeback_result;
    3: storeData = 32'hx;
  endcase
  if (! dec_memWe) begin
    case (forwardB)
      0: aluB = dec_dataB;
      1: aluB = ex_aluResult;
      2: aluB = writeback_result;
      3: aluB = 32'hx;
    endcase
  end
end

always @(posedge I_clk) begin
  writeback_result <= wb_dataD;
  justBranched <= branch;
  if ( branch ) begin
    instruction_memory <= 0;
  end
  else if ( !stall ) begin
    instruction_memory <= I_imemData;
    $display("fetching addr:%d =  %h at %d", O_imemAddress, I_imemData, $time);
  end
  if ( O_int_ack ) begin
    $display("DECODE: Inserting INTERRUPT at pc_decode=0x%x, pc_exe=0x%x", dec_PC, ex_PC);
  end
  forwardA <= 0;
  forwardB <= 0;
  if (ex_we && (dec_regA == ex_regD)) begin
    // Data Hazard in writeback stage forward writeback
    forwardA <= 2;
    $display( "forwardA writeback at %d", $time);
  end
  if (ex_we && (dec_regB == ex_regD)) begin
    // Data Hazard in writeback stage forward writeback
    $display( "forwardB writeback at %d", $time);
    forwardB <= 2;
    //$display("forward writeback %d", )
  end
  if (dec_we & dec_regA == dec_regD) begin
    forwardA <= 1; //forward execute stage
  end
  if (dec_we & dec_regB == dec_regD) begin
    forwardB <= 1; //forward execute stage
  end
end
endmodule
