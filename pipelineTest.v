`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   16:55:54 06/04/2014
// Design Name:   Pipeline
// Module Name:   C:/Users/Marcelo/Documents/XilinxProjects/Pipeline/pipelineTest.v
// Project Name:  Pipeline
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
	reg debugClk;
	reg [31:0] DebugAddress;
	reg debugMode;

	// Outputs
	wire [4:0] aluInstruction;
	wire equalFlag;
	wire [31:0] rtData;
	wire [31:0] rsData;
	wire [31:0] reg_array0;
	wire [31:0] reg_array1;
	wire [31:0] reg_array2;
	wire [31:0] reg_array3;
	wire [31:0] reg_array4;
	wire [31:0] reg_array5;
	wire [31:0] reg_array6;
	wire [31:0] reg_array7;
	wire [31:0] reg_array8;
	wire [31:0] reg_array9;
	wire [31:0] reg_array10;
	wire [31:0] reg_array11;
	wire [31:0] reg_array12;
	wire [31:0] reg_array13;
	wire [31:0] reg_array14;
	wire [31:0] reg_array15;
	wire [31:0] reg_array16;
	wire [31:0] reg_array17;
	wire [31:0] reg_array18;
	wire [31:0] reg_array19;
	wire [31:0] reg_array20;
	wire [31:0] reg_array21;
	wire [31:0] reg_array22;
	wire [31:0] reg_array23;
	wire [31:0] reg_array24;
	wire [31:0] reg_array25;
	wire [31:0] reg_array26;
	wire [31:0] reg_array27;
	wire [31:0] reg_array28;
	wire [31:0] reg_array29;
	wire [31:0] reg_array30;
	wire [31:0] reg_array31;
	wire [31:0] instruction_IF;
	wire [31:0] PC_sumado_IF;
	wire [31:0] instruction_ID;
	wire savePc_ID;
	wire savePc_EX;
	wire savePc_MEM;
	wire savePc_WB;
	wire [31:0] Read_Data_1_ID;
	wire [31:0] Read_Data_2_ID;
	wire [31:0] signExtended_ID;
	wire [31:0] PC_sumado_ID;
	wire [31:0] PC_sumado_EX;
	wire [31:0] PC_sumado_MEM;
	wire [31:0] PC_sumado_WB;
	wire RegDest_ID;
	wire BranchEQ_ID;
	wire BranchNE_ID;
	wire MemRead_ID;
	wire MemToReg_ID;
	wire ALUOp1_ID;
	wire ALUOp2_ID;
	wire MemWrite_ID;
	wire ALUSrc_ID;
	wire RegWrite_ID;
	wire ShiftToTrunk_ID;
	wire [1:0] trunkMode_ID;
	wire [31:0] Read_Data_1_EX;
	wire [31:0] Read_Data_2_EX;
	wire [31:0] aluInput1;
	wire [31:0] aluInput2;
	wire [31:0] signExtended_EX;
	wire [31:0] instruction_EX;
	wire RegDest_EX;
	wire BranchEQ_EX;
	wire BranchNE_EX;
	wire MemRead_EX;
	wire MemToReg_EX;
	wire ALUOp1_EX;
	wire ALUOp2_EX;
	wire MemWrite_EX;
	wire ALUSrc_EX;
	wire RegWrite_EX;
	wire Jump_EX;
	wire [1:0] trunkMode_EX;
	wire ShiftToTrunk_EX;
	wire [31:0] PC_next_ID;
	wire [31:0] ALU_result_EX;
	wire [31:0] ALU_result_MEM;
	wire [31:0] Read_Data_2_MEM;
	wire Zero_EX;
	wire [4:0] Write_register_EX;
	wire BranchEQ_MEM;
	wire BranchNE_MEM;
	wire MemRead_MEM;
	wire MemToReg_MEM;
	wire MemWrite_MEM;
	wire RegWrite_MEM;
	wire Jump_MEM;
	wire [1:0] trunkMode_MEM;
	wire ShiftToTrunk_MEM;
	wire Zero_MEM;
	wire [4:0] Write_register_MEM;
	wire [31:0] Read_data_MEM;
	wire [31:0] Read_data_WB;
	wire [31:0] ALU_result_WB;
	wire MemToReg_WB;
	wire RegWrite_WB;
	wire [4:0] Write_register_WB;
	wire [1:0] forwardA;
	wire [1:0] forwardB;
	wire BranchTaken;
	wire Jump_ID;
	wire IF_Flush;
	wire JReg_ID;

	// Instantiate the Unit Under Test (UUT)
	Pipeline uut (
		.clk(clk), 
		.aluInstruction(aluInstruction), 
		.equalFlag(equalFlag), 
		.rtData(rtData), 
		.rsData(rsData), 
		.reg_array0(reg_array0), 
		.reg_array1(reg_array1), 
		.reg_array2(reg_array2), 
		.reg_array3(reg_array3), 
		.reg_array4(reg_array4), 
		.reg_array5(reg_array5), 
		.reg_array6(reg_array6), 
		.reg_array7(reg_array7), 
		.reg_array8(reg_array8), 
		.reg_array9(reg_array9), 
		.reg_array10(reg_array10), 
		.reg_array11(reg_array11), 
		.reg_array12(reg_array12), 
		.reg_array13(reg_array13), 
		.reg_array14(reg_array14), 
		.reg_array15(reg_array15), 
		.reg_array16(reg_array16), 
		.reg_array17(reg_array17), 
		.reg_array18(reg_array18), 
		.reg_array19(reg_array19), 
		.reg_array20(reg_array20), 
		.reg_array21(reg_array21), 
		.reg_array22(reg_array22), 
		.reg_array23(reg_array23), 
		.reg_array24(reg_array24), 
		.reg_array25(reg_array25), 
		.reg_array26(reg_array26), 
		.reg_array27(reg_array27), 
		.reg_array28(reg_array28), 
		.reg_array29(reg_array29), 
		.reg_array30(reg_array30), 
		.reg_array31(reg_array31), 
		.debugClk(debugClk), 
		.instruction_IF(instruction_IF), 
		.PC_sumado_IF(PC_sumado_IF), 
		.instruction_ID(instruction_ID), 
		.savePc_ID(savePc_ID), 
		.savePc_EX(savePc_EX), 
		.savePc_MEM(savePc_MEM), 
		.savePc_WB(savePc_WB), 
		.Read_Data_1_ID(Read_Data_1_ID), 
		.Read_Data_2_ID(Read_Data_2_ID), 
		.signExtended_ID(signExtended_ID), 
		.PC_sumado_ID(PC_sumado_ID), 
		.PC_sumado_EX(PC_sumado_EX), 
		.PC_sumado_MEM(PC_sumado_MEM), 
		.PC_sumado_WB(PC_sumado_WB), 
		.RegDest_ID(RegDest_ID), 
		.BranchEQ_ID(BranchEQ_ID), 
		.BranchNE_ID(BranchNE_ID), 
		.MemRead_ID(MemRead_ID), 
		.MemToReg_ID(MemToReg_ID), 
		.ALUOp1_ID(ALUOp1_ID), 
		.ALUOp2_ID(ALUOp2_ID), 
		.MemWrite_ID(MemWrite_ID), 
		.ALUSrc_ID(ALUSrc_ID), 
		.RegWrite_ID(RegWrite_ID), 
		.ShiftToTrunk_ID(ShiftToTrunk_ID), 
		.trunkMode_ID(trunkMode_ID), 
		.Read_Data_1_EX(Read_Data_1_EX), 
		.Read_Data_2_EX(Read_Data_2_EX), 
		.aluInput1(aluInput1), 
		.aluInput2(aluInput2), 
		.signExtended_EX(signExtended_EX), 
		.instruction_EX(instruction_EX), 
		.RegDest_EX(RegDest_EX), 
		.BranchEQ_EX(BranchEQ_EX), 
		.BranchNE_EX(BranchNE_EX), 
		.MemRead_EX(MemRead_EX), 
		.MemToReg_EX(MemToReg_EX), 
		.ALUOp1_EX(ALUOp1_EX), 
		.ALUOp2_EX(ALUOp2_EX), 
		.MemWrite_EX(MemWrite_EX), 
		.ALUSrc_EX(ALUSrc_EX), 
		.RegWrite_EX(RegWrite_EX), 
		.Jump_EX(Jump_EX), 
		.trunkMode_EX(trunkMode_EX), 
		.ShiftToTrunk_EX(ShiftToTrunk_EX), 
		.PC_next_ID(PC_next_ID), 
		.ALU_result_EX(ALU_result_EX), 
		.ALU_result_MEM(ALU_result_MEM), 
		.Read_Data_2_MEM(Read_Data_2_MEM), 
		.Zero_EX(Zero_EX), 
		.Write_register_EX(Write_register_EX), 
		.BranchEQ_MEM(BranchEQ_MEM), 
		.BranchNE_MEM(BranchNE_MEM), 
		.MemRead_MEM(MemRead_MEM), 
		.MemToReg_MEM(MemToReg_MEM), 
		.MemWrite_MEM(MemWrite_MEM), 
		.RegWrite_MEM(RegWrite_MEM), 
		.Jump_MEM(Jump_MEM), 
		.trunkMode_MEM(trunkMode_MEM), 
		.ShiftToTrunk_MEM(ShiftToTrunk_MEM), 
		.Zero_MEM(Zero_MEM), 
		.Write_register_MEM(Write_register_MEM), 
		.Read_data_MEM(Read_data_MEM), 
		.Read_data_WB(Read_data_WB), 
		.ALU_result_WB(ALU_result_WB), 
		.MemToReg_WB(MemToReg_WB), 
		.RegWrite_WB(RegWrite_WB), 
		.Write_register_WB(Write_register_WB), 
		.forwardA(forwardA), 
		.forwardB(forwardB), 
		.BranchTaken(BranchTaken), 
		.Jump_ID(Jump_ID), 
		.IF_Flush(IF_Flush), 
		.JReg_ID(JReg_ID), 
		.DebugAddress(DebugAddress), 
		.debugMode(debugMode)
	);

	always #20 clk=~clk;

	initial begin
		// Initialize Inputs
		clk = 0;
		debugClk = 0;
		DebugAddress = 0;
		debugMode = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
      
endmodule

