`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:23:27 03/12/2014 
// Design Name: 
// Module Name:    SignExtender 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: No se si es lo ideal pero funciona
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module SignExtender #
	(	parameter 	inputBits = 16,
						outputBits = 32
	)
	(	input	 [inputBits-1:0]  unextended,
		output reg [outputBits-1:0] extended
	);

	reg signed [outputBits-1:0] aux = 0;

	//Hacer un Shift Logico para completar los espacios que faltan
	always@*
		begin
			aux[outputBits:outputBits-inputBits] = unextended;
			extended = aux>>>(outputBits-inputBits);
		end 

endmodule
