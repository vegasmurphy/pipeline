`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:15:11 03/06/2014 
// Design Name: 
// Module Name:    Registers 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: Banco de registros terminado. Faltaria la parte de debugging (ver los 32 registros)
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module Registers#(
		parameter 	width_B	=	32,	//Numero de bits de los registros
						Addr_B	=	5		//Numero de bits de Direccion
	)
	(	input wire clk,						//clock
		input wire RegWrite,					//Para que sirve esto? (debe ser un Write Enable)
		input [Addr_B-1:0] Read_Addr_1,	//Se pueden leer dos registros
		input [Addr_B-1:0] Read_Addr_2,	//(-)
		input [Addr_B-1:0] Write_Addr,	//Direccion (numero de registro) a escribir
		input [width_B-1:0] Write_Data,	//Dato a escribir
		output [width_B-1:0] Read_Data_1,//Dato leido con la direccion Read_Addr_1
		output [width_B-1:0] Read_Data_2,	//Dato leido con la direccion Read_Addr_2
		output [31:0] reg_array0,
		output [31:0] reg_array1,
		output [31:0] reg_array2,
		output [31:0] reg_array3,
		output [31:0] reg_array4,
		output [31:0] reg_array5,
		output [31:0] reg_array6,
		output [31:0] reg_array7,
		output [31:0] reg_array8,
		output [31:0] reg_array9,
		output [31:0] reg_array10,
		output [31:0] reg_array11,
		output [31:0] reg_array12,
		output [31:0] reg_array13,
		output [31:0] reg_array14,
		output [31:0] reg_array15,
		output [31:0] reg_array16,
		output [31:0] reg_array17,
		output [31:0] reg_array18,
		output [31:0] reg_array19,
		output [31:0] reg_array20,
		output [31:0] reg_array21,
		output [31:0] reg_array22,
		output [31:0] reg_array23,
		output [31:0] reg_array24,
		output [31:0] reg_array25,
		output [31:0] reg_array26,
		output [31:0] reg_array27,
		output [31:0] reg_array28,
		output [31:0] reg_array29,
		output [31:0] reg_array30,
		output [31:0] reg_array31
		);
	
	
	//señales (Aca se define un arreglo para indexar, como si fuera lenguage C)
	// reg [tamaño en bits-1:0] <nombre> [cantidad de elementos - 1:0]
	reg [width_B-1:0] reg_array [2**Addr_B-1:0]; //arreglo de 2^Addr_B posiciones (32 registros)
	initial begin
	reg_array[0]=0;
	reg_array[1]=2;
	reg_array[2]=3;
	reg_array[3]=5;
	reg_array[4]=6;
	reg_array[5]=0;
	reg_array[6]=0;
	reg_array[7]=9;
	reg_array[8]=10;
	reg_array[9]=11;
	reg_array[10]=12;
	reg_array[11]=13;
	reg_array[12]=14;
	reg_array[13]=15;
	reg_array[14]=16;
	reg_array[15]=17;
	reg_array[16]=18;
	reg_array[17]=19;
	reg_array[18]=20;
	reg_array[19]=21;
	reg_array[20]=22;
	reg_array[21]=23;
	reg_array[22]=24;
	reg_array[23]=25;
	reg_array[24]=26;
	reg_array[25]=27;
	reg_array[26]=28;
	reg_array[27]=29;
	reg_array[28]=30;
	reg_array[29]=31;
	reg_array[30]=32;
	reg_array[31]=33;
	end
	
	assign reg_array0=reg_array[0];
	assign reg_array1=reg_array[1];
	assign reg_array2=reg_array[2];
	assign reg_array3=reg_array[3];
	assign reg_array4=reg_array[4];
	assign reg_array5=reg_array[5];
	assign reg_array6=reg_array[6];
	assign reg_array7=reg_array[7];
	assign reg_array8=reg_array[8];
	assign reg_array9=reg_array[9];
	assign reg_array10=reg_array[10];
	assign reg_array11=reg_array[11];
	assign reg_array12=reg_array[12];
	assign reg_array13=reg_array[13];
	assign reg_array14=reg_array[14];
	assign reg_array15=reg_array[15];
	assign reg_array16=reg_array[16];
	assign reg_array17=reg_array[17];
	assign reg_array18=reg_array[18];
	assign reg_array19=reg_array[19];
	assign reg_array20=reg_array[20];
	assign reg_array21=reg_array[21];
	assign reg_array22=reg_array[22];
	assign reg_array23=reg_array[23];
	assign reg_array24=reg_array[24];
	assign reg_array25=reg_array[25];
	assign reg_array26=reg_array[26];
	assign reg_array27=reg_array[27];
	assign reg_array28=reg_array[28];
	assign reg_array29=reg_array[29];
	assign reg_array30=reg_array[30];
	assign reg_array31=reg_array[31];
	//Operacion de Escritura
	always @(posedge clk)
		if(RegWrite)
			reg_array[Write_Addr]<=Write_Data;
	
	
	//Operacion de Lectura
	assign Read_Data_1 = reg_array[Read_Addr_1];
	assign Read_Data_2 = reg_array[Read_Addr_2];


endmodule
