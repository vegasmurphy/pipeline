`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   11:58:07 03/12/2014
// Design Name:   DataMemory
// Module Name:   C:/Users/Marcelo/Documents/Xilinx/ArquitecturaPIPELINE/DataMemory_tester.v
// Project Name:  ArquitecturaPIPELINE
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: DataMemory
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module DataMemory_tester;

	// Inputs
	reg clk;
	reg [0:0] wea;
	reg [9:0] addra;
	reg [31:0] dina;

	// Outputs
	wire [31:0] douta;

	// Instantiate the Unit Under Test (UUT)
	DataMemory uut (
		.clka(clk), 
		.wea(wea), 
		.addra(addra), 
		.dina(dina), 
		.douta(douta)
	);

	always #10 clk=~clk;

	initial begin
		// Initialize Inputs
		clk = 0;
		wea = 0;
		addra = 0;
		dina = 0;

		// Wait 100 ns for global reset to finish
		#100;
		dina = 15;
		wea = 1;
		#20;
		wea = 0;
		dina = 0;
		
        
		// Add stimulus here

	end
      
endmodule

