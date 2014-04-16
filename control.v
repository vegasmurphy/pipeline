`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:22:37 03/11/2014 
// Design Name: 
// Module Name:    control 
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
module Control(
    input [5:0] opcode,
    output reg RegDest,
	 output reg Branch,
	 output reg MemRead,
	 output reg MemToReg,
	 output reg ALUOp1,
	 output reg ALUOp2,
	 output reg MemWrite,
	 output reg ALUSrc,
	 output reg RegWrite,
	 output reg Jump
    );


always @(*)
	begin
		case (opcode)
			6'b000000: //R-format (ALU)
				begin
					RegDest=1;
					Branch=0;
					MemRead=0;
					MemToReg=0;
					ALUOp1=1;
					ALUOp2=0;
					MemWrite=0;
					ALUSrc=0;
					RegWrite=1;
					Jump=0;
				end
			6'b100011: //LW
				begin
					RegDest=0;
					Branch=0;
					MemRead=1;
					MemToReg=1;
					ALUOp1=0;
					ALUOp2=0;
					MemWrite=0;
					ALUSrc=1;
					RegWrite=1;
					Jump=0;
				end
			6'b101011://SW
				begin
					Branch=0;
					MemRead=0;
					ALUOp1=0;
					ALUOp2=0;
					MemWrite=1;
					ALUSrc=1;
					RegWrite=0;
					Jump=0;
					RegDest=0;
					MemToReg=0;
				end
			6'b000100: //BEQ
				begin
					Branch=1;
					MemRead=0;
					ALUOp1=0;
					ALUOp2=1;
					MemWrite=0;
					ALUSrc=0;
					RegWrite=0;
					Jump=0;
					RegDest=0;
					MemToReg=0;
				end
			6'b000010://Jump 
				begin
					RegDest=0;
					Branch=0;
					MemRead=0;
					MemToReg=0;
					ALUOp1=0;
					ALUOp2=0;
					MemWrite=0;
					ALUSrc=0;
					RegWrite=0;
					Jump=1;
				end
			default:
				begin
					RegDest=0;
					Branch=0;
					MemRead=0;
					MemToReg=0;
					ALUOp1=0;
					ALUOp2=0;
					MemWrite=0;
					ALUSrc=0;
					RegWrite=0;
					Jump=0;
				end
		endcase
		
	end

endmodule
