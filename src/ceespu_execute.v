`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date:    17:21:20 11/10/2016
// Design Name:
// Module Name:    ceespu_execute
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
module ceespu_execute(
         input I_clk,
         input I_rst,
         input [3:0] I_aluop,
         input I_we,
         input [1:0] I_selWb,
         input I_prediction,
         input I_isBranch,
         input [2:0] I_branchop,
         input [31:0] I_storeData,
         input [31:0] I_dataA,
         input [31:0] I_dataB,
         input [1:0] I_selCin,
         input [4:0] I_regD,
         input I_memE,
         input I_memWe,
         input [2:0] I_selMem,
         input [13:0] I_PC,
         input [13:0] I_branchTarget,
         output reg [13:0] O_branchTarget,
         output [31:0] O_memAddress,
         output reg O_we = 0,
         output reg [31:0] O_aluResult = 0,
         output reg [31:0] O_StoreData = 0,
         output reg [1:0]  O_selWb = 0,
         output reg [2:0]  O_selMem = 0,
         output reg O_memE = 0,
         output reg [3:0]  O_memWe = 0,
         output reg [13:0] O_PC = 0,
         output reg [4:0]  O_regD = 0,
         output reg O_busy = 0,
         output O_branch_mispredict,
         output O_branch_taken
       );

reg Cin;
reg Carry;

wire [31:0] aluResult;
wire [31:0] adderResult;
wire multiCycle;
wire Cout;
wire ready;
wire doBranch;

ceespu_alu alu(I_clk, I_rst, I_dataA, I_dataB, Cin, I_aluop, multiCycle, adderResult, aluResult, Cout, ready);
ceespu_compare compare(I_dataA, I_dataB, I_branchop, Carry, doBranch);

assign O_memAddress = adderResult;
assign O_branch_mispredict = I_isBranch && (doBranch != I_prediction);
assign O_branch_taken = doBranch;

always @* begin
  O_busy = (!ready) && multiCycle;
  O_memE = I_memE;
  if (I_selMem[1:0] == 2) begin
    O_StoreData = {I_storeData[7:0], I_storeData[7:0], I_storeData[7:0], I_storeData[7:0]};
  end
  else if (I_selMem[1:0] == 1) begin
    O_StoreData = {I_storeData[15:0], I_storeData[15:0]};
  end
  else begin
    O_StoreData = I_storeData;
  end
  O_memWe = 4'bxxxx;
  if (I_memE && I_memWe) begin
    if (I_selMem[1:0] == 2) begin
      case (adderResult[1:0])
        0: O_memWe = 4'b0001;
        1: O_memWe = 4'b0010;
        2: O_memWe = 4'b0100;
        3: O_memWe = 4'b1000;
      endcase
    end
    else if (I_selMem[1:0] == 1) begin
      O_memWe = (adderResult[0]) ? 4'b1100 : 4'b0011;
    end
    else begin
      O_memWe = 4'b1111;
    end
  end
  else if(I_memE) begin
    O_memWe = 4'b0000;
  end
  case (I_selCin)
    2'd0: Cin = 0;
    2'd1: Cin = Carry;
    2'd2: Cin = !Carry;
    2'd3: Cin = 1;
  endcase
  if(I_prediction) begin
<<<<<<< HEAD
    O_branchTarget = I_PC; // PC is already the PC of the next instruction
=======
    O_branchTarget = I_PC;
>>>>>>> a8906183d7184df160004a6596c5a786d644c203
  end
  else begin //FIXME: writeback data hazards are not handled yet for bx instructions
    O_branchTarget = I_branchTarget;
  end
end

always @(posedge I_clk) begin
  Carry <= Cout;
  O_we <= I_we & ! O_busy;
  O_regD <= I_regD;
  O_PC <= I_PC;
  O_aluResult <= aluResult;
  O_selWb <= I_selWb;
  O_selMem <= I_selMem;
end

endmodule
