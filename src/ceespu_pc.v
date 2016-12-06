`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:13:32 11/14/2016 
// Design Name: 
// Module Name:    ceespu_pc 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
// The program counter, it points to the instruction that should be loaded
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module ceespu_pc(
  input I_clk,
  input I_rst,
  input I_stall,
  input I_branch,
  input [13:0] I_branchAddress,
  output reg [13:0] O_PC = 0
);

  always @(posedge I_clk) begin
    if (I_rst) begin
      O_PC <= 0;
    end
    else if (! I_stall) begin
      O_PC <= O_PC + 1;
    end
    else if (I_branch) begin
      O_PC <= I_branchAddress;
    end
  end

endmodule
