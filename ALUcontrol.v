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

always @(*) begin
	if((ALUOp1==0)&&(ALUOp2==0))begin
	operation=4'b0010;
	end
	else
		if(ALUOp2==1'b1)begin
			operation=4'b0110;
		end
		else 
		case (instruction[3:0])
			4'b0000: 
				operation=4'b0010;
			4'b0010: 
				operation=4'b0110;
			4'b0100: 
				operation=4'b0000;
			4'b0101: 
				operation=4'b0001;
			4'b1010: 
				operation=4'b0111;
			default:
				operation=4'b0010;
		endcase
	end

			



	

endmodule
