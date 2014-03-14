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
// Description: Modulo de contador de programa. 
//			-  Contiene el registro contador de programa, el sumador que incrementa 
//				el valor del PC con cada clock, y el mux que determina si el pc se 
//				incrementa o si toma una direccion de salto.
//			-  Falta verificar que la prte de saltos funcione correctamente
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module ProgramCounter #(
		parameter PC_width = 32					//Cantidad de bits del contador de programa
	)
	(	input clk,									//clock
		input [PC_width-1:0] PC_next,		//Direccion de salto
		output reg [PC_width-1:0] PC_reg = 0//Valor actual del contador de programa (tambien lo usa la unidad de debugging)
	 );


	//Registro contador de Programa
	//reg [Addr_B-1:0] PC_reg=0;

	//Modificacion del PC
	always @(posedge clk)
		PC_reg <= PC_next;


endmodule
