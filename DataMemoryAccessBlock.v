`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:38:36 03/12/2014 
// Design Name: 
// Module Name:    DataMemoryAccessBlock 
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
module DataMemoryAccessBlock #
	(	parameter 	Width_B = 32,
						Addr_B = 32
	)
	(	input  clk,
		input  MemWrite,
		input  MemRead,
		input  [Addr_B-1:0]  Address,
		input  [Width_B-1:0] WriteData,
		output [Width_B-1:0] ReadData
   );
	
	wire WriteEnable;
	assign WriteEnable = MemWrite & (~MemRead);	 
	 
	//Modulos Instanciados
	//Memoria RAM
	DataMemory RAM (
	  .clka(clk), 			//Entrada de Clock
	  .wea(WriteEnable), //WriteEnable (1bit)
	  .addra(Address[9:0]), 	//Bus de Direccion (10 bits)
	  .dina(WriteData),	//Bus de Datos (entrada) (32bits)
	  .douta(ReadData) 	//Bus de Datos (salida) (32bits)
	);

endmodule
