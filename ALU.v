`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:18:15 08/24/2013 
// Design Name: 
// Module Name:    ALU 
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
module ALU #(parameter WORD_WIDTH = 32)(a_input,b_input,sa,opcode,zero,resultado
    );
	//Inputs y outputs son wire por defecto
   input signed [WORD_WIDTH-1:0] a_input;
   input signed [WORD_WIDTH-1:0] b_input;
	input unsigned [4:0]	sa;
	input [3:0] opcode;
	output reg zero;
	output reg [WORD_WIDTH-1:0] resultado;
  
	always @*
	begin
		case (opcode)
			4'b0000: resultado = a_input & b_input;			//AND
			4'b0001: resultado = a_input | b_input;			//OR
			4'b0010: resultado = a_input + b_input;			//SUMA
			4'b0011: resultado = a_input ^ b_input;			//XOR	(Custom Opcode)
			4'b0100: resultado = b_input << sa;					//SLL	(Custom Opcode)
			4'b0110: resultado = a_input - b_input;			//RESTA
			4'b0111: resultado = (a_input < b_input)? 1:0;	//SLT (Set on Less Than)		
			4'b1100: resultado = ~(a_input | b_input);		//NOR
			default: resultado=a_input;
		endcase
		if(resultado==0)
			zero=1;
		else
		zero=0;
	end

endmodule
