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
	 output wire Jump,
	 output wire branchAndZero_flag,
	 output wire [3:0]aluInstruction
	 
	 
	 );

		//EX_MEM WIRES
		wire [31:0] PC_next_EX; 
		wire zeroALU_EX; 
		wire [31:0] resultadoALU_EX;  
		wire [31:0] PC_next_MEM; 
		wire zeroALU_MEM; 
		wire [31:0] resultadoALU_MEM; 
		wire [31:0] Read_Data_2_MEM;
		
		//ID_EX WIRES
		wire [31:0] Read_Data_1_ID; 
		wire [31:0] Read_Data_2_ID; 
		wire [31:0] signExtended_ID; 
		wire [31:0] PC_sumado_ID; 
		wire [31:0] PC_sumado_EX; 
		wire [31:0] Read_Data_1_EX; 
		wire [31:0] Read_Data_2_EX; 
		wire [31:0] signExtended_EX;
		
		//MEM_WB WIRES
		wire [31:0] Read_data_MEM; 
		wire [31:0] ALU_result_MEM; 
		wire [31:0] Read_data_WB; 
		wire [31:0] ALU_result_WB;
		
		//IF_ID 
		wire [31:0] instruction_IF; 
		wire [31:0] PC_sumado_IF; 
		wire [31:0] instruction_ID; 
		
	// Outputs
	
	
	
	
	assign branchAndZero_flag = zeroALU & Branch;
	//***********************MUXes*****************************//
	//Mux de antes de los registros
	wire [4:0] Write_Addr;
	assign Write_Addr = RegDest ? Instruction[15:11] : Instruction[20:16];
	
	//Mux de antes de la ALU
	wire [31:0] Read_Data_2,signExtended;
	assign rtData = ALUSrc ? signExtended : Read_Data_2;
	
	//Mux de WriteBack
	wire [31:0] Write_Data;
	assign Write_Data = MemToReg ? dataMemoryReadData : resultadoALU;


	//****************Modulos Instanciados*********************//
	
	IntructionFetchBlock fetchBlock (
		.clk(clk),
		.branchAndZero_flag(branchAndZero_flag),
		.jumpFlag(Jump),
		.signExtended(signExtended),
		.Instruccion(Instruction)
	);
	
	DataMemoryAccessBlock dataMemoryAccessBlock (
		.clk(clk),
		.MemWrite(MemWrite),
		.MemRead(MemRead),
		.Address(resultadoALU),
		.WriteData(Read_Data_2),
		.ReadData(dataMemoryReadData)
	);
	
	Registers registers (
		.clk(clk),								//clock
		.RegWrite(RegWrite),					// (debe ser un Write Enable)
		.Read_Addr_1(Instruction[25:21]),//Se pueden leer dos registros
		.Read_Addr_2(Instruction[20:16]),//(-)
		.Write_Addr(Write_Addr),	//Direccion (numero de registro) a escribir
		.Write_Data(Write_Data),				//Dato a escribir
		.Read_Data_1(rsData),				//Dato leido con la direccion Read_Addr_1
		.Read_Data_2(Read_Data_2)
	);
	
	Control control (
		.opcode(Instruction[31:26]),
		.RegDest(RegDest),
		.Branch(Branch),
		.MemRead(MemRead),
		.MemToReg(MemToReg),
		.ALUOp1(ALUOp1),
		.ALUOp2(ALUOp2),
		.MemWrite(MemWrite),
		.ALUSrc(ALUSrc),
		.RegWrite(RegWrite),
		.Jump(Jump)
	);
	
	ALUwithControl alu (
		.data1(rsData),
		.data2(rtData),
		.instruction(Instruction[5:0]),
		.ALUOp1(ALUOp1),
		.ALUOp2(ALUOp2),
		.zero(zeroALU),
		.result(resultadoALU),
		.aluInstruction(aluInstruction)
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
		.Read_data_MEM(Read_data_MEM), 
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
