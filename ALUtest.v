`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   13:14:06 03/12/2014
// Design Name:   ALUwithControl
// Module Name:   C:/Users/Marcelo/Documents/Xilinx/ArquitecturaPIPELINE/ALUtest.v
// Project Name:  ArquitecturaPIPELINE
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: ALUwithControl
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module ALUtest;

	
	// Inputs
	reg [5:0] instruction;
	reg [31:0] data1;
	reg [31:0] data2;
	reg ALUOp1;
	reg ALUOp2;

	// Outputs
	wire zero;
	wire [31:0] result;
	wire [3:0]aluInstruction;
	// Instantiate the Unit Under Test (UUT)
	ALUwithControl uut (
		.instruction(instruction), 
		.data1(data1), 
		.data2(data2), 
		.ALUOp1(ALUOp1),
		.ALUOp2(ALUOp2),
		.zero(zero), 
		.result(result),
		.aluInstruction(aluInstruction)
	);

	initial begin
		// Initialize Inputs
		instruction = 0;
		data1 = 2;
		data2 = 2;
		ALUOp1 = 0;
		ALUOp2 = 0;

		// Wait 100 ns for global reset to finish
		#100;
		instruction = 0;
		data1 = 2;
		data2 = 2;
		ALUOp1 = 1;
      
		#100;
		instruction = 4'b0000;
		data1 = 2;
		data2 = 2;
		ALUOp1 = 1;

		#100;
		instruction = 4'b0010;
		data1 = 2;
		data2 = 2;
		// Add stimulus here

	end
      
endmodule

