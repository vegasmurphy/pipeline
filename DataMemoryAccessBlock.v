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
	(	input clk,
		input MemWrite,
		input MemRead,
		input [Addr_B-1:0]  BasePlusOffset,
		input [Width_B-1:0] WriteData,
		input [1:0] trunkMode,
		input	ShiftToTrunk,
		output [Width_B-1:0] TrunkedReadData
   );
	
	wire WriteEnable;
	wire [9:0] address;
	wire [31:0] TrunkedWriteData, ReadData;
	assign WriteEnable = MemWrite & (~MemRead);	 
	assign address = ShiftToTrunk? BasePlusOffset[11:2] : BasePlusOffset[9:0];
//Haciendo un shift en aluinput1 (shifteando la base) se podria obtener una direccion de 12 bits y tomar los 2LSB para elegir el byte, dado que estos van a ser solo del offset y los 10MSB ya seran la suma del registro base shifteado mas los 14 MSB del offset.	
	 
	//Modulos Instanciados
	//Memoria RAM
	DataMemory RAM (
	  .clka(clk), 			//Entrada de Clock
	  .wea(WriteEnable), //WriteEnable (1bit)
	  .addra(address), 	//Bus de Direccion (10 bits)
	  .dina(TrunkedWriteData),	//Bus de Datos (entrada) (32bits)
	  .douta(ReadData) 	//Bus de Datos (salida) (32bits)
	);

	//Trunk Unit para Almacenmiento
	TrunkUnit storage_trunk_unit (
		.opcode(trunkMode), 
		.entrada(WriteData), 
		.direccion(BasePlusOffset[1:0]), 
		.salida(TrunkedWriteData)
	);
	
	//Trunk Unit para Carga
	TrunkUnit load_trunk_unit (
		.opcode(trunkMode), 
		.entrada(ReadData), 
		.direccion(BasePlusOffset[1:0]), 
		.salida(TrunkedReadData)
	);
	


endmodule
