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
    output wire [31:0] resultadoALU
	
	 
	 
	 );


	// Outputs
	wire [31:0] Instruction;
	wire [9:0] flags;
	wire [31:0] writeData;
	wire [31:0] rsData;
	wire [31:0] rtData;
	wire carryALU;
	wire zeroALU;
	wire RegDest;
	wire Branch;
	wire MemRead;
	wire MemToReg;
	wire ALUOp1;
	wire ALUOp2;
	wire MemWrite;
	wire ALUSrc;
	wire RegWrite;
	wire [31:0] dataMemoryReadData;
	wire Jump;
	wire branchAndZero_flag;
	
	
	
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
		.result(resultadoALU)
	);
	
	

endmodule
