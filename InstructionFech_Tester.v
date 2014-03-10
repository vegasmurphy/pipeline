`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   15:36:33 03/07/2014
// Design Name:   IntructionFetchBlock
// Module Name:   C:/Users/Marcelo/Documents/Xilinx/ArquitecturaPIPELINE/InstructionFech_Tester.v
// Project Name:  ArquitecturaPIPELINE
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: IntructionFetchBlock
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module InstructionFech_Tester;

	// Inputs
	reg clk;

	// Outputs
	wire [31:0] Instruccion;

	// Instantiate the Unit Under Test (UUT)
	IntructionFetchBlock uut (
		.clk(clk), 
		.Instruccion(Instruccion)
	);

	always #10 clk=~clk;


	initial begin
		// Initialize Inputs
		clk = 0;

		// Wait 100 ns for global reset to finish
		//#100;
        
		// Add stimulus here

	end
      
endmodule

