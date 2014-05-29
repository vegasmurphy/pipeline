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
    input [5:0] opcode,		//Codigo de operacion de la instruccion
    input [5:0] LSB,			//LSB de la instruccion (para elegir entre Junps y R-Type)
	 output reg RegDest,		//Indica si el numero de un registro a escribir es instruction_EX[15:11](1) o instruction_EX[20:16](0)
	 output reg BranchEQ,	//Indica la presencia de un Branch Equal
	 output reg BranchNE,	//Indica la presencia de un Branch NOT Equal
	 output reg MemRead,		//Read enable de la Memoria RAM (Indica que hay un Load)
	 output reg MemToReg,	//Indica si se graba AluResult(0) o un dato de la memoria(1) en un Registro
	 output reg ALUOp1,		//Indica Que orden ALUControl le da a la ALU
	 output reg ALUOp2,		//Indica Que orden ALUControl le da a la ALU
	 output reg MemWrite,	//Write enable de la Memoria RAM (Indica que hay un Store)
	 output reg ALUSrc,		//Indica si a la ALU le entra el valor de un registro (0) o un Inmediato (1)
	 output reg RegWrite,	//Write Enable del banco de registros (indica que se va a escribir un registro)
	 output reg Jump,			//Indica la presencia de un Jump
	 output reg [1:0] trunkMode,	//Indica si se trunca a Byte, Half o Word
	 output reg ShiftToTrunk,		//Indica que hay que hacerle un shift al registro base cuando se necesita un trunk
	 output reg sinSigno,	//Indica que SignExtender tiene que ir sin signo (LWU, LHU o LBU)
	 output reg JReg,			//Indica un Jump con uso de Registros
	 output reg savePc
	 );


always @(*)
	begin
		case (opcode)	//Special
			6'b000000: 	//R-type (ALU)
				if(LSB==6'b001000)//JR
				begin
					savePc=0;
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
					sinSigno=0;
					JReg=1;
				end
				//else if(LSB==001001)//JALR (es lo mismo que JAL pero JReg=1 y RegDest=1)
				else begin //R-Type
					savePc=0;
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
					sinSigno=0;
					JReg=0;
				end
			//****Instrucciones Load y Store****//
			6'b100011: //LW (Load Word)
				begin
					savePc=0;
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
					sinSigno=0;
					JReg=0;
				end
			6'b100001: //LH (Load Half)
				begin
					savePc=0;
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
					sinSigno=0;
					JReg=0;
				end
			6'b100000: //LB (Load Byte)
				begin
					savePc=0;
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
					sinSigno=0;
					JReg=0;
				end
			6'b101011:	//SW (Store Word)
				begin
					savePc=0;
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
					sinSigno=0;
					JReg=0;
				end
			6'b101001:	//SH (Store Half)
				begin
					savePc=0;
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
					sinSigno=0;
					JReg=0;
				end
			6'b101000:	//SB (Store Byte)
				begin
					savePc=0;
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
					sinSigno=0;
					JReg=0;
				end
			6'b100111: //LWU (Load Word Unsigned)
				begin
					savePc=0;
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
					sinSigno=1;
					JReg=0;
				end
			6'b100101: //LHU (Load Half Unsigned)
				begin
					savePc=0;
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
					sinSigno=1;
					JReg=0;
				end
			6'b100100: //LBU (Load Byte Unsigned)
				begin
					savePc=0;
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
					sinSigno=1;
					JReg=0;
				end
			//****Instrucciones aritmeticas I-type****//
			6'b001000: 	//ADDI [OK]
				begin
					savePc=0;
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
					sinSigno=0;
					JReg=0;
				end
			6'b001001: 	//ADDIU
				begin
					savePc=0;
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
					sinSigno=0;
					JReg=0;
				end
			6'b001100: 	//ANDI
				begin
					savePc=0;
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
					sinSigno=0;
					JReg=0;
				end
			6'b001101: 	//ORI
				begin
					savePc=0;
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
					sinSigno=0;
					JReg=0;
				end
			6'b001110: 	//XORI
				begin
					savePc=0;
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
					sinSigno=0;
					JReg=0;
				end
			6'b001010: 	//SLTI
				begin
					savePc=0;
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
					sinSigno=0;
					JReg=0;
				end
			6'b001011: 	//SLTIU
				begin
					savePc=0;
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
					sinSigno=0;
					JReg=0;
				end
			6'b001111:	//LUI (Load Upper Immediate)
			begin
					savePc=0;
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
					sinSigno=0;
					JReg=0;
				end
			//****Instrucciones de Branch y Salto****//
			6'b000100: //BEQ (Branch Equal)
				begin
					savePc=0;
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
					sinSigno=0;
					JReg=0;
				end
			6'b000101: //BNE
				begin
					savePc=0;
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
					sinSigno=0;
					JReg=0;
				end
			6'b000010://J (Jump) 
				begin
					savePc=0;
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
					sinSigno=0;
					JReg=0;
				end
			6'b000011://JAL (Jump and Link)
				begin
					savePc=1;
					RegDest=0;
					BranchEQ=0;
					BranchNE=0;
					MemRead=0;
					MemToReg=0;
					ALUOp1=0;
					ALUOp2=0;
					MemWrite=0;
					ALUSrc=0;
					RegWrite=1;
					Jump=1;
					trunkMode=0;
					ShiftToTrunk=0;
					sinSigno=0;
					JReg=0;
				end
			default: //(NOP)
				begin
					savePc=0;
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
					sinSigno=0;
					JReg=0;
				end
		endcase
		
	end

endmodule
