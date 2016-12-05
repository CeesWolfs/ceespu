`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   17:07:50 11/09/2016
// Design Name:   ceespu_alu
// Module Name:   C:/Users/Cees/fpga/SCICS/ceespu_alu_test.v
// Project Name:  SCICS
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: ceespu_alu
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module ceespu_alu_test;

	// Inputs
	reg I_clk;
	reg I_rst;
	reg [31:0] I_dataA;
	reg [31:0] I_dataB;
	reg I_Cin;
	reg [3:0] I_aluop;

	// Outputs
	wire O_multiCycle;
	wire [31:0] O_dataResult;
	wire O_Cout;
	wire O_dataReady;
	// Instantiate the Unit Under Test (UUT)
	ceespu_alu uut (
		.I_clk(I_clk), 
		.I_rst(I_rst), 
		.I_dataA(I_dataA), 
		.I_dataB(I_dataB), 
		.I_Cin(I_Cin), 
		.I_aluop(I_aluop), 
		.O_multiCycle(O_multiCycle), 
		.O_dataResult(O_dataResult), 
		.O_Cout(O_Cout), 
		.O_dataReady(O_dataReady)
	);

	initial begin
		// Initialize Inputs
		I_clk = 1;
		I_rst = 0;
		I_dataA = 120;
		I_dataB = 80;
		I_Cin = 0;
		I_aluop = 9;
		
		# 30;
		I_aluop = 6;

		// Wait 100 ns for global reset to finish
		#100;
      $finish;
		// Add stimulus here

	end
     always # 5 I_clk = ! I_clk;
endmodule

