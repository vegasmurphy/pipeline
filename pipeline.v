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
    
	 //Old Wires
	 output wire [31:0] resultadoALU,
	 output wire [31:0] Instruction,
	 output wire [31:0] writeData,
	 output wire [31:0] rsData,
	 output wire [31:0] rtData,
	 output wire carryALU,
	 output wire zeroALU,
	 output wire RegDest,
	 output wire Branch,
	 output wire MemRead,
	 output wire MemToReg,
	 output wire ALUOp1,
	 output wire ALUOp2,
	 output wire MemWrite,
	 output wire ALUSrc,
	 output wire RegWrite,
	 output wire [31:0] dataMemoryReadData,
	 output wire jumpFlag,							//Bandera de Salto
	 output wire PCSrc,				//Bandera de Branch
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
		output [31:0] PC_sumado_EX, 
		output [31:0] Read_Data_1_EX, 
		output [31:0] Read_Data_2_EX, 
		output [31:0] signExtended_EX,
		
		//EX_MEM WIRES
		output [31:0] PC_next_EX, 
		output zeroALU_EX, 
		output [31:0] resultadoALU_EX,  
		output [31:0] PC_next_MEM, 
		output zeroALU_MEM, 
		output [31:0] resultadoALU_MEM, 
		output [31:0] Read_Data_2_MEM,
		
		//MEM_WB WIRES
		output [31:0] Read_data_MEM, 
		output [31:0] ALU_result_MEM, 
		output [31:0] Read_data_WB, 
		output [31:0] ALU_result_WB
	 
	 );

	//Partes del fetch
	reg [31:0] PC_next=1;
		
		
	assign PCSrc = zeroALU_MEM & Branch_MEM;
	//***********************MUXes*****************************//
	//Mux del PC
	assign PC_next = PCSrc ? PC_next_MEM : PC_sumado_IF;
	
	//Mux de antes de los registros
	wire [4:0] Write_Addr;
	assign Write_register_EX = RegDest_EX ? Instruction_EX[15:11] : Instruction_EX[20:16];
	
	//Mux de antes de la ALU
	wire [31:0] Read_Data_2_EX;
	assign rtData = ALUSrc_EX ? signExtended_EX : Read_Data_2_EX;
	
	//Mux de WriteBack
	wire [31:0] Write_Data;
	assign Write_Data = MemToReg_WB ? dataMemoryReadData_WB : resultadoALU_WB;



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
		.Address(resultadoALU_MEM),
		.WriteData(Read_Data_2_MEM),
		.ReadData(dataMemoryReadData_MEM)
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
		.Jump(jumpFlag_ID)
	);
	
	ALUwithControl alu (
		.data1(rsData_EX),
		.data2(rtData_EX),
		.instruction(signExtended_EX[5:0]),
		.ALUOp1(ALUOp1_EX),
		.ALUOp2(ALUOp2_EX),
		.zero(zeroALU_EX),
		.result(resultadoALU_EX),
		.aluInstruction(aluInstruction_EX)
	);
	
	EX_MEM ex_mem (
		.clk(clk), 
		.PC_next_EX(PC_next_EX), 
		.zeroALU_EX(zeroALU_EX), 
		.resultadoALU_EX(resultadoALU_EX), 
		.Read_Data_2_EX(Read_Data_2_EX), 
		.PC_next_MEM(PC_next_MEM), 
		.zeroALU_MEM(zeroALU_MEM), 
		.resultadoALU_MEM(resultadoALU_MEM), 
		.Read_Data_2_MEM(Read_Data_2_MEM)
	);
	
	ID_EX id_ex(
		.clk(clk), 
		.Read_Data_1_ID(Read_Data_1_ID), 
		.Read_Data_2_ID(Read_Data_2_ID), 
		.signExtended_ID(signExtended_ID), 
		.PC_sumado_ID(PC_sumado_ID), 
		.PC_sumado_EX(PC_sumado_EX), 
		.Read_Data_1_EX(Read_Data_1_EX), 
		.Read_Data_2_EX(Read_Data_2_EX), 
		.signExtended_EX(signExtended_EX)
	);
	
	MEM_WB mem_wb (
		.clk(clk), 
		.Read_data_MEM(dataMemoryReadData_MEM), 
		.ALU_result_MEM(ALU_result_MEM), 
		.Read_data_WB(Read_data_WB), 
		.ALU_result_WB(ALU_result_WB)
	);
	
	IF_ID if_id (
		.clk(clk), 
		.instruction_IF(instruction_IF), 
		.PC_sumado_IF(PC_sumado_IF), 
		.instruction_ID(instruction_ID), 
		.PC_sumado_ID(PC_sumado_ID)
	);

endmodule
