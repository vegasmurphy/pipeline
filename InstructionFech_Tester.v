`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   16:03:47 03/20/2014
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
	reg branchAndZero_flag;
	reg jumpFlag;

	// Outputs
	wire [31:0] signExtended;
	wire [31:0] PC_debug_value;
	wire [31:0] Instruccion;

	// Instantiate the Unit Under Test (UUT)
	IntructionFetchBlock uut (
		.clk(clk), 
		.branchAndZero_flag(branchAndZero_flag), 
		.jumpFlag(jumpFlag), 
		.signExtended(signExtended), 
		.PC_debug_value(PC_debug_value), 
		.Instruccion(Instruccion)
	);


	always #10 clk=~clk;

	initial begin
		// Initialize Inputs
		clk = 0;
		branchAndZero_flag = 0;
		jumpFlag = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
      
endmodule

