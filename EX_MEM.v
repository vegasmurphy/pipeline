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
	input [31:0] ALU_result_EX,
	input [31:0] Read_Data_2_EX,
	output reg [31:0] PC_next_MEM=1,
	output reg [31:0] ALU_result_MEM,
	output reg [31:0] Read_Data_2_MEM,
	input Branch_EX,
	input MemRead_EX,
	input MemToReg_EX,
	input MemWrite_EX,
	input RegWrite_EX,
	input Jump_EX,
	input Zero_EX,
	input [4:0] Write_register_EX,
	output reg Branch_MEM,
	output reg MemRead_MEM,
	output reg MemToReg_MEM,
	output reg MemWrite_MEM,
	output reg RegWrite_MEM,
	output reg Jump_MEM,
	output reg Zero_MEM,
	output reg [4:0] Write_register_MEM
    );


	always@(posedge clk)
	begin
		PC_next_MEM <= PC_next_EX;
		ALU_result_MEM <= ALU_result_EX;
		Read_Data_2_MEM <= Read_Data_2_EX;
		Branch_MEM<=Branch_EX;
		MemRead_MEM<=MemRead_EX;
		MemToReg_MEM<=MemToReg_EX;
		MemWrite_MEM<=MemWrite_EX;
		RegWrite_MEM<=RegWrite_EX;
		Jump_MEM<=Jump_EX;
		Zero_MEM<=Zero_EX;
		Write_register_MEM[4:0]<=Write_register_EX[4:0];
	end



endmodule
