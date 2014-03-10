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
// Description: 
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

	wire [Addr_B-1:0] PC_in, PC_out;


	//Instancias de los modulos
	//Contador de programa
	ProgramCounter PC (
		.clk(clk), 
		.PC_in(PC_in), 
		.PC_out(PC_out)
	);

	//Memoria de Instrucciones (ROM)
	InstructionMemory ROM (
	  .clka(clk), 			//Entrada de clock
	  .addra(PC_out), 	//Direccion dada por el valor del PC
	  .douta(Instruccion)//Instruccion obtenida
	);


	//Sumador
	//assign PC_in = PC_out+1;

	reg [Addr_B-1:0] PC_in_reg;
	always@(posedge clk)
		PC_in_reg<=PC_out+1;
		
	assign PC_in = PC_in_reg;	
		
endmodule
