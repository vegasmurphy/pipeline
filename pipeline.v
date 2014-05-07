`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:45:05 04/24/2014 
// Design Name: 
// Module Name:    pipeline 
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
module Pipeline(
    input wire clk,
    
	//Debugging outputs
	output wire [3:0]aluInstruction,
	output wire equalFlag,
	output wire [31:0] rtData,
	output wire [31:0] rsData,
		 
	//IF_ID  WIRES
	output [31:0] instruction_IF, 
	output [31:0] PC_sumado_IF, 
	output [31:0] instruction_ID,

	//ID_EX WIRES
	output [31:0] Read_Data_1_ID,
	output [31:0] Read_Data_2_ID,
	output [31:0] signExtended_ID,
	output [31:0] PC_sumado_ID,
	output RegDest_ID,
	output BranchEQ_ID,
	output BranchNE_ID,
	output MemRead_ID,
	output MemToReg_ID,
	output ALUOp1_ID,
	output ALUOp2_ID,
	output MemWrite_ID,
	output ALUSrc_ID,
	output RegWrite_ID,
	//output Jump_ID,
	output ShiftToTrunk_ID,
	output [1:0] trunkMode_ID,
	output [31:0] PC_sumado_EX,
	output [31:0] Read_Data_1_EX,
	output [31:0] Read_Data_2_EX,
	output reg [31:0] aluInput1,
	output reg [31:0] aluInput2,
	output [31:0] signExtended_EX,
	output [31:0] instruction_EX,
	output RegDest_EX,
	output BranchEQ_EX,
	output BranchNE_EX,
	output MemRead_EX,
	output MemToReg_EX,
	output ALUOp1_EX,
	output ALUOp2_EX,
	output MemWrite_EX,
	output ALUSrc_EX,
	output RegWrite_EX,
	output Jump_EX,
	output [1:0] trunkMode_EX,
	output ShiftToTrunk_EX,
	
	
	//EX_MEM WIRES
	output [31:0] PC_next_ID,
	output [31:0] ALU_result_EX,
	output [31:0] ALU_result_MEM,
	output [31:0] Read_Data_2_MEM,
	output Zero_EX,
	output [4:0] Write_register_EX,
	output BranchEQ_MEM,
	output BranchNE_MEM,
	output MemRead_MEM,
	output MemToReg_MEM,
	output MemWrite_MEM,
	output RegWrite_MEM,
	output Jump_MEM,
	output [1:0] trunkMode_MEM,
	output ShiftToTrunk_MEM,
	output Zero_MEM,
	output [4:0] Write_register_MEM,
	
	//MEM_WB WIRES
	output [31:0] Read_data_MEM,
	output [31:0] Read_data_WB,
	output [31:0] ALU_result_WB,
	output MemToReg_WB,
	output RegWrite_WB,
	output [4:0] Write_register_WB,
 
 //Forwarding unit
	output [1:0] forwardA,
	output [1:0] forwardB,
 
	//Brances and Jump
	output BranchTaken,
	output Jump_ID,
	output IF_Flush
	 );

	//Internal Wires
	wire [31:0] PC_next, PC_next_2, Jump_Addr;
	//wire PCSrc;
		
		
	//assign PCSrc = Zero_MEM & Branch_MEM;
	assign PC_next_ID = signExtended_ID + PC_sumado_ID;
	//***********************MUXes*****************************//
	//Mux del PC (Branch)
	assign PC_next = BranchTaken ? PC_next_ID : PC_sumado_IF;
	
	//Mux2 del PC (Jump)
	assign PC_next_2 = Jump_ID ? Jump_Addr : PC_next;
	assign Jump_Addr = {PC_sumado_ID[31:26],instruction_ID[25:0]};
	
	//Mux de antes de los registros
	wire [4:0] Write_Addr;
	assign Write_register_EX = RegDest_EX ? instruction_EX[15:11] : instruction_EX[20:16];
	
	//Mux de antes de la ALU
	//wire [31:0] rsData,rtData;
	assign rtData = ALUSrc_EX ? signExtended_EX : aluInput2;
	assign rsData = ShiftToTrunk_EX ? (aluInput1*4) : aluInput1;
	
	//Mux de WriteBack
	wire [31:0] Write_Data;
	assign Write_Data = MemToReg_WB ? Read_data_WB : ALU_result_WB;

	//Muxes de Hazard Detection Unit
	wire [1:0]trunkMode_control;
	assign RegDest_ID  = nopMux ? 1'b0 : RegDest_control;
	assign BranchEQ_ID = nopMux ? 1'b0 : BranchEQ_control;
	assign BranchNE_ID = nopMux ? 1'b0 : BranchNE_control;
	assign MemRead_ID  = nopMux ? 1'b0 : MemRead_control;
	assign MemToReg_ID = nopMux ? 1'b0 : MemToReg_control;
	assign ALUOp1_ID   = nopMux ? 1'b0 : ALUOp1_control;
	assign ALUOp2_ID   = nopMux ? 1'b0 : ALUOp2_control;
	assign MemWrite_ID = nopMux ? 1'b0 : MemWrite_control;
	assign ALUSrc_ID   = nopMux ? 1'b0 : ALUSrc_control;
	assign RegWrite_ID = nopMux ? 1'b0 : RegWrite_control;
	assign Jump_ID 	 = nopMux ? 1'b0 : Jump_control;
	assign trunkMode_ID= nopMux ? 2'b00 : trunkMode_control;
	assign ShiftToTrunk_ID = nopMux?1'b0: ShiftToTrunk_control;


	//****************Modulos Instanciados*********************//
	
	wire IF_ID_write,PC_write,nopMux;
	HazardDetectionUnit hazardDetectionUnit(
		.MemRead_EX(MemRead_EX),					//Flag
		.RegisterRt_EX(instruction_EX[20:16]),	//Este esta bien (segun vegas)
		.RegisterRs_ID(instruction_ID[25:21]), //Falta verificar que este bien
		.RegisterRt_ID(instruction_ID[20:16]), //Falta verificar que este bien
		.IF_ID_write(IF_ID_write),					//if ==0 ID/IF stalls
		.PC_write(PC_write),							//if ==0 PC stalls
		.nopMux(nopMux)								//if ==1 nop
	);
		
	IntructionFetchBlock fetchBlock (
		.clk(clk),
		.PC_next(PC_next_2),
		.PC_write(PC_write),
		.PC_sumado_value(PC_sumado_IF),
		.Instruction(instruction_IF)
	);
	
	SignExtender SignEx (
		.unextended(instruction_ID[15:0]),	//Salto de 16bits
		.extended(signExtended_ID)				//Extension
	);		
	
	DataMemoryAccessBlock dataMemoryAccessBlock (
		.clk(clk),
		.MemWrite(MemWrite_MEM),
		.MemRead(MemRead_MEM),
		.BasePlusOffset(ALU_result_MEM),
		.WriteData(Read_Data_2_MEM),
		.trunkMode(trunkMode_MEM),
		.ShiftToTrunk(ShiftToTrunk_MEM),
		.TrunkedReadData(Read_data_MEM)
	);
	
	Registers registers (
		.clk(clk),									//clock
		.RegWrite(RegWrite_WB),					// (debe ser un Write Enable)
		.Read_Addr_1(instruction_ID[25:21]),//Se pueden leer dos registros
		.Read_Addr_2(instruction_ID[20:16]),//(-)
		.Write_Addr(Write_register_WB),		//Direccion (numero de registro) a escribir
		.Write_Data(Write_Data),				//Dato a escribir (Viene del Mux)
		.Read_Data_1(Read_Data_1_ID),			//Dato leido con la direccion Read_Addr_1
		.Read_Data_2(Read_Data_2_ID)
	);
	
	Control control (
		.opcode(instruction_ID[31:26]),
		.RegDest(RegDest_control),
		.BranchEQ(BranchEQ_control),
		.BranchNE(BranchNE_control),
		.MemRead(MemRead_control),
		.MemToReg(MemToReg_control),
		.ALUOp1(ALUOp1_control),
		.ALUOp2(ALUOp2_control),
		.MemWrite(MemWrite_control),
		.ALUSrc(ALUSrc_control),
		.RegWrite(RegWrite_control),
		.Jump(Jump_control),
		.trunkMode(trunkMode_control),
		.ShiftToTrunk(ShiftToTrunk_control)
		
	);
	
	ALUwithControl alu (
		//.data1(aluInput1),
		.data1(rsData),
		.data2(rtData),
		.sa(instruction_EX[10:6]),
		.instruction(signExtended_EX[5:0]),
		.ALUOp1(ALUOp1_EX),
		.ALUOp2(ALUOp2_EX),
		.zero(Zero_EX),
		.result(ALU_result_EX),
		.aluInstruction(aluInstruction)//output para debug nomas
	);
	
	
	
	ID_EX id_ex(
		.clk(clk), 
		.Read_Data_1_ID(Read_Data_1_ID), 
		.Read_Data_2_ID(Read_Data_2_ID), 
		.signExtended_ID(signExtended_ID), 
		.PC_sumado_ID(PC_sumado_ID), 
		.PC_sumado_EX(PC_sumado_EX),
		.instruction_ID(instruction_ID),
		.Read_Data_1_EX(Read_Data_1_EX), 
		.Read_Data_2_EX(Read_Data_2_EX), 
		.signExtended_EX(signExtended_EX),
		.instruction_EX(instruction_EX),
		.RegDest_ID(RegDest_ID),
		.BranchEQ_ID(BranchEQ_ID),
		.BranchNE_ID(BranchNE_ID),
		.MemRead_ID(MemRead_ID),
		.MemToReg_ID(MemToReg_ID),
		.ALUOp1_ID(ALUOp1_ID),
		.ALUOp2_ID(ALUOp2_ID),
		.MemWrite_ID(MemWrite_ID),
		.ALUSrc_ID(ALUSrc_ID),
		.RegWrite_ID(RegWrite_ID),
		.Jump_ID(Jump_ID),
		.trunkMode_ID(trunkMode_ID),
		.ShiftToTrunk_ID(ShiftToTrunk_ID),
		.RegDest_EX(RegDest_EX),
		.BranchEQ_EX(BranchEQ_EX),
		.BranchNE_EX(BranchNE_EX),
		.MemRead_EX(MemRead_EX),
		.MemToReg_EX(MemToReg_EX),
		.ALUOp1_EX(ALUOp1_EX),
		.ALUOp2_EX(ALUOp2_EX),
		.MemWrite_EX(MemWrite_EX),
		.ALUSrc_EX(ALUSrc_EX),
		.RegWrite_EX(RegWrite_EX),
		.Jump_EX(Jump_EX),
		.trunkMode_EX(trunkMode_EX),
		.ShiftToTrunk_EX(ShiftToTrunk_EX)
	);
	
	EX_MEM ex_mem (
		.clk(clk), 
		.ALU_result_EX(ALU_result_EX), 
		.Read_Data_2_EX(aluInput2), 
		.ALU_result_MEM(ALU_result_MEM), 
		.Read_Data_2_MEM(Read_Data_2_MEM),
		.BranchEQ_EX(BranchEQ_EX),
		.BranchNE_EX(BranchNE_EX),
		.MemRead_EX(MemRead_EX),
		.MemToReg_EX(MemToReg_EX),
		.MemWrite_EX(MemWrite_EX),
		.RegWrite_EX(RegWrite_EX),
		.Jump_EX(Jump_EX),
		.trunkMode_EX(trunkMode_EX),
		.ShiftToTrunk_EX(ShiftToTrunk_EX),
		.Zero_EX(Zero_EX),
		.Write_register_EX(Write_register_EX),
		.BranchEQ_MEM(BranchEQ_MEM),
		.BranchNE_MEM(BranchNE_MEM),
		.MemRead_MEM(MemRead_MEM),
		.MemToReg_MEM(MemToReg_MEM),
		.MemWrite_MEM(MemWrite_MEM),
		.RegWrite_MEM(RegWrite_MEM),
		.Jump_MEM(Jump_MEM),
		.trunkMode_MEM(trunkMode_MEM),
		.ShiftToTrunk_MEM(ShiftToTrunk_MEM),
		.Zero_MEM(Zero_MEM),
		.Write_register_MEM(Write_register_MEM)
	);
	
	
	MEM_WB mem_wb (
		.clk(clk), 
		.Read_data_MEM(Read_data_MEM), 
		.ALU_result_MEM(ALU_result_MEM),
		.RegWrite_MEM(RegWrite_MEM),
		.MemToReg_MEM(MemToReg_MEM),
		.Write_register_MEM(Write_register_MEM),
		.Read_data_WB(Read_data_WB),
		.ALU_result_WB(ALU_result_WB),
		.MemToReg_WB(MemToReg_WB),
		.RegWrite_WB(RegWrite_WB),
		.Write_register_WB(Write_register_WB)
	);
	
	IF_ID if_id (
		.clk(clk), 
		.instruction_IF(instruction_IF), 
		.PC_sumado_IF(PC_sumado_IF), 
		.IF_ID_write(IF_ID_write),
		.IF_Flush(IF_Flush),
		.instruction_ID(instruction_ID), 
		.PC_sumado_ID(PC_sumado_ID)
	);

	ForwardingUnit forwardingUnit(
	.rs_ex(instruction_EX[25:21]),
	.rt_ex(instruction_EX[20:16]),
	.rd_mem(Write_register_MEM),
	.rd_wb(Write_register_WB),
	.regWrite_mem(RegWrite_MEM),
	.regWrite_wb(RegWrite_WB),
	.forwardA(forwardA),
	.forwardB(forwardB)
    );

// *******************************  Forwarding unit multiplexors  ************************************
always @(forwardA, Read_Data_1_EX, ALU_result_MEM, Write_Data)
      case (forwardA)
         2'b00: aluInput1 = Read_Data_1_EX;
         2'b01: aluInput1 = Write_Data;
         2'b10: aluInput1 = ALU_result_MEM;
         2'b11: aluInput1 = Read_Data_1_EX;
      endcase

always @(forwardB, Read_Data_2_EX, ALU_result_MEM, Write_Data)
      case (forwardB)
         2'b00: aluInput2 = Read_Data_2_EX;
         2'b01: aluInput2 = Write_Data;
         2'b10: aluInput2 = ALU_result_MEM;
         2'b11: aluInput2 = Read_Data_2_EX;
      endcase


// ********************************* Register Comparison for Branch *************************************
	assign equalFlag = (Read_Data_1_ID == Read_Data_2_ID)? 1'b1:1'b0;

// ********************************* Branch Flag **********************************************
	assign BranchTaken = (equalFlag & BranchEQ_ID)||(~equalFlag & BranchNE_ID);

// ********************************** IF_Flush flag ********************************************
	assign IF_Flush = BranchTaken || Jump_ID;
endmodule

