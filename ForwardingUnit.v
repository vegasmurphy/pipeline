`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:52:24 04/08/2014 
// Design Name: 
// Module Name:    ForwardingUnit 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module ForwardingUnit(
	input [4:0] rs_ex,
	input [4:0] rt_ex,
	input [4:0] rd_mem,
	input [4:0] rd_wb,
	input regWrite_mem,
	input regWrite_wb,
	output reg[1:0] forwardA,
	output reg[1:0] forwardB
    );

always @(*)
	begin
		forwardA=2'b00;
		forwardB=2'b00;
		if (regWrite_wb && rs_ex==rd_wb && rd_wb!=4'b0000)
			forwardA=2'b01;
		if (regWrite_wb && rt_ex==rd_wb && rd_wb!=4'b0000)
			forwardB=2'b01;
		if (regWrite_mem && rs_ex==rd_mem && rd_mem!=4'b0000)
			forwardA=2'b10;
		if (regWrite_mem && rt_ex==rd_mem && rd_mem!=4'b0000)
			forwardB=2'b10;	
	end



endmodule
