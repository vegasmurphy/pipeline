`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   19:46:47 04/14/2014
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
	reg [31:0] PC_next;
	reg PC_write;

	// Outputs
	wire [31:0] PC_debug_value;
	wire [31:0] PC_sumado_value;
	wire [31:0] Instruction;

	// Instantiate the Unit Under Test (UUT)
	IntructionFetchBlock uut (
		.clk(clk), 
		.PC_next(PC_next), 
		.PC_write(PC_write), 
		.PC_debug_value(PC_debug_value), 
		.PC_sumado_value(PC_sumado_value), 
		.Instruction(Instruction)
	);

	always #10 clk=~clk;
	
	initial begin
		// Initialize Inputs
		clk = 0;
		PC_next = 1;
		PC_write = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
      
endmodule

