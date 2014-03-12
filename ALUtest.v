`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   23:21:56 03/11/2014
// Design Name:   ALUwithControl
// Module Name:   C:/Users/vegas/Desktop/Arquitectura/pipeline/ALUtest.v
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
	reg [1:0] ALUop;

	// Outputs
	wire zero;
	wire [31:0] result;

	// Instantiate the Unit Under Test (UUT)
	ALUwithControl uut (
		.instruction(instruction), 
		.data1(data1), 
		.data2(data2), 
		.ALUop(ALUop), 
		.zero(zero), 
		.result(result)
	);

	initial begin
		// Initialize Inputs
		instruction = 0;
		data1 = 2;
		data2 = 2;
		ALUop = 2'b00;

		// Wait 100 ns for global reset to finish
		#100;
		instruction = 0;
		data1 = 2;
		data2 = 2;
		ALUop = 2'b01;
      
		#100;
		instruction = 4'b0000;
		data1 = 2;
		data2 = 2;
		ALUop = 2'b10;

		#100;
		instruction = 4'b0010;
		data1 = 2;
		data2 = 2;
		ALUop = 2'b10;
		// Add stimulus here

	end
      
endmodule

