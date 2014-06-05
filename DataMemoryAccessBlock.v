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
		input debugClk,
		input MemWrite,
		input MemRead,
		input [Addr_B-1:0]  BasePlusOffset,
		input [Width_B-1:0] WriteData,
		input [1:0] trunkModeAux,
		input	ShiftToTrunk,
		input [Addr_B-1:0]  DebugAddress,
		input debugMode,
		output [Width_B-1:0] TrunkedReadData
   );
	
	wire WriteEnable;
	wire [9:0] address,addressAux;
	wire [31:0] TrunkedWriteData, ReadData;
	wire [1:0] trunkMode;
	assign WriteEnableAux = MemWrite & (~MemRead);	 
	assign addressAux = ShiftToTrunk? BasePlusOffset[11:2] : BasePlusOffset[9:0];
	assign WriteEnable = debugMode?1'b0 : WriteEnableAux;
	assign address = debugMode?DebugAddress[9:0] : addressAux[9:0];
	assign trunkMode = debugMode?2'b00 : trunkModeAux;
	assign clkAux = debugMode?debugClk:clk;
//Haciendo un shift en aluinput1 (shifteando la base) se podria obtener una direccion de 12 bits y tomar los 2LSB para elegir el byte, dado que estos van a ser solo del offset y los 10MSB ya seran la suma del registro base shifteado mas los 14 MSB del offset.	
	 
	//Modulos Instanciados
	//Memoria RAM
	DataMemory RAM (
	  .clka(clkAux), 			//Entrada de Clock
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
