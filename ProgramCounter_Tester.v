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
	reg jump_flag;
	reg [9:0] jump_addr;
	
	// Outputs
	wire [9:0] PC_to_ROM;

	// Instantiate the Unit Under Test (UUT)
	ProgramCounter PC (
		.clk(clk),			//clock
		.jump_flag(jump_flag),		//Flag que indica si se tiene un salto o no
		.jump_addr(jump_addr),		//Direccion de salto
		.PC_reg(PC_to_ROM)//Valor actual del contador de programa (tambien lo usa la unidad de debugging)
	 );



	always #10 clk=~clk;
	
	
	initial begin
		// Initialize Inputs
		clk = 0;
		jump_flag = 0;
		jump_addr = 0;
		
		// Wait 100 ns for global reset to finish
		#100;
      jump_flag = 1;
		jump_addr = 3;
		#20;
		jump_flag = 0;

	end
      
endmodule

