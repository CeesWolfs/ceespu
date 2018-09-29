
//==================================================================================================
//  Filename      : ceespu_writeback.v
//  Created On    : 2018-07-21 21:14:45
//  Last Modified : 2018-09-29 08:25:06
//  Revision      : 
//  Author        : Cees Wolfs
//
//  Description   : The writeback selector, selects which value is written back to the register file
//
//
//==================================================================================================
`timescale 1ns / 1ps
module ceespu_writeback (
         input I_clk,
         input I_rst,
         input [1:0] I_selWb,
         input [2:0] I_selMem,
         input [13:0] I_PC,
         input [31:0] I_aluResult,
         input [31:0] I_dmemData,
         output reg [31:0] O_writeData
       );

always @(*) begin
  // standard writeback
  if (I_selWb == 2'b00) begin
    O_writeData = I_aluResult;
  end
  // memory writeback
  else if (I_selWb == 2'b01) begin
    // load word
    if (I_selMem == 3'd0) begin
      O_writeData = I_dmemData;
    end
    // load half word signed
    else if (I_selMem == 3'd1) begin
      O_writeData = (I_aluResult[1]) ? {{16{I_dmemData[31]}}, I_dmemData[31:16]} : {{16{I_dmemData[15]}}, I_dmemData[15:0]};
    end
    // load byte signed
    else if (I_selMem == 3'd2) begin
      case ( I_aluResult[1:0] )
        0: O_writeData = {{24{I_dmemData[7]}}, I_dmemData[7:0]};
        1: O_writeData = {{24{I_dmemData[15]}}, I_dmemData[15:8]};
        2: O_writeData = {{24{I_dmemData[23]}}, I_dmemData[23:16]};
        3: O_writeData = {{24{I_dmemData[31]}} , I_dmemData[31:24]};
      endcase
    end
    // load halfword unsigned
    else if (I_selMem == 3'd3) begin
      O_writeData = (I_aluResult[1]) ? I_dmemData[31:16] : I_dmemData[15:0];
    end
    // load byte unsigned
    else begin
      case ( I_aluResult[1:0] )
        0: O_writeData = I_dmemData[7:0];
        1: O_writeData = I_dmemData[15:8];
        2: O_writeData = I_dmemData[23:16];
        3: O_writeData = I_dmemData[31:24];
      endcase
    end
  end
  // branch so write PC
  else begin
    O_writeData = (I_PC << 2);
    $display("call c19 = %d", I_PC);
  end
end
endmodule // ceespu_writeback
