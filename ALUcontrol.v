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
	 output reg[3:0] operation
    );


always @* 
begin
	if((~ALUOp1)&&(~ALUOp2))begin
	operation=4'b0010;
	end
	else
		if(ALUOp2)begin
			operation=4'b0110;
		end
		else 
		case (instruction[5:0])
			6'b100000: 
				operation=4'b0010;
			6'b100010: 
				operation=4'b0110;
			6'b100100: 
				operation=4'b0000;
			6'b100101: 
				operation=4'b0001;
			6'b101010: 
				operation=4'b0111;
			default:
				operation=4'b0000;
		endcase
	end

			



	

endmodule
