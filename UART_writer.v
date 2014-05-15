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
	 input clkPipeline1,
	 output tx_out,
	 output [31:0]PC_sumado_IF
	 
    );

	wire done;
	wire [7:0] palabra,rx_data;
	wire rd_en,wr_en;
	wire tx_done;
	wire fifo_empty;
	wire rx_data_rdy;
	reg ready;


	localparam [2:0] IDLE = 3'b000,
						  PROCESSING = 3'b001,
						  SENDING = 3'b010,
						  SENDINGMEM = 3'b011,
						  RUNALL = 3'b101;
						 
	//Declaración de señales (las utilizare para el elemento de memoria por lo tanto son tipo REGISTRO)
	reg[2:0] current_state=IDLE, next_state=IDLE;
							
							
	//Registro de estado (Memoria)
	always @(posedge clk)
			current_state <= next_state;


	reg [7:0] fifo_din;
	reg fifo_wr_en=1;		
	reg clkPipeline=0;		
	reg [5:0] currentBlock=0;
	reg [1:0] currentByte=0;
	reg rx_data_rdy_ant=0;
	reg [7:0] next=8'b01110011;
	
	
	always @(negedge clk)
		begin
			case(current_state)
				IDLE:
					begin
						//fifo_din="S";
						if(rx_data_rdy)
							next_state = PROCESSING;
						else
							next_state = IDLE;
					fifo_wr_en=0;
					end
				PROCESSING://Cargar algo en la fifo si es un dato nuevo
					begin//Si es una A sigue, sino se queda en este estado.
						if((rx_data_rdy_ant!=rx_data_rdy)&&rx_data_rdy)
							begin
							//fifo_wr_en=1;
							end
						else
							begin
							fifo_wr_en=0;
							end
						
						if(rx_data=="A")
						begin
							//fifo_wr_en=1;
							fifo_din="B";
							clkPipeline=1;
							//fifo_wr_en=0;
							next_state = SENDING;
						end
						else
							begin
							fifo_din=rx_data;
							end
						rx_data_rdy_ant=rx_data_rdy;
					end
				SENDING: //Poner el valor del clk del pipeline en cero y enviar el valor del PC
					begin
					clkPipeline=0;
					fifo_wr_en=1;
					fifo_din="b";
						case(currentBlock)
							6'b000000: //envio PC
								begin
									case(currentByte)
										2'b00:fifo_din = PC_sumado_IF[7:0];
										2'b01:fifo_din = PC_sumado_IF[15:8];
										2'b10:fifo_din = PC_sumado_IF[23:16];
										2'b11:fifo_din = PC_sumado_IF[31:24];
										default:fifo_din = 0;
									endcase
									fifo_wr_en=1;
									//next_state=SENDING;
								end
							6'b000001: 
									begin
									case(currentByte)
										2'b00:fifo_din = instruction_ID[7:0];
										2'b01:fifo_din = instruction_ID[15:8];
										2'b10:fifo_din = instruction_ID[23:16];
										2'b11:fifo_din = instruction_ID[31:24];
										default:fifo_din = 0;
									endcase
									fifo_wr_en=1;
									//next_state=SENDING;
								end
							6'b000010:
										begin
											fifo_wr_en=0;
											next_state=IDLE;										
										end
							default: 
										begin
											fifo_wr_en=0;
											next_state=IDLE;
										end
						endcase
						
						currentByte=currentByte+2'b01;
						if(currentByte==2'b00)
							begin
							currentBlock=currentBlock+1;
							end
					end
				/*SENDINGMEM:
					begin
					end
				RUNALL:
					begin
					end
				default:
					begin
					end*/
			endcase
		end




	//assign fifo_din = PC_sumado_IF[7:0];




	uart_tx tx(
	  .clk_tx(clk),          // Clock input
	  .rst_clk_tx(1'b0),      // Active HIGH reset - synchronous to clk_tx
	  .char_fifo_empty(fifo_empty), // Empty signal from char FIFO (FWFT)
	  .char_fifo_dout(palabra),  // Data from the char FIFO
	  .char_fifo_rd_en(tx_done), // Pop signal to the char FIFO
		.txd_tx(tx_out)           // The transmit serial signal
	);


	wire fifo_full;
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

	wire [3:0] aluInstruction;
	wire equalFlag;
	wire [31:0] instruction_IF;
	wire [31:0] instruction_ID;
	wire [31:0] Read_Data_1_ID;
	wire [31:0] Read_Data_2_ID;
	wire [31:0] signExtended_ID;
	wire [31:0] PC_sumado_ID;
	wire RegDest_ID;
	wire BranchEQ_ID;
	wire BranchNE_ID;
	wire MemRead_ID;
	wire MemToReg_ID;
	wire ALUOp1_ID;
	wire ALUOp2_ID;
	wire MemWrite_ID;
	wire ALUSrc_ID;
	wire RegWrite_ID;
	wire [31:0] PC_sumado_EX;
	wire [31:0] Read_Data_1_EX;
	wire [31:0] Read_Data_2_EX;
	wire [31:0] aluInput1;
	wire [31:0] aluInput2;
	wire [31:0] signExtended_EX;
	wire [31:0] instruction_EX;
	wire RegDest_EX;
	wire BranchEQ_EX;
	wire BranchNE_EX;
	wire MemRead_EX;
	wire MemToReg_EX;
	wire ALUOp1_EX;
	wire ALUOp2_EX;
	wire MemWrite_EX;
	wire ALUSrc_EX;
	wire RegWrite_EX;
	wire Jump_EX;
	wire [31:0] PC_next_ID;
	wire [31:0] ALU_result_EX;
	wire [31:0] ALU_result_MEM;
	wire [31:0] Read_Data_2_MEM;
	wire Zero_EX;
	wire [4:0] Write_register_EX;
	wire BranchEQ_MEM;
	wire BranchNE_MEM;
	wire MemRead_MEM;
	wire MemToReg_MEM;
	wire MemWrite_MEM;
	wire RegWrite_MEM;
	wire Jump_MEM;
	wire Zero_MEM;
	wire [4:0] Write_register_MEM;
	wire [31:0] Read_data_MEM;
	wire [31:0] Read_data_WB;
	wire [31:0] ALU_result_WB;
	wire MemToReg_WB;
	wire RegWrite_WB;
	wire [4:0] Write_register_WB;
	wire [1:0] forwardA;
	wire [1:0] forwardB;
	wire BranchTaken;
	wire Jump_ID;
	wire IF_Flush;

	clockDivider dcm (.CLK_IN1(fastClk),.CLK_OUT1(clk));
	
	Pipeline uut (
		.clk(clkPipeline), 
		.aluInstruction(aluInstruction), 
		.equalFlag(equalFlag), 
		.rtData(rtData), 
		.rsData(rsData), 
		.instruction_IF(instruction_IF), 
		.PC_sumado_IF(PC_sumado_IF), 
		.instruction_ID(instruction_ID), 
		.Read_Data_1_ID(Read_Data_1_ID), 
		.Read_Data_2_ID(Read_Data_2_ID), 
		.signExtended_ID(signExtended_ID), 
		.PC_sumado_ID(PC_sumado_ID), 
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
		.trunkMode_ID(trunkMode_ID), 
		.PC_sumado_EX(PC_sumado_EX), 
		.Read_Data_1_EX(Read_Data_1_EX), 
		.Read_Data_2_EX(Read_Data_2_EX), 
		.aluInput1(aluInput1), 
		.aluInput2(aluInput2), 
		.signExtended_EX(signExtended_EX), 
		.instruction_EX(instruction_EX), 
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
		.ShiftToTrunk_EX(ShiftToTrunk_EX), 
		.PC_next_ID(PC_next_ID), 
		.ALU_result_EX(ALU_result_EX), 
		.ALU_result_MEM(ALU_result_MEM), 
		.Read_Data_2_MEM(Read_Data_2_MEM), 
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
		.Write_register_MEM(Write_register_MEM), 
		.Read_data_MEM(Read_data_MEM), 
		.Read_data_WB(Read_data_WB), 
		.ALU_result_WB(ALU_result_WB), 
		.MemToReg_WB(MemToReg_WB), 
		.RegWrite_WB(RegWrite_WB), 
		.Write_register_WB(Write_register_WB), 
		.forwardA(forwardA), 
		.forwardB(forwardB), 
		.BranchTaken(BranchTaken), 
		.Jump_ID(Jump_ID), 
		.IF_Flush(IF_Flush)
	);




	uart_rx r(
										// Write side inputs
	  .clk_rx(clk),       		// Clock input
	  .rst_clk_rx(1'b0),   		// Active HIGH reset - synchronous to clk_rx
	  .rxd_i(rx),        		// RS232 RXD pin - Directly from pad
	  .rx_data(rx_data),			//comando),      // 8 bit data output
										//  - valid when rx_data_rdy is asserted
	  .rx_data_rdy(rx_data_rdy)// Ready signal for rx_data
										// The STOP bit was not detected
	);

endmodule
