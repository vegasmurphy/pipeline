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
//			-  Falta verificar si el branch esta funcionando correctamente
//			-	Falta ver si las banderas de los mux no estan alrevez
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
	(	input clk,										//clock
		input [width_B-1:0] PC_next,				//Creo que hay que inicializarlo en uno (1)		
		output [width_B-1:0] PC_debug_value,	//Salida del valor del PC (para debug)
		output [width_B-1:0] PC_sumado_value,	//Salida del PC sumado para el bloque IFID
		output [width_B-1:0] Instruccion			//Instruccion
   );
	
	assign PC_debug_value = PC_actual;	//Esto es para ver el valor del PC en el debugger
	assign PC_sumado_value = PC_sumado;
	
	//****************Modulos Instanciados*********************//
	//Contador de Programa (Ya no es un modulo, pero igual queda aca)
	reg [width_B-1:0] PC_actual=0;//Valor Actual del PC para las instrucciones (debe iniciarse en cero)
	reg [width_B-1:0] PC_sumado=0;//PC+1	
	
	//Memoria de Instrucciones (ROM)
	InstructionMemory ROM (
	  .clka(clk), 					//Entrada de clock
	  .addra(PC_actual[9:0]), 	//Direccion dada por el valor del PC
	  .douta(Instruccion)		//Instruccion obtenida
	);
	

	//************Logica de Asignacion del PC******************//
	//Logica secuencial
	always @(posedge clk)
		begin
			//Sumar 1 al PC_to_ROM para pasar a la siguiente direccion
			PC_sumado = PC_actual +1;
			PC_actual=PC_next;
		end
			
	
endmodule
