`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   15:56:50 04/28/2014
// Design Name:   InstructionMemory
// Module Name:   C:/Users/Marcelo/Documents/XilinxProjects/Pipe/ROM_Test.v
// Project Name:  Pipe
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

module ROM_Test;

	// Inputs
	reg clka;
	reg ena;
	reg [9:0] addra;

	// Outputs
	wire [31:0] douta;

	// Instantiate the Unit Under Test (UUT)
	InstructionMemory uut (
		.clka(clka), 
		.ena(ena), 
		.addra(addra), 
		.douta(douta)
	);


	always #10 clka=~clka;
	
	//always #20 addra = addra +1;
	
	initial begin
		// Initialize Inputs
		clka = 0;
		ena = 1;
		addra = 0;
		#20 addra = addra +1;
		// Wait 100 ns for global reset to finish
		#100;
      addra = 25;  
		// Add stimulus here

	end
      
endmodule

