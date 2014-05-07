`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   16:42:38 05/06/2014
// Design Name:   TrunkUnit
// Module Name:   C:/Users/Marcelo/Documents/XilinxProjects/Pipeline/trunkTester.v
// Project Name:  Pipeline
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: TrunkUnit
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module trunkTester;

	// Inputs
	reg [2:0] opcode;
	reg [31:0] entrada;
	reg [11:0] direccion;

	// Outputs
	wire [31:0] salida;

	// Instantiate the Unit Under Test (UUT)
	TrunkUnit uut (
		.opcode(opcode), 
		.entrada(entrada), 
		.direccion(direccion), 
		.salida(salida)
	);

	initial begin
		// Initialize Inputs
		opcode = 0;
		entrada = 0;
		direccion = 0;

		// Wait 100 ns for global reset to finish
		#20;
      entrada = 32'b11111111111111111111111111111111;
		#20;
		opcode = 1;
		#20;
		opcode = 2;
		#20;
		opcode = 3;
		// Add stimulus here

	end
      
endmodule

