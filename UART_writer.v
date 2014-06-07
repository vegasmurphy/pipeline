`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:12:38 04/23/2014 
// Design Name: 
// Module Name:    UART_writer 
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
module UART_writer(
    input fastClk,
	 input rx,
	 output tx_out,
	 output [31:0]PC_sumado_IF,
	 output [31:0] instruction_IF
	 
    );
	//Wires
	wire clk;
	wire fifo_full;

	//***Modulos Instanciados***//
	//Divisor de clock (DCM)
	wire clk2;
	clockDivider dcm (.CLK_IN1(fastClk),.CLK_OUT1(clk),.CLK_OUT2(clk2));

	//Bloque testeado
	reg debugMode,debugClk;
	reg [31:0] DebugAddress=-1;
	wire [31:0]instruction,Read_Data_2_MEM,instructionID,Read_Data_1_ID,Read_Data_2_ID,Read_data_MEM,Read_data_WB,ALU_result_WB,ALU_result_EX,ALU_result_MEM;
	reg clkPipe = 0;
	wire [31:0] reg_array0,reg_array1,reg_array2,reg_array3,reg_array4,reg_array5,reg_array6,reg_array7,reg_array8,reg_array9;
	wire [31:0] reg_array10,reg_array11,reg_array12,reg_array13,reg_array14,reg_array15,reg_array16,reg_array17,reg_array18,reg_array19;
	wire [31:0] reg_array20,reg_array21,reg_array22,reg_array23,reg_array24,reg_array25,reg_array26,reg_array27,reg_array28,reg_array29;
	wire [31:0] reg_array30,reg_array31,PC_sumado_EX,Read_Data_1_EX,Read_Data_2_EX,instruction_EX;
	wire RegDest_ID,BranchEQ_ID,BranchNE_ID,MemRead_ID,MemToReg_ID,ALUOp1_ID,ALUOp2_ID,MemWrite_ID;
	wire ALUSrc_ID,RegWrite_ID,ShiftToTrunk_ID,RegDest_EX,BranchEQ_EX,BranchNE_EX,MemRead_EX,MemToReg_EX;
	wire MemWrite_EX,ALUSrc_EX,RegWrite_EX,Jump_EX;
	wire [1:0] trunkMode_ID,trunkMode_EX;
	wire ShiftToTrunk_EX,Zero_EX,BranchEQ_MEM,BranchNE_MEM,MemRead_MEM,MemToReg_MEM,MemWrite_MEM,RegWrite_MEM;
	wire [4:0] Write_register_EX,Write_register_MEM,Write_register_WB;
	wire Jump_MEM,Zero_MEM,MemToReg_WB,RegWrite_WB,BranchTaken,Jump_ID,IF_Flush,forwardA;
	wire savePc_ID,savePc_EX,savePc_MEM,savePc_WB,JReg_ID;
	
	Pipeline pipe
		(	.clk(clkPipe),
			.debugClk(debugClk),
			.Read_Data_1_ID(Read_Data_1_ID),
			.Read_Data_2_ID(Read_Data_2_ID),
			.PC_sumado_IF(PC_sumado_IF),
			.instruction_IF(instruction),
			.instruction_ID(instructionID),
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
			.ShiftToTrunk_ID(ShiftToTrunk_ID),
			.RegDest_EX(RegDest_EX),
			.BranchEQ_EX(BranchEQ_EX),
			.BranchNE_EX(BranchNE_EX),
			.MemRead_EX(MemRead_EX),
			.MemToReg_EX(MemToReg_EX),
			.PC_sumado_EX(PC_sumado_EX),
			.trunkMode_ID(trunkMode_ID),
			.Read_Data_1_EX(Read_Data_1_EX),
			.Read_Data_2_EX(Read_Data_2_EX),
			.instruction_EX(instruction_EX),
			.MemWrite_EX(MemWrite_EX),
			.ALUSrc_EX(ALUSrc_EX),
			.RegWrite_EX(RegWrite_EX),
			.Jump_EX(Jump_EX),
			.trunkMode_EX(trunkMode_EX),
			.ShiftToTrunk_EX(ShiftToTrunk_EX),
			.Zero_EX(Zero_EX),
			.BranchEQ_MEM(BranchEQ_MEM),
			.BranchNE_MEM(BranchNE_MEM),
			.MemRead_MEM(MemRead_MEM),
			.MemToReg_MEM(MemToReg_MEM),
			.MemWrite_MEM(MemWrite_MEM),
			.RegWrite_MEM(RegWrite_MEM),
			.ALU_result_EX(ALU_result_EX),
			.ALU_result_MEM(ALU_result_MEM),
			.Write_register_EX(Write_register_EX),
			.Write_register_MEM(Write_register_MEM),
			.Write_register_WB(Write_register_WB),
			.Jump_MEM(Jump_MEM),
			.Zero_MEM(Zero_MEM),
			.MemToReg_WB(MemToReg_WB),
			.RegWrite_WB(RegWrite_WB),
			.BranchTaken(BranchTaken),
			.Jump_ID(Jump_ID),
			.JReg_ID(JReg_ID),
			.IF_Flush(IF_Flush),
			.forwardA(forwardA),
			.Read_data_MEM(Read_data_MEM),
			.Read_data_WB(Read_data_WB),
			.ALU_result_WB(ALU_result_WB),
			.DebugAddress(DebugAddress),
			.debugMode(debugMode),
			.Read_Data_2_MEM(Read_Data_2_MEM),
			.reg_array0(reg_array0),
			.reg_array1(reg_array1),
			.reg_array2(reg_array2),
			.reg_array3(reg_array3),
			.reg_array4(reg_array4),
			.reg_array5(reg_array5),
			.reg_array6(reg_array6),
			.reg_array7(reg_array7),
			.reg_array8(reg_array8),
			.reg_array9(reg_array9),
			.reg_array10(reg_array10),
			.reg_array11(reg_array11),
			.reg_array12(reg_array12),
			.reg_array13(reg_array13),
			.reg_array14(reg_array14),
			.reg_array15(reg_array15),
			.reg_array16(reg_array16),
			.reg_array17(reg_array17),
			.reg_array18(reg_array18),
			.reg_array19(reg_array19),
			.reg_array20(reg_array20),
			.reg_array21(reg_array21),
			.reg_array22(reg_array22),
			.reg_array23(reg_array23),
			.reg_array24(reg_array24),
			.reg_array25(reg_array25),
			.reg_array26(reg_array26),
			.reg_array27(reg_array27),
			.reg_array28(reg_array28),
			.reg_array29(reg_array29),
			.reg_array30(reg_array30),
			.reg_array31(reg_array31),
			.savePc_ID(savePc_ID),
			.savePc_EX(savePc_EX),
			.savePc_MEM(savePc_MEM),
			.savePc_WB(savePc_WB)
		);

	//Uart TX
	wire fifo_empty;
	wire [7:0] palabra;
	wire tx_done;
	uart_tx tx(
	  .clk_tx(clk),          			// Clock input
	  .rst_clk_tx(1'b0),      			// Active HIGH reset - synchronous to clk_tx
	  .char_fifo_empty(fifo_empty), 	// Empty signal from char FIFO (FWFT)
	  .char_fifo_dout(palabra),  		// Data from the char FIFO
	  .char_fifo_rd_en(tx_done), 		// Pop signal to the char FIFO
	  .txd_tx(tx_out)           		// The transmit serial signal
	);

	//Fifo
	reg [7:0] fifo_din = 5;
	reg fifo_wr_en=0;
	reg fifo_reset=0;
	fifo f(
	  .clk(clk),
	  .rst(1'b0),
	  .din(fifo_din),
	  .wr_en(fifo_wr_en),
	  .rd_en(tx_done),
	  .dout(palabra),
	  .full(fifo_full),
	  .empty(fifo_empty)
	);

	//****Assigns****//
	//assign fifo_din=instruction[7:0];



	//***************************HOY*************************************//
		
	//Uart RX
	wire [7:0] rx_data;
	uart_rx r(
		.clk_rx(clk),
		.rst_clk_rx(1'b0),
		.rxd_i(rx),
		.rx_data(rx_data),
		.rx_data_rdy(rx_data_rdy)
	);	
	
	//****Maquina de Estados****//
	localparam [2:0] 	WAITING 	= 3'b000,
							SENDING 	= 3'b001,
							DONE 		= 3'b010,
							READ_MEMORY = 3'b011,
							SENDMEMORY = 3'b100,
							STARTRAM='b101,
							NEXTRAM='b110,
							RESETRAM='b111;
	
	//Declaración de señales

	reg[2:0] current_state=WAITING, next_state=WAITING;
	reg [7:0] currentRegister=8'b00000001;
	reg [3:0] currentMEM=4'b0001;
	always @(posedge clk)
	begin
		case(current_state)
			WAITING:
				begin
					if(rx_data=="A")
					begin
						clkPipe=1;
						next_state=SENDING;
					end
					if(rx_data=="B")
					begin
						next_state=STARTRAM;
						
					end
				end
			SENDING:
				begin
					clkPipe=0;
					fifo_wr_en=1;
					fifo_din <= PC_sumado_IF[7:0];
					case(currentRegister)
						//Un cero al Principio
						//8'b00000000:fifo_din <= 0;
						//PC
						8'b00000001:fifo_din <= PC_sumado_IF[7:0];
						8'b00000010:fifo_din <= PC_sumado_IF[15:8];
						8'b00000011:fifo_din <= PC_sumado_IF[23:16];
						8'b00000100:fifo_din <= PC_sumado_IF[31:24];
						//Instruccion
						8'b00000101:fifo_din <= instruction[7:0];
						8'b00000110:fifo_din <= instruction[15:8];
						8'b00000111:fifo_din <= instruction[23:16];
						8'b00001000:fifo_din <= instruction[31:24];
						//****************//
						//*Registros (ID)*//
						//****************//
						//Registro cero
						8'b00001001:fifo_din <= reg_array0[7:0];
						8'b00001010:fifo_din <= reg_array0[15:8];
						8'b00001011:fifo_din <= reg_array0[23:16];
						8'b00001100:fifo_din <= reg_array0[31:24];
						//Registro Uno
						8'b00001101:fifo_din <= reg_array1[7:0];
						8'b00001110:fifo_din <= reg_array1[15:8];
						8'b00001111:fifo_din <= reg_array1[23:16];
						8'b00010000:fifo_din <= reg_array1[31:24];
						//Registro Dos
						8'b00010001:fifo_din <= reg_array2[7:0];
						8'b00010010:fifo_din <= reg_array2[15:8];
						8'b00010011:fifo_din <= reg_array2[23:16];
						8'b00010100:fifo_din <= reg_array2[31:24];
						//Registro Tres
						8'b00010101:fifo_din <= reg_array3[7:0];
						8'b00010110:fifo_din <= reg_array3[15:8];
						8'b00010111:fifo_din <= reg_array3[23:16];
						8'b00011000:fifo_din <= reg_array3[31:24];
						//Registro Cuatro
						8'b00011001:fifo_din <= reg_array4[7:0];
						8'b00011010:fifo_din <= reg_array4[15:8];
						8'b00011011:fifo_din <= reg_array4[23:16];
						8'b00011100:fifo_din <= reg_array4[31:24];
						//Registro Cinco
						8'b00011101:fifo_din <= reg_array5[7:0];
						8'b00011110:fifo_din <= reg_array5[15:8];
						8'b00011111:fifo_din <= reg_array5[23:16];
						8'b00100000:fifo_din <= reg_array5[31:24];
						//Registro Seis
						8'b00100001:fifo_din <= reg_array6[7:0];
						8'b00100010:fifo_din <= reg_array6[15:8];
						8'b00100011:fifo_din <= reg_array6[23:16];
						8'b00100100:fifo_din <= reg_array6[31:24];
						//Registro Siete
						8'b00100101:fifo_din <= reg_array7[7:0];
						8'b00100110:fifo_din <= reg_array7[15:8];
						8'b00100111:fifo_din <= reg_array7[23:16];
						8'b00101000:fifo_din <= reg_array7[31:24];
						//Registro Ocho
						8'b00101001:fifo_din <= reg_array8[7:0];
						8'b00101010:fifo_din <= reg_array8[15:8];
						8'b00101011:fifo_din <= reg_array8[23:16];
						8'b00101100:fifo_din <= reg_array8[31:24];
						//Registro Nueve
						8'b00101101:fifo_din <= reg_array9[7:0];
						8'b00101110:fifo_din <= reg_array9[15:8];
						8'b00101111:fifo_din <= reg_array9[23:16];
						8'b00110000:fifo_din <= reg_array9[31:24];
						//Registro Diez
						8'b00110001:fifo_din <= reg_array10[7:0];
						8'b00110010:fifo_din <= reg_array10[15:8];
						8'b00110011:fifo_din <= reg_array10[23:16];
						8'b00110100:fifo_din <= reg_array10[31:24];
						//Registro Once
						8'b00110101:fifo_din <= reg_array11[7:0];
						8'b00110110:fifo_din <= reg_array11[15:8];
						8'b00110111:fifo_din <= reg_array11[23:16];
						8'b00111000:fifo_din <= reg_array11[31:24];
						//Registro Doce
						8'b00111001:fifo_din <= reg_array12[7:0];
						8'b00111010:fifo_din <= reg_array12[15:8];
						8'b00111011:fifo_din <= reg_array12[23:16];
						8'b00111100:fifo_din <= reg_array12[31:24];
						//Registro Trece
						8'b00111101:fifo_din <= reg_array13[7:0];
						8'b00111110:fifo_din <= reg_array13[15:8];
						8'b00111111:fifo_din <= reg_array13[23:16];
						8'b01000000:fifo_din <= reg_array13[31:24];
						//Registro Catorce
						8'b01000001:fifo_din <= reg_array14[7:0];
						8'b01000010:fifo_din <= reg_array14[15:8];
						8'b01000011:fifo_din <= reg_array14[23:16];
						8'b01000100:fifo_din <= reg_array14[31:24];
						//Registro Quince
						8'b01000101:fifo_din <= reg_array15[7:0];
						8'b01000110:fifo_din <= reg_array15[15:8];
						8'b01000111:fifo_din <= reg_array15[23:16];
						8'b01001000:fifo_din <= reg_array15[31:24];
						//Registro Dieciseis
						8'b01001001:fifo_din <= reg_array16[7:0];
						8'b01001010:fifo_din <= reg_array16[15:8];
						8'b01001011:fifo_din <= reg_array16[23:16];
						8'b01001100:fifo_din <= reg_array16[31:24];
						//Registro Diecisiete
						8'b01001101:fifo_din <= reg_array17[7:0];
						8'b01001110:fifo_din <= reg_array17[15:8];
						8'b01001111:fifo_din <= reg_array17[23:16];
						8'b01010000:fifo_din <= reg_array17[31:24];
						//Registro Dieciocho
						8'b01010001:fifo_din <= reg_array18[7:0];
						8'b01010010:fifo_din <= reg_array18[15:8];
						8'b01010011:fifo_din <= reg_array18[23:16];
						8'b01010100:fifo_din <= reg_array18[31:24];
						//Registro Diecinueve
						8'b01010101:fifo_din <= reg_array19[7:0];
						8'b01010110:fifo_din <= reg_array19[15:8];
						8'b01010111:fifo_din <= reg_array19[23:16];
						8'b01011000:fifo_din <= reg_array19[31:24];
						//Registro Veinte
						8'b01011001:fifo_din <= reg_array20[7:0];
						8'b01011010:fifo_din <= reg_array20[15:8];
						8'b01011011:fifo_din <= reg_array20[23:16];
						8'b01011100:fifo_din <= reg_array20[31:24];
						//Registro Ventiuno
						8'b01011101:fifo_din <= reg_array21[7:0];
						8'b01011110:fifo_din <= reg_array21[15:8];
						8'b01011111:fifo_din <= reg_array21[23:16];
						8'b01100000:fifo_din <= reg_array21[31:24];
						//Registro Ventidos
						8'b01100001:fifo_din <= reg_array22[7:0];
						8'b01100010:fifo_din <= reg_array22[15:8];
						8'b01100011:fifo_din <= reg_array22[23:16];
						8'b01100100:fifo_din <= reg_array22[31:24];
						//Registro Ventitres
						8'b01100101:fifo_din <= reg_array23[7:0];
						8'b01100110:fifo_din <= reg_array23[15:8];
						8'b01100111:fifo_din <= reg_array23[23:16];
						8'b01101000:fifo_din <= reg_array23[31:24];
						//Registro Venticuatro
						8'b01101001:fifo_din <= reg_array24[7:0];
						8'b01101010:fifo_din <= reg_array24[15:8];
						8'b01101011:fifo_din <= reg_array24[23:16];
						8'b01101100:fifo_din <= reg_array24[31:24];
						//Registro Venticinco
						8'b01101101:fifo_din <= reg_array25[7:0];
						8'b01101110:fifo_din <= reg_array25[15:8];
						8'b01101111:fifo_din <= reg_array25[23:16];
						8'b01110000:fifo_din <= reg_array25[31:24];
						//Registro Ventiseis
						8'b01110001:fifo_din <= reg_array26[7:0];
						8'b01110010:fifo_din <= reg_array26[15:8];
						8'b01110011:fifo_din <= reg_array26[23:16];
						8'b01110100:fifo_din <= reg_array26[31:24];
						//Registro Ventisiete
						8'b01110101:fifo_din <= reg_array27[7:0];
						8'b01110110:fifo_din <= reg_array27[15:8];
						8'b01110111:fifo_din <= reg_array27[23:16];
						8'b01111000:fifo_din <= reg_array27[31:24];
						//Registro Ventiocho
						8'b01111001:fifo_din <= reg_array28[7:0];
						8'b01111010:fifo_din <= reg_array28[15:8];
						8'b01111011:fifo_din <= reg_array28[23:16];
						8'b01111100:fifo_din <= reg_array28[31:24];
						//Registro Ventinueve
						8'b01111101:fifo_din <= reg_array29[7:0];
						8'b01111110:fifo_din <= reg_array29[15:8];
						8'b01111111:fifo_din <= reg_array29[23:16];
						8'b10000000:fifo_din <= reg_array29[31:24];
						//Registro Treinta
						8'b10000001:fifo_din <= reg_array30[7:0];
						8'b10000010:fifo_din <= reg_array30[15:8];
						8'b10000011:fifo_din <= reg_array30[23:16];
						8'b10000100:fifo_din <= reg_array30[31:24];
						//Registro Treinta y uno
						8'b10000101:fifo_din <= reg_array31[7:0];
						8'b10000110:fifo_din <= reg_array31[15:8];
						8'b10000111:fifo_din <= reg_array31[23:16];
						8'b10001000:fifo_din <= reg_array31[31:24];
						//Instruction ID
						8'b10001001:fifo_din <= instructionID[7:0];
						8'b10001010:fifo_din <= instructionID[15:8];
						8'b10001011:fifo_din <= instructionID[23:16];
						8'b10001100:fifo_din <= instructionID[31:24];
						//Read Data 1 ID
						8'b10001101:fifo_din <= Read_Data_1_ID[7:0];
						8'b10001110:fifo_din <= Read_Data_1_ID[15:8];
						8'b10001111:fifo_din <= Read_Data_1_ID[23:16];
						8'b10010000:fifo_din <= Read_Data_1_ID[31:24];
						//Read Data 2 ID
						8'b10010001:fifo_din <= Read_Data_2_ID[7:0];
						8'b10010010:fifo_din <= Read_Data_2_ID[15:8];
						8'b10010011:fifo_din <= Read_Data_2_ID[23:16];
						8'b10010100:fifo_din <= Read_Data_2_ID[31:24];
						//Flags
						8'b10010101:fifo_din <= {RegDest_ID,BranchEQ_ID,BranchNE_ID,MemRead_ID,MemToReg_ID,ALUOp1_ID,ALUOp2_ID,MemWrite_ID};
						8'b10010110:fifo_din <= {ALUSrc_ID,RegWrite_ID,ShiftToTrunk_ID,RegDest_EX,BranchEQ_EX,BranchNE_EX,MemRead_EX,MemToReg_EX};
						8'b10010111:fifo_din <= {trunkMode_ID,MemWrite_EX,ALUSrc_EX,RegWrite_EX,Jump_EX,trunkMode_EX};						
						//PC sumado EX
						8'b10011000:fifo_din <= PC_sumado_EX[7:0];
						8'b10011001:fifo_din <= PC_sumado_EX[15:8];
						8'b10011010:fifo_din <= PC_sumado_EX[23:16];
						8'b10011011:fifo_din <= PC_sumado_EX[31:24];
						//Read data Ex 1 y 2
						8'b10011100:fifo_din <= Read_Data_1_EX[7:0];
						8'b10011101:fifo_din <= Read_Data_1_EX[15:8];
						8'b10011110:fifo_din <= Read_Data_1_EX[23:16];
						8'b10011111:fifo_din <= Read_Data_1_EX[31:24];
						8'b10100000:fifo_din <= Read_Data_2_EX[7:0];
						8'b10100001:fifo_din <= Read_Data_2_EX[15:8];
						8'b10100010:fifo_din <= Read_Data_2_EX[23:16];
						8'b10100011:fifo_din <= Read_Data_2_EX[31:24];
						//instruction EX
						8'b10100100:fifo_din <= instruction_EX[7:0];
						8'b10100101:fifo_din <= instruction_EX[15:8];
						8'b10100110:fifo_din <= instruction_EX[23:16];
						8'b10100111:fifo_din <= instruction_EX[31:24];
						
						8'b10101000:fifo_din <= ALU_result_EX[7:0];
						8'b10101001:fifo_din <= ALU_result_EX[15:8];
						8'b10101010:fifo_din <= ALU_result_EX[23:16];
						8'b10101011:fifo_din <= ALU_result_EX[31:24];
						
						8'b10101100:fifo_din <= ALU_result_MEM[7:0];
						8'b10101101:fifo_din <= ALU_result_MEM[15:8];
						8'b10101110:fifo_din <= ALU_result_MEM[23:16];
						8'b10101111:fifo_din <= ALU_result_MEM[31:24];
						
						
						8'b10110000:fifo_din <= {ShiftToTrunk_EX,Zero_EX,BranchEQ_MEM,BranchNE_MEM,MemRead_MEM,MemToReg_MEM,MemWrite_MEM,RegWrite_MEM};
						//write back reg
						8'b10110001:fifo_din <= {Jump_MEM,Zero_MEM,MemToReg_WB,Write_register_EX};
						8'b10110010:fifo_din <= {RegWrite_WB,BranchTaken,Jump_ID,Write_register_MEM};
						8'b10110011:fifo_din <= {IF_Flush,forwardA,Write_register_WB};

						8'b10110100:fifo_din <= Read_data_MEM[7:0];
						8'b10110101:fifo_din <= Read_data_MEM[15:8];
						8'b10110110:fifo_din <= Read_data_MEM[23:16];
						8'b10110111:fifo_din <= Read_data_MEM[31:24];
						
						8'b10111000:fifo_din <= Read_data_WB[7:0];
						8'b10111001:fifo_din <= Read_data_WB[15:8];
						8'b10111010:fifo_din <= Read_data_WB[23:16];
						8'b10111011:fifo_din <= Read_data_WB[31:24];
						
						8'b10111100:fifo_din <= ALU_result_WB[7:0];
						8'b10111101:fifo_din <= ALU_result_WB[15:8];
						8'b10111110:fifo_din <= ALU_result_WB[23:16];
						8'b10111111:fifo_din <= ALU_result_WB[31:24];

						
						8'b11000000:fifo_din <= Read_Data_2_MEM[7:0];
						8'b11000001:fifo_din <= Read_Data_2_MEM[15:8];
						8'b11000010:fifo_din <= Read_Data_2_MEM[23:16];
						8'b11000011:fifo_din <= Read_Data_2_MEM[31:24];
						
						8'b11000100:fifo_din <= {savePc_ID,savePc_EX,savePc_MEM,savePc_WB,JReg_ID,3'b000};
						//***************//
						//* Latch IF/ID *//
						//***************//
						//Default
						default:fifo_din <= PC_sumado_IF[7:0];
					endcase
					currentRegister=currentRegister+1;
					if(currentRegister==8'b11001000)//Ultimo valor +4
						begin
							currentRegister=8'b00000001;
							fifo_wr_en=0;
							next_state=DONE;
						end
				end
			STARTRAM:
				begin
					DebugAddress=DebugAddress+1;;
					debugMode=1;
					debugClk=1;
					next_state=NEXTRAM;
				end
			NEXTRAM:
				begin
					debugClk=0;
					next_state=READ_MEMORY;
				end
			READ_MEMORY:
				begin
					debugClk=1;
					if(DebugAddress<21)
						next_state=SENDMEMORY;
					else
						begin
							debugClk=0;
							next_state=RESETRAM;
							DebugAddress=ALU_result_MEM;
						end
				end
			SENDMEMORY:
			begin
					debugClk=0;
					fifo_wr_en=1;
					case(currentMEM)
						4'b0001:fifo_din <= Read_data_MEM[7:0];
						4'b0010:fifo_din <= Read_data_MEM[15:8];
						4'b0011:fifo_din <= Read_data_MEM[23:16];
						4'b0100:fifo_din <= Read_data_MEM[31:24];
						default:fifo_din <= Read_data_MEM[7:0];
					endcase
					currentMEM=currentMEM+1;
					if(currentMEM==4'b0110)//Ultimo valor +4
						begin
							currentMEM=4'b0001;
							fifo_wr_en=0;
							next_state=STARTRAM;
						end
			end
			RESETRAM:
				begin
					DebugAddress=ALU_result_MEM;
					debugClk=1;
					next_state=DONE;
				end
			DONE:
				begin
					DebugAddress=-1;
					debugMode=0;
					debugClk=0;
					if(rx_data!="A"&&rx_data!="B")
						next_state=WAITING;
				end
			default:
				begin
					next_state=WAITING;
				end
		endcase
		//Pasar al siguiente estado
		current_state <= next_state;
	end
endmodule
