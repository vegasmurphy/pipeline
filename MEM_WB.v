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
	 output reg [31:0] Read_data_WB,
    output reg [31:0] ALU_result_WB,
	 output reg MemToReg_WB,
    output reg RegWrite_WB,
	 output reg [4:0] Write_register_WB
	 );
always @(posedge clk)
begin
	Read_data_WB<=Read_data_MEM;
	ALU_result_WB<=ALU_result_MEM;
	MemToReg_WB<=MemToReg_MEM;
   RegWrite_WB<=RegWrite_MEM;
end

endmodule
