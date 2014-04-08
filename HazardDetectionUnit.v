`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:06:11 04/08/2014 
// Design Name: 
// Module Name:    HazardDetectionUnit 
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
module HazardDetectionUnit(
	input MemRead_EX,
	input [4:0] RegisterRt_EX,
	input [4:0] RegisterRs_ID,
	input [4:0] RegisterRt_ID,
	output reg IF_ID_write,		//if ==0 ID/IF stalls
	output reg PC_write,			//if ==0 PC stalls
	output reg nopMux				//if ==1 nop

    );


	always @(*)
	begin
		if(MemRead_EX &&
		((RegisterRt_EX == RegisterRs_ID) ||
		(RegisterRt_EX == RegisterRt_ID)))
			begin //stop clock
				PC_write<=0;
				IF_ID_write<=0;
				nopMux<=1;
			end
		else 
			begin //go on
				PC_write<=1;
				IF_ID_write<=1;
				nopMux<=0;
			end
	end



endmodule
