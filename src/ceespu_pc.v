//==================================================================================================
//  Filename      : ceespu_pc.v
//  Created On    : 2018-07-21 21:12:24
//  Last Modified : 2018-08-04 21:42:44
//  Revision      : 
//  Author        : Cees Wolfs
//
//  Description   : The program counter for the ceespu s
//
//
//==================================================================================================
`timescale 1ns / 1ps
module ceespu_pc(
         input I_clk,
         input I_rst,
         input I_stall,
         input I_branch,
         input [13:0] I_branchAddress,
         output [13:0] O_PC
       );

reg [13:0] PC;

assign O_PC = PC + 1;

always @(posedge I_clk) begin
  //$display("branch = %b, at %d address %d", I_branch, $time, I_branchAddress);
  if (I_rst) begin
    PC <= -1;
  end
  else if (I_branch) begin
    $display("branched pc is now %d at %d", I_branchAddress, $time);
    PC <= I_branchAddress;
  end
  else if (! I_stall) begin
    PC <= PC + 1;
  end
end

endmodule
