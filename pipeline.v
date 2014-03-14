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
    input wire clk
    );


	// Outputs
	wire [31:0] Instruction;
	wire [9:0] flags;
	wire [31:0] writeData;
	wire [31:0] rsData;
	wire [31:0] rtData;
	wire [31:0] resultadoALU;
	wire carryALU;
	wire zeroALU;
	wire RegDest;
	wire Branch;
	wire MemRead;
	wire MemToReg;
	wire ALUOp1;
	wire ALUOp2;
	wire memWrite;
	wire ALUSrc;
	wire RegWrite;
	wire dataMemoryReadData;
	wire Jump;
	// Instantiate the Unit Under Test (UUT)
	
	IntructionFetchBlock fetchBlock (
		.clk(clk),
		.jumpFlag(),
		.jumpAddress(jumpAddress),
		.Instruccion(Instruccion)
	);
	
	DataMemoryAccessBlock dataMemoryAccessBlock (
		.clk(clk),
		.MemWrite(MemWrite),
		.MemRead(memRead),
		.Address(resultadoALU),
		.WriteData(rtData),
		.ReadData(dataMemoryReadData)
	);
	
	Registers registers (
		.clk(clk),						//clock
		.RegWrite(flags[0]),					// (debe ser un Write Enable)
		.Read_Addr_1(Instruction[25:21]),	//Se pueden leer dos registros
		.Read_Addr_2(Instruction[20:16]),	//(-)
		.Write_Addr(Instruction[15:11]),	//Direccion (numero de registro) a escribir
		.Write_Data(writeData),	//Dato a escribir
		.Read_Data_1(rsData),//Dato leido con la direccion Read_Addr_1
		.Read_Data_2(rtData)
	);
	
	Control control (
		.opcode(Instruction[31:26]),
		.RegDest(RegDest),
		.Branch(Branch),
		.MemRead(MemRead),
		.MemToReg(MemToReg),
		.ALUOp1(ALUOp1),
		.ALUOp2(ALUOp2),
		.memWrite(memWrite),
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
