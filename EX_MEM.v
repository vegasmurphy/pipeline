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
	input [31:0] ALU_result_EX,
	input [31:0] Read_Data_2_EX,
	output reg [31:0] ALU_result_MEM,
	output reg [31:0] Read_Data_2_MEM,
	input BranchEQ_EX,
	input BranchNE_EX,
	input MemRead_EX,
	input MemToReg_EX,
	input MemWrite_EX,
	input RegWrite_EX,
	input Jump_EX,
	input [1:0] trunkMode_EX,
	input ShiftToTrunk_EX,
	input Zero_EX,
	input [4:0] Write_register_EX,
	output reg BranchEQ_MEM,
	output reg BranchNE_MEM,
	output reg MemRead_MEM,
	output reg MemToReg_MEM,
	output reg MemWrite_MEM,
	output reg RegWrite_MEM,
	output reg Jump_MEM,
	output reg [1:0] trunkMode_MEM,
	output reg ShiftToTrunk_MEM,
	output reg Zero_MEM,
	output reg [4:0] Write_register_MEM
    );

	initial
	begin
	BranchEQ_MEM=0;
	BranchNE_MEM=0;
	MemRead_MEM=0;
	MemToReg_MEM=0;
	MemWrite_MEM=0;
	RegWrite_MEM=0;
	Jump_MEM=0;
	Zero_MEM=0;
	Write_register_MEM=0;
	ALU_result_MEM=0;
	Read_Data_2_MEM=0;
	trunkMode_MEM=0;
	ShiftToTrunk_MEM=0;
	end

	always@(posedge clk)
	begin
		ALU_result_MEM <= ALU_result_EX;
		Read_Data_2_MEM <= Read_Data_2_EX;
		BranchEQ_MEM<=BranchEQ_EX;
		BranchNE_MEM<=BranchNE_EX;
		MemRead_MEM<=MemRead_EX;
		MemToReg_MEM<=MemToReg_EX;
		MemWrite_MEM<=MemWrite_EX;
		RegWrite_MEM<=RegWrite_EX;
		Jump_MEM<=Jump_EX;
		Zero_MEM<=Zero_EX;
		trunkMode_MEM<=trunkMode_EX;
		ShiftToTrunk_MEM<=ShiftToTrunk_EX;
		Write_register_MEM[4:0]<=Write_register_EX[4:0];
	end



endmodule
