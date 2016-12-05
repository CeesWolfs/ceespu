// Code your testbench here
// or browse Examples
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
  input [4:0] I_selD,
  input [3:0] I_aluop,
  input I_we,
  input [1:0] I_selWb,
  input [0:0] I_branch,
  input [2:0] I_branchop,
  input [31:0] I_dataA,
  input [31:0] I_dataB,
  input [31:0] I_memA,
  input [1:0] I_selCin,
  input [3:0] I_selMem,
  input [13:0] I_PC,
  output reg [4:0] O_selD = 0,
  output reg O_we = 0,
  output reg [31:0] O_dataD = 0,
  output reg O_busy = 0,
  output O_branch
);

  reg Cin;
  reg Carry;

  wire multiCycle;
  wire [31:0] aluResult;
  wire Cout;
  wire ready;
  wire doBranch;
  ceespu_alu alu(I_clk, I_rst, I_dataA, I_dataB, Cin, I_aluop, multiCycle, aluResult, Cout, ready);
  ceespu_compare compare(I_dataA, I_dataB, I_branchop, Carry, doBranch);

  assign O_branch  = doBranch & I_branch;

  always @* begin
    casez (I_selMem) 
      4'b?000:
        begin 
          loaddata = I_memA;
        end
      4'b?001:
        begin
          loaddata = I_memA;
        end
      4'b?010:
        begin 
          loaddata = I_selMem[3] ? {{(16){I_memA[15]}}, I_memA[15:0]} : {16'd0, I_memA[15:0]};
        end
      4'b?011:
        begin
          loaddata = I_selMem[3] ? {{(16){I_memA[31]}}, I_memA[31:16]} : {16'd0, I_memA[31:16]};
        end
      4'b?100:
        begin
          loaddata = I_selMem[3] ? {{(24){I_memA[7]}}, I_memA[7:0]} : {24'd0, I_memA[7:0]};
        end
      4'b?101:
        begin
          loaddata = I_selMem[3] ? {{(24){I_memA[15]}}, I_memA[15:8]} : {24'd0, I_memA[15:8]};
        end
      4'b?110:
        begin
          loaddata = I_selMem[3] ? {{(24){I_memA[23]}}, I_memA[23:16]} : {24'd0, I_memA[23:16]};
        end
      4'b?111:
        begin
          loaddata = I_selMem[3] ? {{(24){I_memA[31]}}, I_memA[31:24]} : {24'd0, I_memA[31:24]};
        end
    endcase;
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

  reg [31:0] loaddata;

  always @(posedge I_clk) begin
    O_busy = ! ready & multiCycle;
    Carry = Cout;
    O_selD = I_selD;
    O_we = I_we & ! O_busy;		 
    case (I_selWb) 
      2'd0: 
        begin 
          O_dataD = aluResult;
        end
      2'd1:
        begin 
          O_dataD = loaddata;
        end
      2'd2:
        begin 
          O_dataD = I_PC;
        end
    endcase			  
  end


endmodule
