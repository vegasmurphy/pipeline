`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:10:34 03/31/2014 
// Design Name: 
// Module Name:    IF_ID 
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
module IF_ID(
	input clk,
	input [31:0] instruction_IF,
	input [31:0] PC_sumado_IF,
	output reg [31:0] instruction_ID,
	output reg [31:0] PC_sumado_ID
    );

	
	always@(posedge clk)
	begin
		instruction_ID <= instruction_IF;
		PC_sumado_ID 	<= PC_sumado_IF;	
	end


endmodule