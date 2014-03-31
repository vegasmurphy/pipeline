`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:19:52 03/31/2014 
// Design Name: 
// Module Name:    EX_MEM 
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
module EX_MEM(
	input clk,
	input [31:0] PC_next_EX,
	input zeroALU_EX,
	input [31:0] resultadoALU_EX,
	input [31:0] Read_Data_2_EX,
	output reg [31:0] PC_next_MEM,
	output reg zeroALU_MEM,
	output reg [31:0] resultadoALU_MEM,
	output reg [31:0] Read_Data_2_MEM
    );


	always@(posedge clk)
	begin
		PC_next_MEM <= PC_next_EX;
		zeroALU_MEM <= zeroALU_EX;
		resultadoALU_MEM <= resultadoALU_EX;
		Read_Data_2_MEM <= Read_Data_2_EX;
	
	end



endmodule
