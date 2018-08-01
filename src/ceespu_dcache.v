//==================================================================================================
//  Filename      : ceespu_dcache.v
//  Created On    : 2018-07-24 16:55:40
//  Last Modified : 2018-08-01 22:12:40
//  Revision      :
//  Author        : Cees Wolfs
//
//  Description   : The data memory cache for the ceespu, implemented as a 2-way associative cache
//
//
//==================================================================================================
module ceespu_dcache (
         input I_clk,    // Clock
         input I_rst,
         // ceespu interface
         input [24:0] I_address,
         input [3:0]  I_writeMask,
         input [31:0] I_writeData,
         input I_isWrite,
         input I_memEnable,
         output [31:0] O_readData,
         output reg O_stall,

         // block ram interface
         input [63:0] I_blockramdata,
         output [63:0] O_blockramwdata,
         output [7:0] O_blockreamwriteEnable,
         output [SETBITS + OFFSETBITS:3] O_blockramaddress,
         output reg O_blockramEnable,
         
         // tag ram interface
         output reg [SETBITS:0] O_tagaddres,
         input [2*(TAGBBITS+2)+1:0] I_tagdata,
         output reg [2*(TAGBBITS+2)-1:0] O_tagwdata,
         output O_tagwe

         // sdram controller interface
         output [22:0] sdram_addr,
         input  [31:0] sdram_data,
         input  sdram_valid,
         input  sdram_busy,
         output [31:0] sdram_wdata,
         output sdram_iswrite,
         output sdram_new_command

       );
parameter ADDR_BITS = 25;
parameter CACHE_SIZE = 32 * 1024;
parameter BLOCK_SIZE = 32;

localparam NUMBLOCKS = CACHE_SIZE / BLOCK_SIZE;
localparam SETBITS = $log2(NUMBLOCKS) - 1; // two way associative
localparam TAGBITS = ADDR_BITS - SETBITS - OFFSETBITS;
localparam OFFSETBITS = $log2(BLOCK_SIZE);

localparam IDLE = 0, READ = 1, FETCH = 2, WRITE = 3, UPDATECACHE = 4;
reg [3:0] state, new_state = IDLE;

localparam valid_bit = TAGBBITS + 2;
localparam dirty_bit = TAGBBITS + 1;
localparam used_bit  = TAGBBITS;
// tag entries look like | VALID | DIRTY | USED | TAG[4:0] |
reg [TAGBBITS+2:0] tag1, tag0;

reg replace_set;

reg [OFFSETBITS-1:0] received_counter, new_received_counter, fill_counter, new_fill_counter = 0;

reg [ADDR_BITS-1:0] new_cached_addr, cached_addr;

assign O_blockwramdata    = {I_writeData, I_writeData};
assign O_blockramaddress = I_address[SETBITS+OFFSETBITS  - 1: 3];
assign O_tagwdata = {tag0, tag1};

