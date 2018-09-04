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
         output reg [13:0] O_PC
       );

always @(posedge I_clk) begin
  //$display("branch = %b, at %d address %d", I_branch, $time, I_branchAddress);
  if (I_rst) begin
    O_PC <= 0;
  end
  else if (I_branch) begin
    $display("branched pc is now %d at %d", I_branchAddress, $time);
    O_PC <= I_branchAddress;
  end
  else if (! I_stall) begin
    O_PC <= O_PC + 1;
  end
end

endmodule
