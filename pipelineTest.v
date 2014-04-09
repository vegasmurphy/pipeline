`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   16:19:14 04/08/2014
// Design Name:   Pipeline
// Module Name:   C:/Users/Marcelo/Documents/Xilinx/ArquitecturaPIPELINE/pipelineTest.v
// Project Name:  ArquitecturaPIPELINE
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Pipeline
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module pipelineTest;

	// Inputs
	reg clk;

	// Outputs
	wire [3:0] aluInstruction;
	wire [31:0] instruction_IF;
	wire [31:0] PC_sumado_IF;
	wire [31:0] instruction_ID;
	wire [31:0] Read_Data_1_ID;
	wire [31:0] Read_Data_2_ID;
	wire [31:0] signExtended_ID;
	wire [31:0] PC_sumado_ID;
	wire RegDest_ID;
	wire Branch_ID;
	wire MemRead_ID;
	wire MemToReg_ID;
	wire ALUOp1_ID;
	wire ALUOp2_ID;
	wire MemWrite_ID;
	wire ALUSrc_ID;
	wire RegWrite_ID;
	wire Jump_ID;
	wire [31:0] PC_sumado_EX;
	wire [31:0] Read_Data_1_EX;
	wire [31:0] Read_Data_2_EX;
	wire [31:0] signExtended_EX;
	wire [31:0] instruction_EX;
	wire RegDest_EX;
	wire Branch_EX;
	wire MemRead_EX;
	wire MemToReg_EX;
	wire ALUOp1_EX;
	wire ALUOp2_EX;
	wire MemWrite_EX;
	wire ALUSrc_EX;
	wire RegWrite_EX;
	wire Jump_EX;
	wire [31:0] PC_next_EX;
	wire [31:0] ALU_result_EX;
	wire [31:0] PC_next_MEM;
	wire [31:0] ALU_result_MEM;
	wire [31:0] Read_Data_2_MEM;
	wire Zero_EX;
	wire [4:0] Write_register_EX;
	wire Branch_MEM;
	wire MemRead_MEM;
	wire MemToReg_MEM;
	wire MemWrite_MEM;
	wire RegWrite_MEM;
	wire Jump_MEM;
	wire Zero_MEM;
	wire [4:0] Write_register_MEM;
	wire [31:0] Read_data_MEM;
	wire [31:0] Read_data_WB;
	wire [31:0] ALU_result_WB;
	wire MemToReg_WB;
	wire RegWrite_WB;
	wire [4:0] Write_register_WB;

	// Instantiate the Unit Under Test (UUT)
	Pipeline uut (
		.clk(clk), 
		.aluInstruction(aluInstruction), 
		.instruction_IF(instruction_IF), 
		.PC_sumado_IF(PC_sumado_IF), 
		.instruction_ID(instruction_ID), 
		.Read_Data_1_ID(Read_Data_1_ID), 
		.Read_Data_2_ID(Read_Data_2_ID), 
		.signExtended_ID(signExtended_ID), 
		.PC_sumado_ID(PC_sumado_ID), 
		.RegDest_ID(RegDest_ID), 
		.Branch_ID(Branch_ID), 
		.MemRead_ID(MemRead_ID), 
		.MemToReg_ID(MemToReg_ID), 
		.ALUOp1_ID(ALUOp1_ID), 
		.ALUOp2_ID(ALUOp2_ID), 
		.MemWrite_ID(MemWrite_ID), 
		.ALUSrc_ID(ALUSrc_ID), 
		.RegWrite_ID(RegWrite_ID), 
		.Jump_ID(Jump_ID), 
		.PC_sumado_EX(PC_sumado_EX), 
		.Read_Data_1_EX(Read_Data_1_EX), 
		.Read_Data_2_EX(Read_Data_2_EX), 
		.signExtended_EX(signExtended_EX), 
		.instruction_EX(instruction_EX), 
		.RegDest_EX(RegDest_EX), 
		.Branch_EX(Branch_EX), 
		.MemRead_EX(MemRead_EX), 
		.MemToReg_EX(MemToReg_EX), 
		.ALUOp1_EX(ALUOp1_EX), 
		.ALUOp2_EX(ALUOp2_EX), 
		.MemWrite_EX(MemWrite_EX), 
		.ALUSrc_EX(ALUSrc_EX), 
		.RegWrite_EX(RegWrite_EX), 
		.Jump_EX(Jump_EX), 
		.PC_next_EX(PC_next_EX), 
		.ALU_result_EX(ALU_result_EX), 
		.PC_next_MEM(PC_next_MEM), 
		.ALU_result_MEM(ALU_result_MEM), 
		.Read_Data_2_MEM(Read_Data_2_MEM), 
		.Zero_EX(Zero_EX), 
		.Write_register_EX(Write_register_EX), 
		.Branch_MEM(Branch_MEM), 
		.MemRead_MEM(MemRead_MEM), 
		.MemToReg_MEM(MemToReg_MEM), 
		.MemWrite_MEM(MemWrite_MEM), 
		.RegWrite_MEM(RegWrite_MEM), 
		.Jump_MEM(Jump_MEM), 
		.Zero_MEM(Zero_MEM), 
		.Write_register_MEM(Write_register_MEM), 
		.Read_data_MEM(Read_data_MEM), 
		.Read_data_WB(Read_data_WB), 
		.ALU_result_WB(ALU_result_WB), 
		.MemToReg_WB(MemToReg_WB), 
		.RegWrite_WB(RegWrite_WB), 
		.Write_register_WB(Write_register_WB)
	);

	always #10 clk=~clk;
	initial begin
		// Initialize Inputs
		clk = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
      
endmodule

