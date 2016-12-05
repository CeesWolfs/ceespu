`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   16:54:47 11/10/2016
// Design Name:   ceespu_regfile
// Module Name:   C:/Users/Cees/fpga/SCICS/ceespu_regtest.v
// Project Name:  SCICS
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: ceespu_regfile
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module ceespu_regtest;

	// Inputs
	reg I_clk;
	reg I_rst;
	reg [4:0] I_selA;
	reg [4:0] I_selB;
	reg I_we;
	reg [4:0] I_selD;
	reg [31:0] I_dataD;

	// Outputs
	wire [31:0] O_dataA;
	wire [31:0] O_dataB;

	// Instantiate the Unit Under Test (UUT)
	ceespu_regfile uut (
		.I_clk(I_clk), 
		.I_rst(I_rst), 
		.I_selA(I_selA), 
		.I_selB(I_selB), 
		.I_we(I_we), 
		.I_selD(I_selD), 
		.I_dataD(I_dataD), 
		.O_dataA(O_dataA), 
		.O_dataB(O_dataB)
	);

	initial begin
		// Initialize Inputs
		I_clk = 1;
		I_rst = 0;
		I_selA = 20;
		I_selB = 21;
		I_we = 1;
		I_selD = 20;
		I_dataD = 100;
      
		#10;
		
		I_dataD = 200;
		I_we = 0;
		 #10;
		I_selD = 21;
		I_we = 1;
 
		// Wait 100 ns for global reset to finish
		#100;
      $finish;
		// Add stimulus here

	end
      always #5 I_clk = ! I_clk;
endmodule

