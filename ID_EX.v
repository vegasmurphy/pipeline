`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:11:40 03/31/2014 
// Design Name: 
// Module Name:    ID_EX 
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
module ID_EX(
    input clk,
    input [31:0] Read_Data_1_ID,
    input [31:0] Read_Data_2_ID,
    input [31:0] signExtended_ID,
	 input [31:0] PC_sumado_ID,
	 output [31:0] PC_sumado_EX,
    output [31:0] Read_Data_1_EX,
    output [31:0] Read_Data_2_EX,
    output [31:0] signExtended_EX
    );
always @(posedge clk)
begin
	Read_Data_1_ID=Read_Data_1_EX;
	Read_Data_2_ID=Read_Data_2_EX;
	signExtended_ID=signExtended_EX;
	PC_sumado_ID=PC_sumado_EX;
end

endmodule
