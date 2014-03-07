`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:14:28 03/07/2014 
// Design Name: 
// Module Name:    ProgramCounter 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: Modulo de contador de programa. Ya esta listo
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module ProgramCounter #(
		parameter PC_width = 10			//Cantidad de bits del contador de programa
	)
	(	input clk,							//clock
		input [PC_width-1:0] PC_in,	//Nuevo valor de entrada
		output [PC_width-1:0] PC_out	//Valor actual del contador de programa (tambien lo usa la unidad de debugging)
	 );

	//señales
	reg [PC_width-1:0] PC_reg;

	//Modificacion del PC
	always @(posedge clk)
		PC_reg <= PC_in;
		
	//salida
	assign PC_out = PC_reg;

endmodule
