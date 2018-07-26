//==================================================================================================
//  Filename      : ceespu_dcache.v
//  Created On    : 2018-07-24 16:55:40
//  Last Modified : 2018-07-25 11:39:20
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
         output reg O_membusy,
         // block ram interface
         input [63:0] I_blockramdata,
         output [63:0] O_blockramdata,
         output [7:0] O_blockreamwriteEnable,
         output [SETBITS + OFFSETBITS:3] O_blockramaddress,
         output reg O_blockramEnable,
         // tag ram interface
         output [SETBITS:0] O_readtagaddres,
         input [2*(TAGBBITS+2)+1:0] I_tagdata,
         output reg [2*(TAGBBITS+2)+1:0] O_tagdata,
         output O_tagwe

         // sdram controller interface


       );
parameter ADDR_BITS = 25;
parameter CACHE_SIZE = 32 * 1024;
parameter BUCKET_SIZE = 32;

localparam NUMBUCKETS = CACHE_SIZE / BUCKET_SIZE;
localparam SETBITS = $log2(NUMBUCKETS) - 1; // two way associative
localparam TAGBITS = ADDR_BITS - SETBITS - OFFSETBITS;
localparam OFFSETBITS = $log2(BUCKET_SIZE);

localparam IDLE = 0, READ = 1, MISS = 2, WRITE = 3, WRITEMMEM = 4, UPDATECACHE = 5;
reg [3:0] state, new_state = IDLE;

localparam valid_bit = TAGBBITS + 2;
localparam dirty_bit = TAGBBITS + 1;
localparam used_bit  = TAGBBITS;
// tag entries look like | VALID | DIRTY | USED | TAG[4:0] |
reg [TAGBBITS+2:0] tag1, tag0;

reg replace_set;

assign O_blockramdata    = {I_writeData, I_writeData};
assign O_blockramaddress = I_address[SETBITS+OFFSETBITS : 3];
assign O_readtagaddres   = I_address[OFFSETBITS + SETBITS:OFFSETBITS];


always @(*) begin 
  {tag1, tag0} = I_tagdata;
  O_tagdata = 16'hxxxx;
  replace_set = 1'bx;
  O_readData  = 32'hxxxxxxxx; 
  O_blockreamwriteEnable = 8'h00;
  O_tagwe = 0;
  case (state)
    IDLE: begin 
      O_membusy = 0;
      if(I_memEnable) begin
        new_state = I_isWrite ? WRITE : READ;
      end
    end
    READ: begin 
      if(tag0[TAGBBITS-1:0] == I_address[ADDR_BITS-1:ADDR_BITS-TAGBITS] && tag0[valid_bit]) begin 
        // cache hit in first slot0
        new_state = IDLE;
        O_tagwe = 1;
        tag0[used_bit] = 1;
        tag1[used_bit] = 0;
        O_tagdata = {tag1, tag0};
      end
      else if(tag1[TAGBBITS-1:0] == I_address[ADDR_BITS-1:ADDR_BITS-TAGBITS] && tag1[valid_bit]) begin
        new_state = IDLE;
        O_tagwe = 1;
        tag0[used_bit] = 0;
        tag1[used_bit] = 1;
        O_tagdata = {tag1, tag0};
      end
      else begin 
        // cache miss fetch from sdram
        new_state = MISS;
        O_membusy = 1;
        replace_set = tag0[used_bit]; // if tag0 was used most recently replace other one
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
        O_tagdata = {tag1, tag0};
        O_blockreamwriteEnable = {4'h0, I_writeMask};
        O_readData = I_blockramdata[31:0];
      end
      else if(tag1[TAGBBITS-1:0] == I_address[ADDR_BITS-1:ADDR_BITS-TAGBITS] && tag1[valid_bit]) begin
        new_state = IDLE;
        O_tagwe = 1;
        tag0[used_bit] = 0;
        tag1[used_bit] = 1;
        tag1[dirty_bit] = 1;
        O_tagdata = {tag1, tag0};
        O_blockreamwriteEnable = {I_writeMask, 4'h0};
        O_readData = I_blockramdata[63:32];
      end
      else begin 
        // cache miss fetch from sdram
        new_state = MISS;
        O_membusy = 1;
        replace_set = tag0[used_bit]; // if tag0 was used most recently replace other one
      end
    end


    default : /* default */;
  endcase

end

always @(posedge clk) begin : proc_state
  if(rst) begin
    state <= IDLE;
  end
  else begin
    state <= new_state;
  end
end

endmodule
