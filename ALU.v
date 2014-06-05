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
	input [4:0]	sa;
	input [4:0] opcode;
	output reg zero;
	output reg [WORD_WIDTH-1:0] resultado;
  
	always @*
	begin
		case (opcode)
			5'b00000: resultado = a_input & b_input;			//AND
			5'b00001: resultado = a_input | b_input;			//OR
			5'b00010: resultado = a_input + b_input;			//ADD	(Suma)
			5'b00011: resultado = a_input ^ b_input;			//XOR	(Custom Opcode)
			5'b00100: resultado = b_input << sa;				//SLL	(Custom Opcode)
			5'b00101: resultado = b_input >> sa;				//SRL	(Custom Opcode) 		[Tested OK]
			5'b00110: resultado = a_input - b_input;			//SUB	(Resta)
			5'b00111: resultado = (a_input < b_input)? 1:0;	//SLT (Set on Less Than) 	[Tested OK]
			5'b01000: resultado = b_input >>> sa;				//SRA	(Custom Opcode) 		[Tested OK]	
			5'b01001: resultado = b_input >> a_input;			//SRLV (Custom Opcode)
			5'b01010: resultado = b_input >>> a_input;		//SRAV (Custom Opcode)
			5'b01011: resultado = b_input << a_input;			//SLLV (Custom Opcode)			
			5'b01100: resultado = ~(a_input | b_input);		//NOR
			5'b01101: resultado = $unsigned(a_input) + $unsigned(b_input);			//ADDU (Suma sin signo)	[Tested OK]
			5'b01110: resultado = $unsigned(a_input) - $unsigned(b_input);			//SUBU (Resta sin signo)[Tested OK]
			5'b01111: resultado = ($unsigned(a_input) < $unsigned(b_input))? 1:0;//SLTU (Unsigned Set on Less Than) [Tested OK]
/*-*/		5'b10000: resultado = a_input + b_input;			//ADDI
/*-*/		5'b10001: resultado = $unsigned(a_input) + $unsigned(b_input);			//ADDIU
/*-*/		5'b10010: resultado = a_input & b_input;			//ANDI
/*-*/		5'b10011: resultado = a_input | b_input;			//ORI
/*-*/		5'b10100: resultado = a_input ^ b_input;			//XORI
/*-*/		5'b10101: resultado = (a_input < b_input)? 1:0;	//SLTI
/*-*/		5'b10110: resultado = ($unsigned(a_input) < $unsigned(b_input))? 1:0;//SLTIU
/*-*/		5'b10111: resultado = b_input << 16;				//LUI
			default: resultado=a_input;
		endcase
		if(resultado==0)
			zero=1;
		else
		zero=0;
	end

endmodule
