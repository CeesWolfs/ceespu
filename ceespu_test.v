`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   18:10:30 11/15/2016
// Design Name:   ceespu
// Module Name:   C:/Users/Cees/fpga/SCICS/ceespu_test.v
// Project Name:  SCICS
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: ceespu
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module ceespu_test;

	// Inputs
	reg I_clk;
	reg I_rst;
	reg [31:0] I_imemData;
	reg [31:0] I_dmemData;

	// Outputs
	wire [15:0] O_imemAddress;
	wire [15:0] O_dmemAddress;
	wire [31:0] O_dmemWData;
	wire O_dmemE;
	wire [3:0] O_dmemWe;

	// Instantiate the Unit Under Test (UUT)
	ceespu uut (
		.I_clk(I_clk), 
		.I_rst(I_rst), 
		.I_imemData(I_imemData), 
		.O_imemAddress(O_imemAddress), 
		.I_dmemData(I_dmemData), 
		.O_dmemAddress(O_dmemAddress), 
		.O_dmemWData(O_dmemWData), 
		.O_dmemE(O_dmemE), 
		.O_dmemWe(O_dmemWe)
	);

	initial begin
		// Initialize Inputs
		I_clk = 0;
		I_rst = 1;
		# 10;
		I_rst = 0;
		I_imemData = 32'h42a04f06;
		I_dmemData = 0;
# 10;
      I_imemData = 32'h4280fffe;
# 30;
      I_imemData = 32'h26b5a000;
# 80;
      I_imemData = 32'hd012a804;
		// Wait 100 ns  for global reset to finish
		#100;
      $finish;
		// Add stimulus here
	end
      always # 5 I_clk = ! I_clk;
endmodule

