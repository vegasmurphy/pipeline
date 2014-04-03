`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:24:22 03/11/2014 
// Design Name: 
// Module Name:    pipeline 
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
module Pipeline(
    input wire clk,
    
	//Debugging outputs
	output wire [3:0]aluInstruction,
	 
	 
	//IF_ID  WIRES
	output [31:0] instruction_IF, 
	output [31:0] PC_sumado_IF, 
	output [31:0] instruction_ID,

	//ID_EX WIRES
	output [31:0] Read_Data_1_ID,
	output [31:0] Read_Data_2_ID,
	output [31:0] signExtended_ID,
	output [31:0] PC_sumado_ID,
	output RegDest_ID,
	output Branch_ID,
	output MemRead_ID,
	output MemToReg_ID,
	output ALUOp1_ID,
	output ALUOp2_ID,
	output MemWrite_ID,
	output ALUSrc_ID,
	output RegWrite_ID,
	output Jump_ID,
	output [31:0] PC_sumado_EX,
	output [31:0] Read_Data_1_EX,
	output [31:0] Read_Data_2_EX,
	output [31:0] signExtended_EX,
	output [31:0] instruction_EX,
	output RegDest_EX,
	output Branch_EX,
	output MemRead_EX,
	output MemToReg_EX,
	output ALUOp1_EX,
	output ALUOp2_EX,
	output MemWrite_EX,
	output ALUSrc_EX,
	output RegWrite_EX,
	output Jump_EX,
	
	
	//EX_MEM WIRES
	output [31:0] PC_next_EX,
	output [31:0] ALU_result_EX,
	output [31:0] PC_next_MEM,
	output [31:0] ALU_result_MEM,
	output [31:0] Read_Data_2_MEM,
	output Zero_EX,
	output [4:0] Write_register_EX,
	output Branch_MEM,
	output MemRead_MEM,
	output MemToReg_MEM,
	output MemWrite_MEM,
	output RegWrite_MEM,
	output Jump_MEM,
	output Zero_MEM,
	output [4:0] Write_register_MEM,
	
	//MEM_WB WIRES
	output [31:0] Read_data_MEM,
	output [31:0] Read_data_WB,
	output [31:0] ALU_result_WB,
	output MemToReg_WB,
	output RegWrite_WB,
	output [4:0] Write_register_WB
 
	 );

	//Internal Wires
	wire [31:0] PC_next, rtData;
	wire PCSrc;
		
		
	assign PCSrc = Zero_MEM & Branch_MEM;
	assign PC_next_EX = signExtended_EX + PC_sumado_EX;
	//***********************MUXes*****************************//
	//Mux del PC
	assign PC_next = PCSrc ? PC_next_MEM : PC_sumado_IF;
	
	//Mux de antes de los registros
	wire [4:0] Write_Addr;
	assign Write_register_EX = RegDest_EX ? instruction_EX[15:11] : instruction_EX[20:16];
	
	//Mux de antes de la ALU
	assign rtData = ALUSrc_EX ? signExtended_EX : Read_Data_2_EX;
	
	//Mux de WriteBack
	wire [31:0] Write_Data;
	assign Write_Data = MemToReg_WB ? Read_data_WB : ALU_result_WB;



	//****************Modulos Instanciados*********************//
	
	IntructionFetchBlock fetchBlock (
		.clk(clk),
		.PC_next(PC_next),
		.PC_sumado_value(PC_sumado_IF),
		.Instruction(instruction_IF)
	);
	
	SignExtender SignEx (
		.unextended(instruction_ID[15:0]),	//Salto de 16bits
		.extended(signExtended_ID)				//Extension
	);		
	
	DataMemoryAccessBlock dataMemoryAccessBlock (
		.clk(clk),
		.MemWrite(MemWrite_MEM),
		.MemRead(MemRead_MEM),
		.Address(ALU_result_MEM),
		.WriteData(Read_Data_2_MEM),
		.ReadData(Read_data_MEM)
	);
	
	Registers registers (
		.clk(clk),									//clock
		.RegWrite(RegWrite_WB),					// (debe ser un Write Enable)
		.Read_Addr_1(instruction_ID[25:21]),//Se pueden leer dos registros
		.Read_Addr_2(instruction_ID[20:16]),//(-)
		.Write_Addr(Write_register_WB),		//Direccion (numero de registro) a escribir
		.Write_Data(Write_Data),				//Dato a escribir (Viene del Mux)
		.Read_Data_1(Read_Data_1_ID),			//Dato leido con la direccion Read_Addr_1
		.Read_Data_2(Read_Data_2_ID)
	);
	
	Control control (
		.opcode(instruction_ID[31:26]),
		.RegDest(RegDest_ID),
		.Branch(Branch_ID),
		.MemRead(MemRead_ID),
		.MemToReg(MemToReg_ID),
		.ALUOp1(ALUOp1_ID),
		.ALUOp2(ALUOp2_ID),
		.MemWrite(MemWrite_ID),
		.ALUSrc(ALUSrc_ID),
		.RegWrite(RegWrite_ID),
		.Jump(Jump_ID)
	);
	
	ALUwithControl alu (
		.data1(Read_Data_1_EX),
		.data2(rtData),
		.instruction(signExtended_EX[5:0]),
		.ALUOp1(ALUOp1_EX),
		.ALUOp2(ALUOp2_EX),
		.zero(Zero_EX),
		.result(ALU_result_EX),
		.aluInstruction(aluInstruction)//output para debug nomas
	);
	
	
	
	ID_EX id_ex(
		.clk(clk), 
		.Read_Data_1_ID(Read_Data_1_ID), 
		.Read_Data_2_ID(Read_Data_2_ID), 
		.signExtended_ID(signExtended_ID), 
		.PC_sumado_ID(PC_sumado_ID), 
		.PC_sumado_EX(PC_sumado_EX),
		.instruction_ID(instruction_ID),
		.Read_Data_1_EX(Read_Data_1_EX), 
		.Read_Data_2_EX(Read_Data_2_EX), 
		.signExtended_EX(signExtended_EX),
		.instruction_EX(instruction_EX),
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
		.RegDest_EX(RegDest_EX),
		.Branch_EX(Branch_EX),
		.MemRead_EX(MemRead_EX),
		.MemToReg_EX(MemToReg_EX),
		.ALUOp1_EX(ALUOp1_EX),
		.ALUOp2_EX(ALUOp2_EX),
		.MemWrite_EX(MemWrite_EX),
		.ALUSrc_EX(ALUSrc_EX),
		.RegWrite_EX(RegWrite_EX),
		.Jump_EX(Jump_EX)
	);
	
	EX_MEM ex_mem (
		.clk(clk), 
		.PC_next_EX(PC_next_EX), 
		.ALU_result_EX(ALU_result_EX), 
		.Read_Data_2_EX(Read_Data_2_EX), 
		.PC_next_MEM(PC_next_MEM), 
		.ALU_result_MEM(ALU_result_MEM), 
		.Read_Data_2_MEM(Read_Data_2_MEM),
		.Branch_EX(Branch_EX),
		.MemRead_EX(MemRead_EX),
		.MemToReg_EX(MemToReg_EX),
		.MemWrite_EX(MemWrite_EX),
		.RegWrite_EX(RegWrite_EX),
		.Jump_EX(Jump_EX),
		.Zero_EX(Zero_EX),
		.Write_register_EX(Write_register_EX),
		.Branch_MEM(Branch_MEM),
		.MemRead_MEM(MemRead_MEM),
		.MemToReg_MEM(MemToReg_MEM),
		.MemWrite_MEM(MemWrite_MEM),
		.RegWrite_MEM(RegWrite_MEM),
		.Jump_MEM(Jump_MEM),
		.Zero_MEM(Zero_MEM),
		.Write_register_MEM(Write_register_MEM)
	);
	
	
	MEM_WB mem_wb (
		.clk(clk), 
		.Read_data_MEM(Read_data_MEM), 
		.ALU_result_MEM(ALU_result_MEM),
		.RegWrite_MEM(RegWrite_MEM),
		.MemToReg_MEM(MemToReg_MEM),
		.Write_register_MEM(Write_register_MEM),
		.Read_data_WB(Read_data_WB),
		.ALU_result_WB(ALU_result_WB),
		.MemToReg_WB(MemToReg_WB),
		.RegWrite_WB(RegWrite_WB),
		.Write_register_WB(Write_register_WB)
	);
	
	IF_ID if_id (
		.clk(clk), 
		.instruction_IF(instruction_IF), 
		.PC_sumado_IF(PC_sumado_IF), 
		.instruction_ID(instruction_ID), 
		.PC_sumado_ID(PC_sumado_ID)
	);

endmodule
