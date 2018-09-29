//==================================================================================================
//  Filename      : ceespu_memory_bus.v
//  Created On    : 2018-07-22 10:56:34
//  Last Modified : 2018-07-23 16:33:16
//  Revision      : 
//  Author        : Cees Wolfs
//
//  Description   : The memory bus for the ceespu
//
//
//==================================================================================================
`include "ceespu_constants.vh"

module ceespu_memory_bus(
	input [15:0] O_dmemAddress, 
	input [31:0] I_gpuData,
	input [31:0] I_dmemData
	input [7:0]  I_uartRxData,
	output O_gpuMemEnable,
	output O_dmemEnable,
	output O_dmemData
	);

reg gpu_mem_enable;
reg rx_enabled;

always @(posedge clk) begin
	if (O_dmemAddress == 65528) begin
		rx_enabled <= 1;
	end
	else if (O_dmemAddress[15:11] == 5'b1111?) begin
		gpu_mem_enable <= 1;
	end
	else begin
		rx_enabled <= 0;
		gpu_mem_enable <= 0;
	end
end

assign O_gpuMemEnable = gpu_mem_enable;

always @(*) begin
	if (rx_enabled) begin
		O_dmemData = I_uartRxData;
	end
	else if (gpu_mem_enable) begin
		O_dmemData = I_gpuData;
	end
	else begin
		O_dmemData = I_dmemData;
	end
end