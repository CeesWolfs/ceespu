//==================================================================================================
//  Filename      : ceespu_regfile.v
//  Created On    : 2018-07-21 21:13:53
//  Last Modified : 2018-08-04 21:44:12
//  Revision      : 
//  Author        : Cees Wolfs
//
//  Description   : The register file for the ceespu
//
//
//==================================================================================================
`timescale 1ns / 1ps
module ceespu_regfile(
         input I_clk,  // clock
         input I_rst,  // reset
         input [4:0] I_selA,
         input [4:0] I_selB,
         input I_we,
         input [4:0] I_selD,
         input [31:0] I_dataD,
         output [31:0] O_dataA,
         output [31:0] O_dataB
       );

reg [31:0] regfile [31:0];

assign O_dataA = regfile[I_selA];
assign O_dataB = regfile[I_selB];

/* Sequential Logic */
always @(posedge I_clk) begin
  if (I_we) begin
    $display("%d = %d, out is now %d at %d", I_selD, I_dataD, O_dataB, $time);
    regfile[I_selD] <= I_dataD;
  end
end

reg [5:0] k;

initial begin
  for (k = 0; k <= 31; k = k + 1) begin
    regfile[k] = 0;
  end
  // initialize stack pointer
  regfile[18] = 32'h0000DFFF;
end

endmodule
