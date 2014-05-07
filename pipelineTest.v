`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   17:04:56 05/05/2014
// Design Name:   UART_writer
// Module Name:   C:/Users/vegas/Desktop/New folder/Arquitectura/PipelineTest.v
// Project Name:  Arquitectura
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: UART_writer
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module PipelineTest;

	// Inputs
	reg clk;
	reg rx;
	reg clkPipeline1;

	// Outputs
	wire tx_out;
	wire [31:0] PC_sumado_IF;

	// Instantiate the Unit Under Test (UUT)
	UART_writer uut (
		.fastClk(clk), 
		.rx(rx), 
		.clkPipeline1(clkPipeline1), 
		.tx_out(tx_out), 
		.PC_sumado_IF(PC_sumado_IF)
	);
always #10 clkPipeline1=~clkPipeline1;
	initial begin
		// Initialize Inputs
		clk = 0;
		rx = 0;
		clkPipeline1 = 0;
	
		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
      
endmodule

