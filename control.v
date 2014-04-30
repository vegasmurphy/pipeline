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
	 output reg BranchEQ,
	 output reg BranchNE,
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
		case (opcode)	//Special
			6'b000000: 	//R-type (ALU)
				begin
					RegDest=1;
					BranchEQ=0;
					BranchNE=0;
					MemRead=0;
					MemToReg=0;
					ALUOp1=1;
					ALUOp2=0;
					MemWrite=0;
					ALUSrc=0;
					RegWrite=1;
					Jump=0;
				end
			6'b001000: 	//ADDI [OK]
				begin
					RegDest=0;	//ok
					BranchEQ=0;	//ok
					BranchNE=0;	//ok
					MemRead=0;	//ok
					MemToReg=0;	//ok
					ALUOp1=1;	//ok
					ALUOp2=0;	//ok
					MemWrite=0;	//ok
					ALUSrc=1;	//ok
					RegWrite=1;	//ok
					Jump=0;		//ok
				end
			6'b100011: //LW
				begin
					RegDest=0;
					BranchEQ=0;
					BranchNE=0;
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
					BranchEQ=0;
					BranchNE=0;
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
					BranchEQ=1;
					BranchNE=0;
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
			6'b000101: //BNE
				begin
					BranchEQ=0;
					BranchNE=1;
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
			6'b000010://J (Jump) 
				begin
					RegDest=0;
					BranchEQ=0;
					BranchNE=0;
					MemRead=0;
					MemToReg=0;
					ALUOp1=0;
					ALUOp2=0;
					MemWrite=0;
					ALUSrc=0;
					RegWrite=0;
					Jump=1;
				end
			default: //(NOP)
				begin
					RegDest=0;
					BranchEQ=0;
					BranchNE=0;
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
