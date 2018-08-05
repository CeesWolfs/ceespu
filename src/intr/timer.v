`timescale 1ns / 1ps
// Copyright (c) 2018 Cees Wolfs
//
// Module: timer
// Project: Ceespu
// Description: Simple timer that sends out an interrupt every millisecond

#include "../ceespu_constants.vh"

 module timer(
   input I_clk,
   input I_rst,
   output reg O_pulse = 0
 );

reg [$clog2(CLOCK_SPEED):0] timer = 0;

always @(posedge I_clk) begin
  if( I_rst ) begin
    timer <= 0;
    O_pulse <= 0;
  end
  else if (timer == CLOCK_SPEED) begin
    timer <= 0;
    O_pulse <= 1;
    $display("timer pulse at %d", $time);
  end
  else begin
    timer <= timer + 1;
    O_pulse <= 0;
  end
end

endmodule
