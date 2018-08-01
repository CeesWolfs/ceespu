module ceespu_colour_palette (
         input [3:0] I_colour,
         output [7:0] red,
         output [7:0] green,
         output [7:0] blue
       );

reg [23:0] rgb;
assign red = rgb[23:16];
assign green = rgb[15:8];
assign blue = rgb[7:0];

always @(*) begin
  case (I_colour)
    4'd0: rgb = {8'd20,8'd12,8'd28};
    4'd1: rgb = {8'd68,8'd36,8'd52};
    4'd2: rgb = {8'd48,8'd52,8'd109};
    4'd3: rgb = {8'd78,8'd74,8'd78};
    4'd4: rgb = {8'd133,8'd76,8'd48};
    4'd5: rgb = {8'd52,8'd101,8'd36};
    4'd6: rgb = {8'd208,8'd70,8'd72};
    4'd7: rgb = {8'd117,8'd113,8'd97};
    4'd8: rgb = {8'd89,8'd125,8'd206};
    4'd9: rgb = {8'd210,8'd125,8'd44};
    4'd10: rgb = {8'd133,8'd149,8'd161};
    4'd11: rgb = {8'd109,8'd170,8'd44};
    4'd12: rgb = {8'd210,8'd170,8'd153};
    4'd13: rgb = {8'd109,8'd194,8'd202};
    4'd14: rgb = {8'd218,8'd212,8'd94};
    4'd15: rgb = {8'd222,8'd238,8'd214};
  endcase
end

endmodule
