`timescale 1ns / 1ps
// The main gpu module for the ceespu system on chip, intended to work with hdmi controller
module ceespu_gpu(
         input I_pix_clk,
         input I_sys_clk,
         input [3:0]  I_sys_write_enable,
         input [24:0] I_sys_address,
         input [31:0] I_sys_data,
         input [9:0] x,
         input [8:0] y,
         output [7:0] red,
         output [7:0] green,
         output [7:0] blue
       );

wire  [6:0] column;        // 80 columns
wire  [4:0] row;           // 30 rows
wire [11:0] text_address;
wire  [7:0] ascii_code;    // character to display

reg  [2:0] glyph_x;       // coordinates
reg  [3:0] glyph_y;       // in the grid of the glyph
wire [13:0] glyph_address;

wire [7:0] colour_data;
reg  [7:0] colour_delayed;
reg  [3:0] colour;
wire pixel;

// (column, row) = (x / 8, y / 16)
assign column = x[9:3];
assign row = y[8:4];
assign text_address = column + (row * 80);


// here we get the remainder
// it's delayed of the one clock cycle needed
// to sync with the value from the text memory
always @(posedge clk) begin
  glyph_x <= x[2:0];
  glyph_y <= y[3:0];
  colour_delayed  <= colour_data; // todo use output regs of bram
end

// text_value * (8*16) + glyph_x + (glyph_y * 8)
assign glyph_address = (text_value << 7) + glyph_x + (glyph_y << 3);



assign colour = pixel ? colour_delayed[3:0] : colour_delayed[7:4];

ceespu_colour_palette colour_pallete(
                        .I_colour(colour),
                        .red     (red),
                        .green   (green),
                        .blue    (blue)
                      );

ceespu_font_mem font_rom (
                  .clk(pix_clk),
                  .ascii_code(ascii_code),
                  .row(glyph_x),
                  .col(glyph_y),
                  .pixel(pixel)
                );

text_ram text (
           .clka(I_sys_clk), // input clka
           .ena(I_sys_address[15:11] == 5'b1_1111), // input ena
           .wea(I_sys_write_enable), // input [3 : 0] wea
           .addra(I_sys_address[10:2]), // input [8 : 0] addra
           .dina(I_sys_data), // input [31 : 0] dina
           .clkb(pix_clk), // input clkb
           .enb(1'b1), // input enb
           .addrb(text_address), // input [10 : 0] addrb
           .doutb(ascii_code) // output [7 : 0] doutb
         );
colour_ram colours (
             .clka(I_sys_clk), // input clka
             .ena(I_sys_address[15:11] == 5'b1_1110), // input ena
             .wea(I_sys_write_enable), // input [3 : 0] wea
             .addra(I_sys_address[10:2]), // input [8 : 0] addra
             .dina(I_sys_data), // input [31 : 0] dina
             .clkb(pix_clk), // input clkb
             .enb(1'b1), // input enb
             .addrb(text_address), // input [10 : 0] addrb
             .doutb(colour_data) // output [7 : 0] doutb
           );
