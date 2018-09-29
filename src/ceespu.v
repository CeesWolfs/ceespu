//==================================================================================================
//  Filename      : ceespu.v
//  Created On    : 2018-07-17 17:43:39
//  Last Modified : 2018-09-29 08:28:49
//  Revision      :
//  Author        : Cees Wolfs
//
//  Description   : The top module of the ceespu, wiring everything together
//
//
//==================================================================================================
`timescale 1ns / 1ps

module ceespu(
         input I_clk,
         input I_rst,
         input I_int_req,
         input [2:0] I_int_vector,
         input [31:0] I_imemData,
         output [15:0] O_imemAddress,
         output O_imemEnable,
			output O_imemReset, 
         input [31:0] I_dmemData,
         input I_dmemBusy,
         output O_int_ack,
         output [15:0] O_dmemAddress,
         output [31:0] O_dmemWData,
         output O_dmemE,
         output [3:0]  O_dmemWe
       );

wire [13:0] fetch_PC, dec_PC, dec_branchTarget, ex_branchTarget ,ex_PC;
wire branch, dec_stall, ex_stall, ex_busy, prediction;
wire [31:0] regA, regB, dec_dataA, dec_dataB, dec_storeData, wb_dataD, ex_aluResult;
reg  [31:0] aluA, aluB, storeData;
reg  [31:0] writeback_result;
reg  [31:0] instruction_memory = 0;
reg justBranched = 0;
wire [3:0] dec_aluop;
wire dec_we, dec_memE, dec_memWe, dec_isBranch, ex_we, interrupts_enabled, useRegB;
wire [4:0] dec_regD, ex_regD, dec_regA, dec_regB;
wire [1:0] dec_selCin, dec_selWb, ex_selWb;
wire [2:0] dec_selMem, ex_selMem;
wire [2:0] dec_branchOp;
wire [1:0] prediction_state;

reg [1:0] prediction_state_1, prediction_state_2;
reg prediction_1, prediction_2;

reg stall = 0;
reg bubble = 0;
reg [1:0] forwardA = 0;
reg [1:0] forwardB = 0;
reg [1:0] forwardStore = 0;

assign O_imemAddress = {fetch_PC, 2'b00};
assign O_imemReset = branch_mispredict || prediction;
assign O_imemEnable = ! stall;

assign O_int_ack = I_int_req && interrupts_enabled;

ceespu_pc pc (
            .I_clk(I_clk),
            .I_rst(I_rst),
            .I_stall(stall),
            .I_branch(branch_mispredict || prediction),
            .I_branchAddress(branch_mispredict ? ex_branchTarget : I_imemData[10:2]), //FIXME conditional branches have other encoding types
            .O_PC(fetch_PC)
          );
ceespu_branch_predictor branch_predictor(
                          .prediction_state(prediction_state),
                          .prediction(prediction),
								          .I_PC(fetch_PC),
                          .clk(I_clk),
                          .rst(I_rst),
                          .I_instruction(I_imemData),
                          .branch_address(ex_PC),
                          .branch_prediction_state(prediction_state_2),
                          .branch_taken(branch_taken),
                          .update_table(dec_isBranch && (dec_branchOp != 3'b111)));
ceespu_decode decode (
                .I_clk(I_clk),
                .I_rst(I_rst),
                .I_flush(bubble || branch_mispredict),
                .I_stall(ex_busy),
                .I_regA(regA),
                .I_regB(regB),
                .I_instruction(instruction_memory),
                .I_PC(fetch_PC),
                .O_dataA(dec_dataA),
                .O_dataB(dec_dataB),
                .O_storeData(dec_storeData),
                .O_aluop(dec_aluop),
                .O_we(dec_we),
                .O_isBranch(dec_isBranch),
                .O_regD(dec_regD),
                .O_regA(dec_regA),
                .O_regB(dec_regB),
                .O_selCin(dec_selCin),
                .O_selMem(dec_selMem),
                .O_branchOp(dec_branchOp),
                .O_selWb(dec_selWb),
                .O_memE(dec_memE),
                .O_memWe(dec_memWe),
					      .useRegB(useRegB),
					      .did_interrupt(O_int_ack),
					      .interrupts_enabled(interrupts_enabled),
                .O_PC(dec_PC),
                .O_branchTarget(dec_branchTarget)
              );
ceespu_execute execute (
                 .I_clk(I_clk),
                 .I_rst(I_rst),
                 .I_aluop(dec_aluop),
                 .I_we(dec_we),
                 .I_selWb(dec_selWb),
                 .I_isBranch(dec_isBranch),
                 .I_branchop(dec_branchOp),
                 .I_storeData(storeData),
                 .I_dataA(aluA),
                 .I_dataB(aluB),
                 .I_selCin(dec_selCin),
                 .I_regD(dec_regD),
                 .I_memE(dec_memE),
                 .I_memWe(dec_memWe),
                 .I_selMem(dec_selMem),
                 .I_PC(dec_PC),
					       .I_prediction(prediction_2),
                 .I_branchTarget(dec_branchTarget),
                 .O_branchTarget(ex_branchTarget),
                 .O_memAddress(O_dmemAddress),
                 .O_we(ex_we),
                 .O_aluResult(ex_aluResult),
                 .O_StoreData(O_dmemWData),
                 .O_selWb(ex_selWb),
                 .O_selMem(ex_selMem),
                 .O_memE(O_dmemE),
                 .O_memWe(O_dmemWe),
                 .O_PC(ex_PC),
                 .O_regD(ex_regD),
                 .O_busy(ex_busy),
                 .O_branch_mispredict(branch_mispredict),
                 .O_branch_taken(branch_taken)
               );
ceespu_writeback writeback (
                   .I_clk(I_clk),
                   .I_rst(I_rst),
                   .I_selWb(ex_selWb),
                   .I_selMem(ex_selMem),
                   .I_PC(ex_PC),
                   .I_aluResult(ex_aluResult),
                   .I_dmemData(I_dmemData),
                   .O_writeData(wb_dataD)
                 );
ceespu_regfile regfile (
                 .I_clk(I_clk),
                 .I_rst(I_rst),
                 .I_selA(dec_regA),
                 .I_selB(dec_regB),
                 .I_we(ex_we),
                 .I_selD(ex_regD),
                 .I_dataD(wb_dataD),
                 .O_dataA(regA),
                 .O_dataB(regB)
               );

always @(*) begin
  stall = 0;
  bubble = 0;
  if (dec_we & dec_memE & ((dec_regA == dec_regD) | (dec_regB == dec_regD))) begin
    $display( "memory_stall rA = %d, rB = %d, rD = %d at %d", dec_regA, dec_regB, dec_regD, $time);
    stall = 1; // Memory Hazard stall!
    bubble = 1; // insert nop instruction to stall
  end
  else begin
    stall = (ex_busy | I_dmemBusy);
  end
  case (forwardA)
    0: aluA = dec_dataA;
    1: aluA = ex_aluResult;
    2: aluA = writeback_result;
    3: aluA = 32'hx;
  endcase
  //if (dec_memE && dec_memWe) begin
  case (forwardStore)
    0: storeData = dec_storeData;
    1: storeData = ex_aluResult;
    2: storeData = writeback_result;
    3: storeData = 32'hx;
  endcase
  $display("at $time forwardA: %b, forwardB: %b", forwardA, forwardB);
  //end else begin
  case (forwardB)
    0: aluB = dec_dataB;
    1: aluB = ex_aluResult;
    2: aluB = writeback_result;
    3: aluB = 32'hx;
  endcase
end

always @(posedge I_clk) begin
  justBranched <= branch_mispredict;
  if ( branch_mispredict || I_rst) begin
    instruction_memory <= 0;
    forwardA <= 0;
    forwardB <= 0;
    writeback_result <= 0;
	 prediction_1 <= 0;
	 prediction_2 <= 0;
  end
  else if ( !stall ) begin
    writeback_result <= wb_dataD;
    instruction_memory <= I_imemData;
    prediction_state_1 <= prediction_state;
    prediction_state_2 <= prediction_state_1;
    prediction_2 <= prediction_1;
    $display("fetching addr:%d =  %h at %d", O_imemAddress, I_imemData, $time);
    if ( O_int_ack ) begin
      $display("decode: inserting INTERRUPT at pc_decode=0x%x, pc_exe=0x%x", dec_PC, ex_PC);
      instruction_memory <= {28'hFE00_000, {I_int_vector[2:0], 2'b00}};
		prediction_1 <= 0;
    end
	 else begin
	   prediction_1 <= prediction;
		instruction_memory <= I_imemData;
	 end
    if (dec_we && (dec_regA == dec_regD)) begin
      forwardA <= 1; //forward execute stage
    end
    else if (ex_we && (dec_regA == ex_regD)) begin
      // Data Hazard in writeback stage forward writeback
      forwardA <= 2;
      $display( "forwardA writeback at %d", $time);
    end
    else begin
      forwardA <= 0;
    end
    if (dec_we & dec_regB == dec_regD) begin
      forwardB <= useRegB ? 1 : 0; //forward execute stage
		forwardStore <= 1;
    end
    else if (ex_we && (dec_regB == ex_regD)) begin
      // Data Hazard in writeback stage forward writeback
      $display( "forwardB writeback at %d", $time);
      forwardB <= useRegB ? 2 : 0;
		forwardStore <= 2;
      //$display("forward writeback %d", )
    end
    else begin
      forwardB <= 0;
		forwardStore <= 0;
    end
  end
end

endmodule