always @(*) begin 
  {tag1, tag0} = I_tagdata;
  O_tagdata = 16'hxxxx;
  replace_set = 1'bx;
  O_readData  = 32'hxxxxxxxx; 
  sdram_new_command = 0;
  sdram_iswrite = 1'bx;
  new_received_counter = received_counter;
  new_fill_counter = fill_counter;
  O_blockreamwriteEnable = 8'h00;
  O_tagwe = 0;
  O_tagaddres = I_address[SETBITS+OFFSETBITS-1:OFFSETBITS];
  new_cached_addr = cached_addr;
  O_stall = 0;
  O_valid = 0;
  case (state)
    IDLE: begin 
      new_cached_addr = I_address;
      if(I_memEnable) begin
        new_state = I_isWrite ? WRITE : READ;
      end
    end
    READ: begin 
      new_cached_addr = I_address;
      if(tag0[TAGBBITS-1:0] == I_address[ADDR_BITS-1:ADDR_BITS-TAGBITS] && tag0[valid_bit]) begin 
        // cache hit in first slot0
        O_tagwe = 1;
        tag0[used_bit] = 1;
        tag1[used_bit] = 0;
        O_readData = I_blockramdata[31:0];
      end
      else if(tag1[TAGBBITS-1:0] == I_address[ADDR_BITS-1:ADDR_BITS-TAGBITS] && tag1[valid_bit]) begin
        new_state = IDLE;
        O_tagwe = 1;
        tag0[used_bit] = 0;
        tag1[used_bit] = 1;
        O_readData = I_blockramdata[63:32];
      end
      else begin 
        // cache miss, stall and fetch from sdram
        O_stall = 1;
        replace_set = tag0[used_bit]; // if tag0 was used most recently replace other one
        if(replace_set == 1) begin
          new_state = tag1[dirty_bit] ? UPDATECACHE : FETCH;
          tag1[valid_bit] = 1;
          tag1[dirty_bit] = 0;
          tag1[used_bit]  = 1;
          tag1[TAGBBITS-1] = cached_addr[ADDR_BITS-1:ADDR_BITS-TAGBITS];
        end
        else begin 
          new_state = tag0[dirty_bit] ? UPDATECACHE : FETCH;
          tag0[valid_bit] = 1;
          tag0[dirty_bit] = 0;
          tag0[used_bit]  = 1;
          tag0[TAGBBITS-1] = cached_addr[ADDR_BITS-1:ADDR_BITS-TAGBITS];
        end
        O_tagaddres = cached_addr[SETBITS+OFFSETBITS-1:OFFSETBITS];
        O_tagwe = 1;
      end
    end
    WRITE: begin 
      if(tag0[TAGBBITS-1:0] == I_address[ADDR_BITS-1:ADDR_BITS-TAGBITS] && tag0[valid_bit]) begin 
        // cache hit in first slot0
        new_state = IDLE;
        O_tagwe = 1;
        tag0[used_bit] = 1;
        tag0[dirty_bit] = 1;
        tag1[used_bit] = 0;
        O_blockreamwriteEnable = {4'h0, I_writeMask};
      end
      else if(tag1[TAGBBITS-1:0] == I_address[ADDR_BITS-1:ADDR_BITS-TAGBITS] && tag1[valid_bit]) begin
        new_state = IDLE;
        O_tagwe = 1;
        tag0[used_bit] = 0;
        tag1[used_bit] = 1;
        tag1[dirty_bit] = 1;
        O_blockreamwriteEnable = {I_writeMask, 4'h0};
      end
      else begin 
        // cache miss, stall and fetch from sdram
        O_stall = 1;
        replace_set = tag0[used_bit]; // if tag0 was used most recently replace other one
        if(replace_set == 1) begin
          new_state = tag1[dirty_bit] ? UPDATECACHE : FETCH;
          tag1[valid_bit] = 1;
          tag1[dirty_bit] = 0;
          tag1[used_bit]  = 1;
          tag1[TAGBBITS-1] = cached_addr[ADDR_BITS-1:ADDR_BITS-TAGBITS];
        end
        else begin 
          new_state = tag0[dirty_bit] ? UPDATECACHE : FETCH;
          tag0[valid_bit] = 1;
          tag0[dirty_bit] = 0;
          tag0[used_bit]  = 1;
          tag0[TAGBBITS-1] = cached_addr[ADDR_BITS-1:ADDR_BITS-TAGBITS];
        end
        O_tagaddres = cached_addr[SETBITS+OFFSETBITS-1:OFFSETBITS];
        O_tagwe = 1;
      end
    end
    UPDATECACHE: begin 
      O_stall = 1;
      sdram_iswrite = 1;
      if(! sdram_busy ) begin
        sdram_new_command = 1;
        new_fill_counter = fill_counter + 4;
        if(fill_counter == BLOCK_SIZE - 4) begin
          // we are done writing to main memory, go to fetch state
          new_state = FETCH;
        end
      end
    end
    FETCH: begin
      O_tagwe = 0;
      sdram_iswrite = 0;
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
    default : $display("What the fuck Jeroen! dit hoort niet te kunnen")/* default */;
  endcase
end

always @(posedge clk) begin : proc_state
  if(rst) begin
    fill_counter <= 0;
    received_counter <= 0;
    state <= IDLE;
  end
  else begin
    fill_counter <= new_fill_counter;
    received_counter <= new_received_counter;
    state <= new_state;
  end
end

endmodule
