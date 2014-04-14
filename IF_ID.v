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
	input IF_ID_write,
	input IF_Flush,
	output reg [31:0] instruction_ID,
	output reg [31:0] PC_sumado_ID
    );
	initial
	begin
	instruction_ID=0;
	PC_sumado_ID=0;
	end
	
	always@(posedge clk)
	begin
		if(IF_ID_write)
			begin
			if(IF_Flush)
				begin
				instruction_ID <= 0;
				PC_sumado_ID 	<= 0;
				end
			else
				begin
				instruction_ID <= instruction_IF;
				PC_sumado_ID 	<= PC_sumado_IF;	
				end
			end
		
	end


endmodule
