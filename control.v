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
	 output reg BranchEQ,	//Indica la presencia de un Branch Equal
	 output reg BranchNE,	//Indica la presencia de un Branch NOT Equal
	 output reg MemRead,		//
	 output reg MemToReg,	//
	 output reg ALUOp1,		//
	 output reg ALUOp2,		//
	 output reg MemWrite,	//
	 output reg ALUSrc,		//
	 output reg RegWrite,	//
	 output reg Jump,			//Indica la presencia de un Jump
	 output reg [1:0] trunkMode,	//Indica si se trunca a Byte, Half o Word
	 output reg ShiftToTrunk		//Indica que hay que hacerle un shift al registro base cuando se necesita un trunk
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
					trunkMode=0;
					ShiftToTrunk=0;
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
					trunkMode=0;//ok
					ShiftToTrunk=0;
				end
			6'b100011: //LW (Load Word)
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
					trunkMode=0;
					ShiftToTrunk=0;
				end
			6'b100001: //LH (Load Half)
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
					trunkMode=2'b01;
					ShiftToTrunk=1;
				end
			6'b100000: //LB (Load Byte)
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
					trunkMode=2'b10;
					ShiftToTrunk=1;
				end
			6'b101011:	//SW (Store Word)
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
					trunkMode=0;
					ShiftToTrunk=0;
				end
			6'b101001:	//SH (Store Half)
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
					trunkMode=2'b01;
					ShiftToTrunk=1;
				end
			6'b101000:	//SB (Store Byte)
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
					trunkMode=2'b10;
					ShiftToTrunk=1;
				end
			6'b000100: //BEQ (Branch Equal)
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
					trunkMode=0;
					ShiftToTrunk=0;
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
					trunkMode=0;
					ShiftToTrunk=0;
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
					trunkMode=0;
					ShiftToTrunk=0;
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
					trunkMode=0;
					ShiftToTrunk=0;
				end
		endcase
		
	end

endmodule
