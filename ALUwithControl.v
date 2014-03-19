`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:14:17 03/11/2014 
// Design Name: 
// Module Name:    ALUwithControl 
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
module ALUwithControl(
    input [5:0] instruction,
    input [31:0] data1,
    input [31:0] data2,
    input ALUOp1,
	 input ALUOp2,
    output zero,
    output [31:0] result
    );
	wire [3:0]aluInstruction;
	ALUcontrol control (
		.instruction(instruction),
		.ALUOp1(ALUOp1),
		.ALUOp2(ALUOp2),
		.operation(aluInstruction)
	);
	
	ALU alu (
		.a_input(data1),
		.b_input(data2),
		.opcode(aluInstruction),
		.zero(zero),
		.resultado(result));
		
	



endmodule
