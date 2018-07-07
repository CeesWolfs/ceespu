`timescale 1ns / 1ps
// Copyright (c) 2018 Cees Wolfs
//
// Module: int_controller
// Project: Ceespu
// Description: The interrupt controller, that can interrupt the processor if something happens

module intr_controller(
         input I_clk,
         input I_rst,
         input [2:0] I_intr_rq,
         input I_intr_ack,
         output reg O_intr = 0,
         output reg [1:0] O_intr_vector = 0
       );

reg wait_state = 0;
reg [2:0] intr_rq = 0;

always @(posedge I_clk)
begin
  if (I_intr_rq[1]) begin
    intr_rq[1] <= 1;
  end
  if (I_intr_rq[2]) begin
    intr_rq[2] <= 1;
  end
  if (wait_state) begin
    if (I_intr_ack) begin
      wait_state <= 0;
      intr_rq[O_intr_vector] <= 0;
      O_intr <= 0;
    end
  end else begin
    if(intr_rq[1]) begin
      O_intr <= 1;
      O_intr_vector <= 1;
      wait_state <= 1;
      $display("intr_contr 1 is called vector = %d", O_intr_vector);
    end
    else if (intr_rq[2]) begin
      O_intr <= 1;
      O_intr_vector <= 2;
      wait_state <= 1;
      $display("intr_contr 2 is called vector = %d", O_intr_vector);
    end
  end
end
endmodule
