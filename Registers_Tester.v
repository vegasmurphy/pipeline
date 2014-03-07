`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   23:23:36 03/06/2014
// Design Name:   Registers
// Module Name:   C:/Users/Marcelo/Documents/Xilinx/ArquitecturaPIPELINE/Registers_Tester.v
// Project Name:  ArquitecturaPIPELINE
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Registers
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module Registers_Tester;

	// Inputs
	reg clk;
	reg RegWrite;
	reg [4:0] Read_Addr_1;
	reg [4:0] Read_Addr_2;
	reg [4:0] Write_Addr;
	reg [31:0] Write_Data;

	// Outputs
	wire [31:0] Read_Data_1;
	wire [31:0] Read_Data_2;

	// Instantiate the Unit Under Test (UUT)
	Registers uut (
		.clk(clk), 
		.RegWrite(RegWrite), 
		.Read_Addr_1(Read_Addr_1), 
		.Read_Addr_2(Read_Addr_2), 
		.Write_Addr(Write_Addr), 
		.Read_Data_1(Read_Data_1), 
		.Read_Data_2(Read_Data_2), 
		.Write_Data(Write_Data)
	);


	always #20 clk=~clk;
	

	initial begin
		// Initialize Inputs
		clk = 0;
		RegWrite = 0;
		Read_Addr_1 = 1;
		Read_Addr_2 = 2;
		Write_Addr = 0;

		// Wait 100 ns for global reset to finish
		#100;
      		
		// Add stimulus here
		Write_Addr = 1;
		Write_Data = 15;
		RegWrite=1;
		#20
		RegWrite=0;
		#20
		Write_Addr = 2;
		Write_Data = 14;
		RegWrite=1;
		#20
		RegWrite=0;
		//Read_Addr_1 = 1;
		//Read_Addr_2 = 2;
	end
      
endmodule

