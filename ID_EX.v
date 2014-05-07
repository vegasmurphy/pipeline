`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:11:40 03/31/2014 
// Design Name: 
// Module Name:    ID_EX 
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
module ID_EX(
    input clk,
    input [31:0] Read_Data_1_ID,
    input [31:0] Read_Data_2_ID,
    input [31:0] signExtended_ID,
	 input [31:0] PC_sumado_ID,
	 input [31:0] instruction_ID,
	 input RegDest_ID,
	 input BranchEQ_ID,
	 input BranchNE_ID,
	 input MemRead_ID,
	 input MemToReg_ID,
	 input ALUOp1_ID,
	 input ALUOp2_ID,
	 input MemWrite_ID,
	 input ALUSrc_ID,
	 input RegWrite_ID,
	 input Jump_ID,
	 input [1:0] trunkMode_ID,
	 input ShiftToTrunk_ID,
	 output reg [31:0] PC_sumado_EX,
    output reg [31:0] Read_Data_1_EX,
    output reg [31:0] Read_Data_2_EX,
    output reg [31:0] signExtended_EX,
	 output reg [31:0] instruction_EX,
	 output reg RegDest_EX,
	 output reg BranchEQ_EX,
	 output reg BranchNE_EX,
	 output reg MemRead_EX,
	 output reg MemToReg_EX,
	 output reg ALUOp1_EX,
	 output reg ALUOp2_EX,
	 output reg MemWrite_EX,
	 output reg ALUSrc_EX,
	 output reg RegWrite_EX,
	 output reg Jump_EX,
	 output reg [1:0] trunkMode_EX,
	 output reg ShiftToTrunk_EX
    );
initial
	begin
		PC_sumado_EX=0;
		Read_Data_1_EX=0;
		Read_Data_2_EX=0;
		signExtended_EX=0;
		instruction_EX=0;
		RegDest_EX=0;
		BranchEQ_EX=0;
		BranchNE_EX=0;
		MemRead_EX=0;
		MemToReg_EX=0;
		ALUOp1_EX=0;
		ALUOp2_EX=0;
		MemWrite_EX=0;
		ALUSrc_EX=0;
		RegWrite_EX=0;
		Jump_EX=0;
		trunkMode_EX=2'b00;
		ShiftToTrunk_EX=0;
	end
always @(posedge clk)
begin
	Read_Data_1_EX<=Read_Data_1_ID;
	Read_Data_2_EX<=Read_Data_2_ID;
	signExtended_EX<=signExtended_ID;
	instruction_EX<=instruction_ID;
	PC_sumado_EX<=PC_sumado_ID;
	RegDest_EX<=RegDest_ID;
	BranchEQ_EX<=BranchEQ_ID;
	BranchNE_EX<=BranchNE_ID;
	MemRead_EX<=MemRead_ID;
	MemToReg_EX<=MemToReg_ID;
	ALUOp1_EX<=ALUOp1_ID;
	ALUOp2_EX<=ALUOp2_ID;
	MemWrite_EX<=MemWrite_ID;
	ALUSrc_EX<=ALUSrc_ID;
	RegWrite_EX<=RegWrite_ID;
	Jump_EX<=Jump_ID;
	trunkMode_EX<=trunkMode_ID;
	ShiftToTrunk_EX<=ShiftToTrunk_ID;
end

endmodule
