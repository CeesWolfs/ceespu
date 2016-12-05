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
    input [31:0] I_imemData,
    output [15:0] O_imemAddress,
    input [31:0] I_dmemData,
    output [15:0] O_dmemAddress,
    output [31:0] O_dmemWData,
    output O_dmemE,
    output [3:0]  O_dmemWe
    );
	 
wire [13:0] fetch_PC, dec_PC, ex_branchAddress;
wire stall;
wire branch;
wire [31:0] regA, regB, dec_dataA, dec_dataB, ex_dataD;
wire [3:0] dec_aluop;
wire dec_we, dec_isBranch, ex_we;
wire [4:0] dec_regD, ex_regD;
wire [1:0] dec_selCin, dec_selWe;
wire [3:0] dec_selMem;
wire [2:0] dec_branchOp;

assign O_imemAddress[15:2] = fetch_PC;
assign O_imemAddress[1:0]  = 0;
assign O_dmemWData = regB;

ceespu_pc pc(I_clk, I_rst, stall, branch, ex_branchAddress, fetch_PC);
ceespu_decode decode(I_clk, I_rst, branch, stall, regA, regB, I_imemData, fetch_PC, dec_dataA, dec_dataB, dec_aluop, dec_we, dec_isBranch, dec_regD, dec_selCin, dec_selMem ,dec_branchOp, dec_selWe, O_dmemE, O_dmemWe, dec_PC, ex_branchAddress, O_dmemAddress);
ceespu_execute execute(I_clk, I_rst, dec_regD, dec_aluop, dec_we, dec_selWe, dec_isBranch, dec_branchOp, dec_dataA, dec_dataB, I_dmemData, dec_selCin, dec_selMem, fetch_PC, ex_regD, ex_we, ex_dataD, stall, branch);
ceespu_regfile regfile(I_clk, I_rst, I_imemData[20:16], I_imemData[15:11], ex_we, ex_regD, ex_dataD, regA, regB);

always @(posedge I_clk) begin
  if (
end

endmodule
