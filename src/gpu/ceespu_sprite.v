module ceespu_sprite(
	input [10:0] x,
	input [9:0] y,
	input [31:0] new_data,
	input update,
	output active,
	output [11:0] bitmap_addres,
	output [1:0] pixel
	);

localparam SPRITE_WIDTH = 32;
localparam SPRITE_HEIGHT = 32;

reg [10:0] sprite_x;
reg [3:0]  sprite_y;
reg enabled;
reg [1:0] pixels [0:15];
reg [3:0] pattern;

assign active = ((x - sprite_x) >= 0 && (x - sprite_x) < SPRITE_WIDTH) && enabled);
assign pixel = pixels[x - sprite_x];

always @(posedge clk) begin
	if () begin
		
	end
end

endmodule