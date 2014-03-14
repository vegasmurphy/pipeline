`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   21:06:19 03/12/2014
// Design Name:   SignExtender
// Module Name:   C:/Users/Marcelo/Documents/Xilinx/ArquitecturaPIPELINE/SignExtender_tester.v
// Project Name:  ArquitecturaPIPELINE
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: SignExtender
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module SignExtender_tester;

	// Inputs
	reg [15:0] unextended;

	// Outputs
	wire [31:0] extended;

	// Instantiate the Unit Under Test (UUT)
	SignExtender uut (
		.unextended(unextended), 
		.extended(extended)
	);

	initial begin
		// Initialize Inputs
		unextended = 0;

		// Wait 100 ns for global reset to finish
		#100;
      unextended = 15;  
		
		#100;
		unextended = 16'b1000000000000011;  
		// Add stimulus here

	end
      
endmodule