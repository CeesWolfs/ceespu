`timescale 1ns / 1ps

module ceespu_branch_predictor_tb ();

reg [31:0] instruction = 0;
reg [15:0] branch_address = 60;
reg [1:0] branch_prediction_state = 2'b00;
reg update_table = 0;
wire prediction;
wire [1:0] prediction_state;
reg branch_taken =  0;
reg clk, rst;

ceespu_branch_predictor ceespu_branch_predictor (
	.clk                    (clk                    ),
	.rst                    (rst                    ),
	.I_instruction          (instruction            ),
	.branch_address         (branch_address         ),
	.branch_prediction_state(branch_prediction_state),
	.branch_taken           (branch_taken           ),
	.update_table           (update_table           ),
	.prediction_state       (prediction_state       ),
	.prediction             (prediction             )
);

always begin
  forever #5 clk = ! clk;
end

initial
 begin
    $dumpfile("test.lxt");
    $dumpvars(0,ceespu_branch_predictor);
 end

initial begin
  clk = 0;
  instruction = 0;
  rst = 1;
  #14 rst = 0;
  instruction = 32'hE4140078; 
  #10 instruction = 0;
  update_table = 1;
  branch_taken = 1;
  #10 rst = 1;
  update_table = 0;
  #10 rst = 0;
  instruction = 32'hE4140078;
  #15 $finish;
end
endmodule // ceespu_branch_predictor_tb