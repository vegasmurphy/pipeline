`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   09:24:37 03/07/2014
// Design Name:   ProgramCounter
// Module Name:   C:/Users/Marcelo/Documents/Xilinx/ArquitecturaPIPELINE/ProgramCounter_Tester.v
// Project Name:  ArquitecturaPIPELINE
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: ProgramCounter
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module ProgramCounter_Tester;

	// Inputs
	reg clk;
	reg [9:0] PC_in;

	// Outputs
	wire [9:0] PC_out;

	// Instantiate the Unit Under Test (UUT)
	ProgramCounter uut (
		.clk(clk), 
		.PC_in(PC_in), 
		.PC_out(PC_out)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		PC_in = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		PC_in = 10'b1000000001;
		clk=1;
		#10
		clk=0;
		PC_in = 10'b0111111110;
		#50
		clk=1;
		#10
		clk=0;

	end
      
endmodule

