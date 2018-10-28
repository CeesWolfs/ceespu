module ceespu_sprite(
	input [10:0] x,
	input [9:0] y,
	input new_x,
	input new_y,
	input sys_we,
	output active,
	output bitmap_addr
	);

localparam SPRITE_WIDTH = 24;
localparam SPRITE_HEIGHT = 21;

reg [10:0] sprite_x;
reg [9:0]  sprite_y;

assign active = ((x - sprite_x) >= 0 && (x - sprite_x) < SPRITE_WIDTH) && ((y - sprite_y) >= 0 && (y - sprite_y) < SPRITE_HEIGHT);

assign bitmap_addr = ((y - sprite_y) << 4) + (y - sprite_y) << 3 + (x - sprite_x);

always @(posedge clk) begin
	else if (sys_we) begin
		
	end
end

endmodule