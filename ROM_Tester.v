`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   15:58:00 03/07/2014
// Design Name:   InstructionMemory
// Module Name:   C:/Users/Marcelo/Documents/Xilinx/ArquitecturaPIPELINE/ROM_Tester.v
// Project Name:  ArquitecturaPIPELINE
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: InstructionMemory
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module ROM_Tester;

	// Inputs
	reg clka;
	reg [9:0] addra;

	// Outputs
	wire [31:0] douta;

	// Instantiate the Unit Under Test (UUT)
	InstructionMemory uut (
		.clka(clka), 
		.addra(addra), 
		.douta(douta)
	);
	
	
	always #10 clka=~clka;

	initial begin
		// Initialize Inputs
		clka = 0;
		addra = 0;

		// Wait 100 ns for global reset to finish
		#100;
		addra = 1;  
		#20;
		addra = 2;
		#20;
		addra = 3;
		#20;
		addra = 4;
		#20;
		addra = 5;
		#20;
		addra = 6;
		#20;
		addra = 7;
		#20;
		addra = 8;
		// Add stimulus here

	end
      
endmodule

