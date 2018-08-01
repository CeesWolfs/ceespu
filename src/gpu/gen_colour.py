with open('colour_pallet.txt') as f:
    rgb = []
    for line in f: # read rest of lines
        rgb.append([int(x) for x in line.split()])
#print(rgb)
if len(rgb) != 16:
	print("Error please have 16 colours")
	raise "Number of colours is not 16"
templ = """module ceespu_colour (
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
  case (I_colour)"""
print(templ)
for x in range(0,16):
	print("    4'd"+str(x)+": rgb = {8'd"+str(rgb[x][0])+",8'd"+str(rgb[x][1])+",8'd"+str(rgb[x][2])+"};")
templ = """  endcase 
end

endmodule"""
print(templ)