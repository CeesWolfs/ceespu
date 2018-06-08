`timescale 1ns / 1ps
// The main gpu module for the ceespu system on chip, intended to work with hdmi controller
module ceespu_gpu(
  input I_clk,
  input I_sys_clk,
  input I_sys_rst,
  input [3:0]  I_sys_write_enable,
  input [15:0] I_sys_address,
  input [31:0] I_sys_data,
  output [3:0] O_tmds,
  output [3:0] O_tmdsb
);

  wire pix_clk;

  wire [10:0] x;
  wire [9:0] y;

  wire pixel; 

  wire [7:0] red;
  wire [7:0] green;
  wire [7:0] blue;

  wire [7:0] colour;

  reg [10:0] tram_address;
  reg tram_enable;
  wire [6:0]  ascii_code;
  wire [15:0] colour_data;

  assign colour = pixel ? colour_data[7:0] : colour_data[15:8];

  assign red   = colour[7:5] << 5;
  assign green = colour[4:2] << 5;
  assign blue  = colour[1:0] << 6;

  hdmi_encoder hdmi (
    .clk(I_clk), 
    .rst(I_sys_rst), 
    .pclk(pix_clk), 
    .tmds(O_tmds), 
    .tmdsb(O_tmdsb), 
    .active(), 
    .x(x), 
    .y(y), 
    .red(red), 
    .green(green), 
    .blue(blue)
  );

  ceespu_font_mem font (
    .clk(pix_clk), 
    .ascii_code(ascii_code), 
    .row(y[3:0]), 
    .col(x[2:0]+1), 
    .pixel(pixel)
  );

  text_ram text (
    .clka(I_sys_clk), // input clka
    .ena(I_sys_address[15:11] == 5'b11111), // input ena
    .wea(I_sys_write_enable), // input [3 : 0] wea
    .addra(I_sys_address[10:2]), // input [8 : 0] addra
    .dina(I_sys_data), // input [31 : 0] dina
    .clkb(pix_clk), // input clkb
    .enb(tram_enable), // input enb
    .addrb(tram_address), // input [10 : 0] addrb
    .doutb(ascii_code) // output [7 : 0] doutb
  );
  colour_ram colours (
    .clka(I_sys_clk), // input clka
    .ena(I_sys_address[15:12] == 4'b1110), // input ena
    .wea(I_sys_write_enable), // input [3 : 0] wea
    .addra(I_sys_address[11:2]), // input [8 : 0] addra
    .dina(I_sys_data), // input [31 : 0] dina
    .clkb(pix_clk), // input clkb
    .enb(tram_enable), // input enb
    .addrb(tram_address), // input [10 : 0] addrb
    .doutb(colour_data) // output [7 : 0] doutb
  );

  always @ (posedge pix_clk) begin
    if (I_sys_rst) begin
      tram_address = 0;
      tram_enable = 0;
    end else begin
	   if (y[3:0] == 4'b1111) begin
	    tram_address = (((y[9:4] + 1) & 4'hF) << 4) + (((y[8:4] + 1 ) & 4'hF) << 6) + ((x[10:3] + 1) & 4'hF);
	   end
	   else begin
	    tram_address = (y[9:4] << 4) + (y[9:4] << 6) + ((x[10:3] + 1) & 4'hF);
	   end
      // The sequence of getting a pixel to display is clocked by pix_x[2:0]
      // Font is 8x16 pixels, that is two 8-bit words for each line
      case (x[2:0])
        3'b110: tram_enable  = 1'b1;
        default: tram_enable = 1'b0;
      endcase
    end
  end 
endmodule