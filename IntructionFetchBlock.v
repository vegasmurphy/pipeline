`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:08:02 03/07/2014 
// Design Name: 
// Module Name:    IntructionFetchBlock 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: Bloque de Instruction Fetch.
//			-  Faltaria ponerle entradas para la direccion de salto del PC
//				y el flag del MUX que determina si el PC cuenta o salta.
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module IntructionFetchBlock #
	(	parameter 	width_B = 32,
						Addr_B = 10
	)	
	(	input clk,
		output [width_B-1:0] Instruccion
   );
	
	//Registros provisorios (hasta que se implementen los saltos)
	reg zero = 0;
	reg [Addr_B-1:0] zero_addr = 0;


	//****************Modulos Instanciados*********************//
	//Contador de Programa
	wire [Addr_B-1:0] PC_to_ROM;
	ProgramCounter PC (
		.clk(clk),					//clock
		.jump_flag(zero),			//Flag que indica si se tiene un salto o no
		.jump_addr(zero_addr),	//Direccion de salto
		.PC_reg(PC_to_ROM)		//Valor actual del contador de programa (tambien lo usa la unidad de debugging)
	 );
	
	
	//Memoria de Instrucciones (ROM)
	InstructionMemory ROM (
	  .clka(clk), 			//Entrada de clock
	  .addra(PC_to_ROM), //Direccion dada por el valor del PC
	  .douta(Instruccion)//Instruccion obtenida
	);
	
endmodule
