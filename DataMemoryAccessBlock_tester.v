`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   11:57:07 03/12/2014
// Design Name:   DataMemoryAccessBlock
// Module Name:   C:/Users/Marcelo/Documents/Xilinx/ArquitecturaPIPELINE/DataMemoryAccessBlock_tester.v
// Project Name:  ArquitecturaPIPELINE
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: DataMemoryAccessBlock
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module DataMemoryAccessBlock_tester;

	// Inputs
	reg clk;
	reg MemWrite;
	reg MemRead;
	reg [9:0] Address;
	reg [31:0] WriteData;

	// Outputs
	wire [31:0] ReadData;

	// Instantiate the Unit Under Test (UUT)
	DataMemoryAccessBlock uut (
		.clk(clk), 
		.MemWrite(MemWrite), 
		.MemRead(MemRead), 
		.Address(Address), 
		.WriteData(WriteData), 
		.ReadData(ReadData)
	);

	always #10 clk=~clk;

	initial begin
		// Initialize Inputs
		clk = 0;
		MemWrite = 0;
		MemRead = 0;
		Address = 0;
		WriteData = 0;

		// Wait 100 ns for global reset to finish
		#100;
      MemWrite = 1;
		WriteData = 15;	
		#20;
      MemWrite = 0;
		MemRead = 1;
		#20;
		Address = 1;
		// Add stimulus here
		

	end
      
endmodule

