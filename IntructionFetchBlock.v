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
		input branchAndZero_flag,					//Bandera de Branch
		input jumpFlag,								//Bandera de Salto
		output [width_B-1:0] signExtended,
		output [width_B-1:0] PC_debug_value,	//Salida del valor del PC (para debug)
		output [width_B-1:0] Instruccion			//Instruccion
   );

	assign PC_value = PC_actual;	//Esto es para ver el valor del PC en el debugger

	//****************Modulos Instanciados*********************//
	//Contador de Programa (Ya no es un modulo, pero igual queda aca)
	reg [width_B-1:0] PC_actual=0;//Valor Actual del PC para las instrucciones (debe iniciarse en cero)
	reg [width_B-1:0] PC_sumado;	//PC+1
	reg [width_B-1:0] PC_next=1;	//Valor que tomara el PC actual en el proximo clock
	
	
	//Memoria de Instrucciones (ROM)
	InstructionMemory ROM (
	  .clka(clk), 					//Entrada de clock
	  .addra(PC_actual[9:0]), 	//Direccion dada por el valor del PC
	  .douta(Instruccion)		//Instruccion obtenida
	);
	
	
	wire [31:0] signExtended;
	//SignExtender
	SignExtender SignEx (
		.unextended(Instruccion[15:0]),	//Salto de 16bits
		.extended(signExtended)				//Extension
	);
	

	//************Logica de Asignacion del PC******************//
	always @(posedge clk)
		begin
			//Sumar 1 al PC_to_ROM para pasar a la siguiente direccion
			PC_sumado = PC_actual +1;
			if(branchAndZero_flag)
				begin
					PC_next[31:26] = PC_sumado[31:26];	//No se hace el shift porque el pc avanza de a uno
					PC_next[25:0] = Instruccion[25:0]; 	//en lugar de avanzar de a cuatro posiciones.
				end
			else
				begin
					if(jumpFlag)
						PC_next = signExtended + PC_sumado;
					else
						PC_next =  PC_sumado;
				end	

			PC_actual=PC_next;
		//Fin del Always		
		end
	
endmodule
