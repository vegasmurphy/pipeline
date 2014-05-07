`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:59:02 05/05/2014 
// Design Name: 
// Module Name:    TrunkUnit 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: Unidad utilizada para truncar los bits que se escriben o
//								leen usando LB, LH, LW o SB, SH, SW
//
//////////////////////////////////////////////////////////////////////////////////
module TrunkUnit(
	input	[1:0] opcode,
	input signed [31:0] entrada,
	input [1:0] direccion,
	output reg [31:0] salida
    );


	reg [1:0] byteNumber=0;
	reg halfNumber=0;
	always @*
	begin
		byteNumber=direccion[1:0];
		halfNumber=direccion[1];
		case(opcode)
			2'b00://LW & SW
				begin//Load Word & Store Word
					salida <= entrada;
				end
			2'b01://LH & SH
				begin
					//Load Half & Store Half
					salida <= (entrada >> (16*halfNumber)) & 32'b00000000000000001111111111111111;
				end
			2'b10://LB & SB
				begin
					//Load Byte & Store Byte
					salida <= (entrada >> (8*byteNumber)) & 32'b00000000000000000000000011111111;
				end
			default://LW & SW
				begin
					salida <= entrada;
				end
		endcase
	end
endmodule
