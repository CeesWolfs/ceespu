`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date:    16:41:29 11/10/2016
// Design Name:
// Module Name:    ceespu_regfile
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
    $display("%d = %d, out is now %d at %d", I_selD, I_dataD, O_dataB, $stime);
    regfile[I_selD] <= I_dataD;
  end
end

reg [5:0] k;
initial begin
  for (k = 0; k <= 31; k = k + 1) begin
    regfile[k] = 0;
  end
  regfile[18] = 32'h0000fff0;
end

endmodule
