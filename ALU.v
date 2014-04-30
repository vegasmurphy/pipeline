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
			4'b0010: resultado = a_input + b_input;			//ADD	(Suma)
			4'b0011: resultado = a_input ^ b_input;			//XOR	(Custom Opcode)
			4'b0100: resultado = b_input << sa;					//SLL	(Custom Opcode)
			4'b0101: resultado = b_input >> sa;					//SRL	(Custom Opcode) 		[Tested OK]
			4'b0110: resultado = a_input - b_input;			//SUB	(Resta)
			4'b0111: resultado = (a_input < b_input)? 1:0;	//SLT (Set on Less Than) 	[Tested OK]
			4'b1000: resultado = b_input >>> sa;				//SRA	(Custom Opcode) 		[Tested OK]	
			4'b1001: resultado = b_input >> a_input;			//SRLV (Custom Opcode)
			4'b1010: resultado = b_input >>> a_input;			//SRAV (Custom Opcode)
			4'b1011: resultado = b_input << a_input;			//SLLV (Custom Opcode)			
			4'b1100: resultado = ~(a_input | b_input);		//NOR
			4'b1101: resultado = $unsigned(a_input) + $unsigned(b_input);			//ADDU (Suma sin signo)	[Tested OK]
			4'b1110: resultado = $unsigned(a_input) - $unsigned(b_input);			//SUBU (Resta sin signo)[Tested OK]
			4'b1111: resultado = ($unsigned(a_input) < $unsigned(b_input))? 1:0;	//SLTU (Unsigned Set on Less Than) [Tested OK]
			default: resultado=a_input;
		endcase
		if(resultado==0)
			zero=1;
		else
		zero=0;
	end

endmodule
