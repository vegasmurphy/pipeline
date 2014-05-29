`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:28:05 03/31/2014 
// Design Name: 
// Module Name:    MEM_WB 
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
module MEM_WB(
	 input clk,
    input [31:0] Read_data_MEM,
    input [31:0] ALU_result_MEM,
    input RegWrite_MEM,
	 input MemToReg_MEM,
	 input [4:0] Write_register_MEM,
	 input [31:0] PC_sumado_MEM,
	 input savePc_MEM,
	 output reg savePc_WB,
	 output reg [31:0] PC_sumado_WB,
	 output reg [31:0] Read_data_WB,
    output reg [31:0] ALU_result_WB,
	 output reg MemToReg_WB,
    output reg RegWrite_WB,
	 output reg [4:0] Write_register_WB
	 );
initial
	begin
	Read_data_WB=0;
	ALU_result_WB=0;
	MemToReg_WB=0;
	RegWrite_WB=0;
	Write_register_WB=0;
	PC_sumado_WB=0;
	savePc_WB=0;
	end


always @(posedge clk)
begin
	Read_data_WB<=Read_data_MEM;
	ALU_result_WB<=ALU_result_MEM;
	MemToReg_WB<=MemToReg_MEM;
   RegWrite_WB<=RegWrite_MEM;
	Write_register_WB[4:0]<=Write_register_MEM[4:0];
	PC_sumado_WB<=PC_sumado_MEM;
	savePc_WB<=savePc_MEM;
end

endmodule
