//==================================================================================================
//  Filename      : ceespu_icache.v
//  Created On    : 2018-07-24 18:05:13
//  Last Modified : 2018-08-01 10:52:29
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
         output [12:0] O_bramaddress,
         input [31:0] I_bramdata,
         output [12:0] O_bramwaddress,
         output [31:0] O_bramwdata,
         output reg [3:0]  O_bramwe,

         // tag ram interface
         output [9:0] O_tagramaddr,
         input [15:0] I_tagdata,
         output [9:0] O_tagwaddr,
         output [15:0] O_tagwdata,
         output reg O_tagwe,

         // Sdram controller interface
         input sdram_valid,
         input sdram_busy,
         output [22:0] sdram_addr,
         output reg sdram_new_command,
         input [31:0]  sdram_data
       );
parameter CACHE_SIZE = 24 * 1024;
parameter BLOCK_SIZE = 256;
parameter ADDR_BITS  = 25;

localparam NUM_BLOCKS = CACHE_SIZE / BLOCK_SIZE;
localparam SETBITS = $clog2(NUM_BLOCKS);
localparam OFFSETBITS = $clog2(BLOCK_SIZE);
localparam TAGBITS = ADDR_BITS - (SETBITS - 1) - OFFSETBITS;

localparam valid_bit = TAGBITS;

assign O_data = (state == FETCH) ? sdram_data : I_bramdata;
assign O_tagramaddr = I_address[SETBITS+OFFSETBITS-1:OFFSETBITS];
assign O_tagwaddr = cached_addr[SETBITS+OFFSETBITS-1:OFFSETBITS];
assign O_tagwdata = {1'b1, I_address[ADDR_BITS-1:ADDR_BITS-TAGBITS]}; // update tag
assign O_bramaddress = I_address[SETBITS+OFFSETBITS-1:2];
assign O_bramwaddress = {cached_addr[OFFSETBITS+SETBITS-1:OFFSETBITS], received_counter[OFFSETBITS-1:2]};
assign O_bramwdata = sdram_data;

localparam IDLE = 0, FETCH = 1;
reg state, new_state;

reg [24:0] new_cached_addr;
reg [24:0] cached_addr;
reg [OFFSETBITS-1:0] new_fill_counter, fill_counter, received_counter, new_received_counter = 0;

assign sdram_addr = {new_cached_addr[ADDR_BITS-1:OFFSETBITS], fill_counter[OFFSETBITS-1:2]};

always @(*) begin
  O_valid = 0;
  O_stall = 0;
  O_bramwe =0;
  sdram_new_command = 0;
  new_fill_counter = fill_counter;
  new_received_counter = received_counter;
  new_cached_addr = cached_addr;
  new_state = state;
  
  case (state)
    IDLE: begin
      O_tagwe = 1;
      new_fill_counter = 0;
      new_received_counter = 0;
      new_cached_addr = I_address;
      if((I_tagdata[TAGBITS-1:0] == cached_addr[ADDR_BITS-1:ADDR_BITS-TAGBITS]) && I_tagdata[valid_bit]) begin
        // cache hit
        O_valid = 1;
      end
      else begin
        // cache miss stall cpu and fetch
        new_state = FETCH;
        O_stall = 1;
        new_cached_addr = cached_addr;
      end
    end
    FETCH: begin
      O_tagwe = 0;
      new_cached_addr = cached_addr;
      O_stall = 1;

      if(!sdram_busy && (fill_counter != BLOCK_SIZE - 4)) begin
        // sdram can accept new command, provide that command
        sdram_new_command = 1;
        new_fill_counter = fill_counter + 4;
      end

      // cache data is valid
      if(sdram_valid) begin
        new_received_counter = received_counter + 4;
        O_bramwe = 4'b1111;
        if (received_counter == cached_addr[OFFSETBITS-1:0]) begin
          O_valid = 1; //still stall
        end
        if(received_counter == (BLOCK_SIZE - 4)) begin
          // we are done filing the cache line go back to IDLE state
          new_state = IDLE;
          O_stall = 0;
          new_cached_addr = I_address;
        end
      end
    end

    default : /* default */;
  endcase
end

always @(posedge I_clk) begin
  if(I_rst) begin
    cached_addr <= I_address;
    received_counter <= 0;
    state <= IDLE;
    fill_counter <= 0;
  end
  else begin
    fill_counter <= new_fill_counter;
    received_counter <= new_received_counter;
    cached_addr <= new_cached_addr;
    state <= new_state;
  end
end

endmodule
