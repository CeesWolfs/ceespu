//==================================================================================================
//  Filename      : ceespu_icache.v
//  Created On    : 2018-07-24 18:05:13
//  Last Modified : 2018-07-26 09:40:02
//  Revision      :
//  Author        : Cees Wolfs
//
//  Description   : The instruction cache for the ceespu 24 kB of 1 kb pages
//
//
//==================================================================================================
module ceespu_icache (
         input I_clk,    // Clock
         input I_rst,
         // Ceespu interdace
         input [24:0] I_address,
         output [31:0] O_data,
         output reg O_valid,
         output reg O_stall,

         // block ram interface
         output [15:0] O_bramaddress,
         input [31:0] I_bramdata,

         // tag ram interface
         output [9:0] O_tagramaddr,
         input [15:0] I_tagdata,
         output [15:0] O_tagdata,
         output O_tagwe
         
         // Sdram controller interface


         //,
         // tag mem
         //input


       );
parameter CACHE_SIZE = 24 * 1024;
parameter BLOCK_SIZE = 256;
parameter ADDR_BITS  = 25;

localparam NUM_BLOCKS = CACHE_SIZE / BLOCK_SIZE;
localparam SETBITS = $log2(NUMBLOCKS) - 1; // two way associative
localparam TAGBITS = ADDR_BITS - SETBITS - OFFSETBITS;
localparam OFFSETBITS = $log2(BLOCK_SIZE);

localparam used_bit  = TAGBITS;
localparam valid_bit = TAGBITS + 1;

assign O_data = I_bramdata;
assign O_tagramaddr = I_address[SETBITS+OFFSETBITS:OFFSETBITS];

localparam HIT = 0, MISS = 1;
reg state, new_state;

reg [24:0] cached_addres;

always @(*) begin
  O_valid = 0;
  O_stall = 0;
  O_tagwe = 0;
  case (state)
    READ: begin 
      if(I_tagdata[TAGBBITS-1:0] == I_address[ADDR_BITS-1:ADDR_BITS-TAGBITS] && I_tagdata[valid_bit]) begin 
      	O_valid = 1;
      end
      else begin 
        // cache miss stall cpu and fetch
        new_state = MISS;
        O_stall = 1;
      end
    end
    MISS: begin 


    end

  
  	default : /* default */;
  endcase

end

always @(posedge clk) begin 
  if(rst) begin
  	cached_addres <= 0;
    state <= HIT;
  end
  else begin
  	if(! O_stall) begin
      cached_addres <= I_address;
  	end
    state <= new_state;
  end
end



endmodule
