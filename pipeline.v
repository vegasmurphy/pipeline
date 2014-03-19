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
		.instruction(Instruction[31:26]),
		.ALUOp1(ALUOp1),
		.ALUOp2(ALUOp2),
		.zero(zeroALU),
		.result(resultadoALU),
		.aluInstruction(aluInstruction)
	);
	
	

endmodule
