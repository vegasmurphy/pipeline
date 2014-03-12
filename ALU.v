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
module ALU #(parameter WORD_WIDTH = 32)(a_input,b_input,opcode,carry_out,zero,resultado
    );
	//Inputs y outputs son wire por defecto
   input signed [WORD_WIDTH-1:0] a_input;
   input signed [WORD_WIDTH-1:0] b_input;
	input [5:0] opcode;
   output reg carry_out;
	output reg zero;
	output reg [WORD_WIDTH-1:0] resultado;
  
	always @(opcode)
	begin
		case (opcode)
			6'b100000: {carry_out, resultado} = a_input + b_input; //SUMA
			6'b100010: resultado = a_input - b_input; //RESTA	
			6'b100100: resultado = a_input & b_input;//AND
			6'b100101: resultado = a_input | b_input;//OR
			6'b100110: resultado = a_input ^ b_input;//XOR
			6'b000011: resultado = a_input >>> b_input;//SRA
			6'b000010: resultado = a_input >> b_input;//SRL
			6'b100111: resultado = ~(a_input | b_input);//NOR
		endcase
	if(resultado==0)
		zero=1;
	else
	zero=0;
end

endmodule
