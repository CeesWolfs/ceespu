`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date:    14:13:30 01/09/2017
// Design Name:
// Module Name:    timer
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
module timer(
         input I_clk,
         input I_rst,
         output reg O_pulse = 0
       );

reg [16:0] timer = 0;

always @(posedge I_clk) begin
  if( I_rst ) begin
    timer <= 0;
    O_pulse <= 0;
  end
  else if (timer == 104999) begin
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
