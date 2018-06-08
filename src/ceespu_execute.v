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
  input [0:0] I_branch,
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
  output O_branch
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
  assign O_branch  = doBranch & I_branch;

  always @* begin
    O_busy = ! ready & multiCycle;
    O_memWe = 4'd0;
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
    if (I_memWe) begin
      if (I_selMem[1:0] == 2) begin
        if (adderResult[1:0] == 2'b11) begin
          O_memWe = 4'b1000;
        end
        else if (adderResult[1:0] == 2'b10) begin
          O_memWe = 4'b0100;
        end
        else if (adderResult[1:0] == 2'b01) begin
          O_memWe = 4'b0010;
        end
        else begin
          O_memWe = 4'b0001;
        end
      end
      else if (I_selMem[1:0] == 1) begin
        O_memWe = (adderResult[0]) ? 4'b1100 : 4'b0011;
      end else begin
        O_memWe = 4'b1111;
      end 
    end
    case (I_selCin) 
      2'd0:
        begin
          Cin = 0;
        end
      2'd1:
        begin
          Cin = Carry;
        end
      2'd2:
        begin 
          Cin = !Carry;
        end
      2'd3:
        begin 
          Cin = 1;
        end
    endcase
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
