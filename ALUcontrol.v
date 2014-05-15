`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:34:27 03/11/2014 
// Design Name: 
// Module Name:    ALUcontrol 
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
module ALUcontrol(
    input [5:0] instruction,
    input ALUOp1,
	 input ALUOp2,
	 output reg[4:0] operation
    );


always @* 
begin
	if((~ALUOp1)&&(~ALUOp2))begin
	operation=5'b00010;	//Vegas: "Creo que es un Load"
	end
	else
		if(ALUOp2)begin
			operation=5'b00110;	//BEQ (Idem Resta)
		end
		else 
		case (instruction[5:0])
			6'b100100:
				operation=5'b00000;	//AND
			6'b100101:
				operation=5'b00001;	//OR
			6'b100000:
				operation=5'b00010;	//Suma
			6'b100110:
				operation=5'b00011;	//XOR (Custom Opcode)
			6'b000000:
				operation=5'b00100;	//SLL (Custom Opcode)
			6'b000010:
				operation=5'b00101;	//SRL (Custom Opcode)	
			6'b100010: 
				operation=5'b00110;	//Resta
			6'b101010: 
				operation=5'b00111;	//SLT (Set on less than)
			6'b000011:
				operation=5'b01000;	//SRA (Custom Opcode)
			6'b000110:
				operation=5'b01001;	//SRLV (Custom Opcode)
			6'b000111:
				operation=5'b01010;	//SRAV (Custom Opcode)
			6'b000100:
				operation=5'b01011;	//SLLV (Custom Opcode)
			6'b100111:
				operation=5'b01100;	//NOR
			6'b100001:
				operation=5'b01101;	//ADDU (Custom Opcode)
			6'b100011:
				operation=5'b01110;	//SUBU (Custom Opcode)
			6'b101011:
				operation=5'b01111;	//SLTU (Custom Opcode)
			6'b001000:
				operation=5'b10000;	//ADDI (Custom Opcode)
			6'b001001:
				operation=5'b10001;	//ADDIU (Custom Opcode)
			6'b001100:
				operation=5'b10010;	//ANDI (Custom Opcode)
			6'b001101:
				operation=5'b10011;	//ORI (Custom Opcode)
			6'b001110:
				operation=5'b10100;	//XORI (Custom Opcode)
			6'b001010:
				operation=5'b10101;	//SLTI (Custom Opcode)
			6'b001011:
				operation=5'b10110;	//SLTIU (Custom Opcode)
			6'b001111:
				operation=5'b10111;	//LUI	(Custom Opcode)
			default:
				operation=5'b00000;
		endcase
	end

			



	

endmodule
