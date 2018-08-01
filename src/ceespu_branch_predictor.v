//==================================================================================================
//  Filename      : ceespu_branch_predictor.v
//  Created On    : 2018-07-22 10:56:34
//  Last Modified : 2018-07-29 15:41:31
//  Revision      : 
//  Author        : Cees Wolfs
//
//  Description   : The branch predictor for the ceespu, using the gshare scheme
//
//
//==================================================================================================
`include "ceespu_constants.vh"

module ceespu_branch_predictor (
         input clk,
         input rst,
         input [31:0] I_instruction,
         input [24:0] I_PC,
         input [15:0] branch_address,
         input [1:0]  branch_prediction_state,
         input branch_taken,
         input update_table,
         output [1:0] prediction_state,
         output [24:0] O_predictedBranchTarget,
         output reg prediction
       );
parameter PREDICTION_TABLE_SIZE = 6; // 2^6 = 64
localparam weakly_nontacken = 1, strongly_nontacken = 0, weakly_tacken = 2, strongly_tacken = 3;

reg [1:0] prediction_table [(2 ** PREDICTION_TABLE_SIZE) - 1:0];
reg [PREDICTION_TABLE_SIZE-1:0] branch_history = 0;
wire [1:0] prediction_state;
reg  [1:0] new_state;

reg [PREDICTION_TABLE_SIZE:0] k;
initial begin
  for (k = 0; k <= 63; k = k + 1) begin
    prediction_table[k] = weakly_tacken;
  end
end

assign prediction_state = prediction_table[branch_address[PREDICTION_TABLE_SIZE+2:2] ^ branch_history];

always @(*) begin
  O_branchTarget = 32'hxxxx;
  if(`opcode == `BRANCH) begin
    // non conditional branch, always taken, except if the branch target is in a register
    prediction = ~ I_instruction[1];
    O_branchTarget = {I_instruction[25:2], 2'b00};
  end
  else if (I_instruction[31:29] == 3'b111 && !I_instruction[1]) begin
    prediction = prediction_state[1];
    O_branchTarget = I_PC + { {11{I_instruction[25]}, I_instruction[25:21]}, {I_instruction[10:2], 2'b00} };
  end
  else begin
    prediction = 0;
  end
  case (branch_prediction_state)
    weakly_nontacken: begin
      if(branch_taken) begin
        new_state = weakly_tacken;
      end
      else begin
        new_state = strongly_nontacken;
      end
    end
    strongly_nontacken: begin
      if(branch_taken) begin
        new_state = weakly_nontacken;
      end
      else begin
        new_state = strongly_nontacken;
      end
    end
    weakly_tacken: begin
      if(branch_taken) begin
        new_state = strongly_tacken;
      end
      else begin
        new_state = weakly_nontacken;
      end
    end
    strongly_tacken: begin
      if(branch_taken) begin
        new_state = strongly_tacken;
      end
      else begin
        new_state = weakly_tacken;
      end
    end
  endcase
end

always @(posedge clk) begin
  if(rst) begin
    branch_history <= 0;
  end
  else begin
    if(update_table) begin
      prediction_table[branch_address[PREDICTION_TABLE_SIZE+2:2] ^ branch_history] <= new_state;
      branch_history <= {branch_taken, branch_history[PREDICTION_TABLE_SIZE-2:0]};
    end
  end
end

endmodule
