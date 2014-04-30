`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   16:27:30 04/29/2014
// Design Name:   ALU
// Module Name:   C:/Users/Marcelo/Documents/XilinxProjects/Pipe/NumericTest.v
// Project Name:  Pipe
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: ALU
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module NumericTest;

	// Inputs
	reg [31:0] a_input;
	reg [31:0] b_input;
	reg [4:0] sa;
	reg [3:0] opcode;

	// Outputs
	wire zero;
	wire [31:0] resultado;

	// Instantiate the Unit Under Test (UUT)
	ALU uut (
		.a_input(a_input), 
		.b_input(b_input), 
		.sa(sa),
		.opcode(opcode), 
		.zero(zero), 
		.resultado(resultado)
	);

	initial begin
		// Initialize Inputs
		a_input = 0;
		b_input = -2;
		sa = 0;
		opcode = 4'b1111;

		// Wait 100 ns for global reset to finish
		#100;
      sa = 1;a_input = 1;
		#100;
		sa = 2;a_input = 2;
		#100;
		sa = 3;a_input = -1;
		
		// Add stimulus here

	end
      
endmodule

