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
    input clk,
	 input rx,
	 output tx_out
	 
    );
	 
wire done;
wire [7:0] palabra,rx_data;
wire rd_en,wr_en;
wire tx_done;
wire fifo_empty;
wire rx_data_rdy;
reg ready;

uart_tx tx(
  .clk_tx(clk),          // Clock input
  .rst_clk_tx(1'b0),      // Active HIGH reset - synchronous to clk_tx
  .char_fifo_empty(fifo_empty), // Empty signal from char FIFO (FWFT)
  .char_fifo_dout(palabra),  // Data from the char FIFO
  .char_fifo_rd_en(tx_done), // Pop signal to the char FIFO
	.txd_tx(tx_out)           // The transmit serial signal
);
reg fifo_wr_en;
reg fifo_din;
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
	wire [31:0] PC_sumado_IF;
	wire [31:0] instruction_ID;
	wire [31:0] Read_Data_1_ID;
	wire [31:0] Read_Data_2_ID;
	wire [31:0] signExtended_ID;
	wire [31:0] PC_sumado_ID;
	wire RegDest_ID;
	wire Branch_ID;
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
	wire Branch_EX;
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
	wire Branch_MEM;
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

	// Instantiate the Unit Under Test (UUT)
	Pipeline uut (
		.clk(clkPipeline), 
		.aluInstruction(aluInstruction), 
		.equalFlag(equalFlag), 
		.instruction_IF(instruction_IF), 
		.PC_sumado_IF(PC_sumado_IF), 
		.instruction_ID(instruction_ID), 
		.Read_Data_1_ID(Read_Data_1_ID), 
		.Read_Data_2_ID(Read_Data_2_ID), 
		.signExtended_ID(signExtended_ID), 
		.PC_sumado_ID(PC_sumado_ID), 
		.RegDest_ID(RegDest_ID), 
		.Branch_ID(Branch_ID), 
		.MemRead_ID(MemRead_ID), 
		.MemToReg_ID(MemToReg_ID), 
		.ALUOp1_ID(ALUOp1_ID), 
		.ALUOp2_ID(ALUOp2_ID), 
		.MemWrite_ID(MemWrite_ID), 
		.ALUSrc_ID(ALUSrc_ID), 
		.RegWrite_ID(RegWrite_ID), 
		.PC_sumado_EX(PC_sumado_EX), 
		.Read_Data_1_EX(Read_Data_1_EX), 
		.Read_Data_2_EX(Read_Data_2_EX), 
		.aluInput1(aluInput1), 
		.aluInput2(aluInput2), 
		.signExtended_EX(signExtended_EX), 
		.instruction_EX(instruction_EX), 
		.RegDest_EX(RegDest_EX), 
		.Branch_EX(Branch_EX), 
		.MemRead_EX(MemRead_EX), 
		.MemToReg_EX(MemToReg_EX), 
		.ALUOp1_EX(ALUOp1_EX), 
		.ALUOp2_EX(ALUOp2_EX), 
		.MemWrite_EX(MemWrite_EX), 
		.ALUSrc_EX(ALUSrc_EX), 
		.RegWrite_EX(RegWrite_EX), 
		.Jump_EX(Jump_EX), 
		.PC_next_ID(PC_next_ID), 
		.ALU_result_EX(ALU_result_EX), 
		.ALU_result_MEM(ALU_result_MEM), 
		.Read_Data_2_MEM(Read_Data_2_MEM), 
		.Zero_EX(Zero_EX), 
		.Write_register_EX(Write_register_EX), 
		.Branch_MEM(Branch_MEM), 
		.MemRead_MEM(MemRead_MEM), 
		.MemToReg_MEM(MemToReg_MEM), 
		.MemWrite_MEM(MemWrite_MEM), 
		.RegWrite_MEM(RegWrite_MEM), 
		.Jump_MEM(Jump_MEM), 
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


reg [7:0] comando;
uart_rx r(
  // Write side inputs
  .clk_rx(clk),       // Clock input
  .rst_clk_rx(0),   // Active HIGH reset - synchronous to clk_rx
  .rxd_i(rx),        // RS232 RXD pin - Directly from pad
  .rx_data(comando),      // 8 bit data output
                                 //  - valid when rx_data_rdy is asserted
  .rx_data_rdy(rx_data_rdy)  // Ready signal for rx_data
        // The STOP bit was not detected
);



always @(rx_data_rdy)
begin
	if(comando=="s")
		begin
			fifo_wr_en=1;
			fifo_din="a";
		end
end
always @(posedge clk)
begin
	fifo_wr_en=0;
end
endmodule
