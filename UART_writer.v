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
	wire [31:0]instruction;
	reg clkPipe = 0;
	wire [31:0] reg_array0,reg_array1,reg_array2,reg_array3,reg_array4,reg_array5,reg_array6,reg_array7,reg_array8,reg_array9;
	wire [31:0] reg_array10,reg_array11,reg_array12,reg_array13,reg_array14,reg_array15,reg_array16,reg_array17,reg_array18,reg_array19;
	wire [31:0] reg_array20,reg_array21,reg_array22,reg_array23,reg_array24,reg_array25,reg_array26,reg_array27,reg_array28,reg_array29;
	wire [31:0] reg_array30,reg_array31;
	Pipeline pipe
		(	.clk(clkPipe),
			.PC_sumado_IF(PC_sumado_IF),
			.instruction_IF(instruction),
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
			.reg_array31(reg_array31)
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
	localparam [1:0] 	WAITING 	= 2'b00,
							SENDING 	= 2'b01,
							DONE 		= 2'b10;
	
	//Declaración de señales
	reg[2:0] current_state=WAITING, next_state=WAITING;
	reg [7:0] currentRegister=8'b00000001;
	
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
				end
			SENDING:
				begin
					clkPipe=0;
					fifo_wr_en=1;
					case(currentRegister)
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
						//Registros (ID)
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
						/*//Registro Trece
						8'b00011100:fifo_din <= reg_array[7:0];
						8'b00011100:fifo_din <= reg_array[15:8];
						8'b00011100:fifo_din <= reg_array[23:16];
						8'b00011100:fifo_din <= reg_array[31:24];
						//Registro
						8'b00011100:fifo_din <= reg_array[7:0];
						8'b00011100:fifo_din <= reg_array[15:8];
						8'b00011100:fifo_din <= reg_array[23:16];
						8'b00011100:fifo_din <= reg_array[31:24];
						//Registro
						8'b00011100:fifo_din <= reg_array[7:0];
						8'b00011100:fifo_din <= reg_array[15:8];
						8'b00011100:fifo_din <= reg_array[23:16];
						8'b00011100:fifo_din <= reg_array[31:24];
						//Registro
						8'b00011100:fifo_din <= reg_array[7:0];
						8'b00011100:fifo_din <= reg_array[15:8];
						8'b00011100:fifo_din <= reg_array[23:16];
						8'b00011100:fifo_din <= reg_array[31:24];
						//Registro
						8'b00011100:fifo_din <= reg_array[7:0];
						8'b00011100:fifo_din <= reg_array[15:8];
						8'b00011100:fifo_din <= reg_array[23:16];
						8'b00011100:fifo_din <= reg_array[31:24];
						//Registro
						8'b00011100:fifo_din <= reg_array[7:0];
						8'b00011100:fifo_din <= reg_array[15:8];
						8'b00011100:fifo_din <= reg_array[23:16];
						8'b00011100:fifo_din <= reg_array[31:24];
						//Registro
						8'b00011100:fifo_din <= reg_array[7:0];
						8'b00011100:fifo_din <= reg_array[15:8];
						8'b00011100:fifo_din <= reg_array[23:16];
						8'b00011100:fifo_din <= reg_array[31:24];
						//Registro
						8'b00011100:fifo_din <= reg_array[7:0];
						8'b00011100:fifo_din <= reg_array[15:8];
						8'b00011100:fifo_din <= reg_array[23:16];
						8'b00011100:fifo_din <= reg_array[31:24];
						//Registro
						8'b00011100:fifo_din <= reg_array[7:0];
						8'b00011100:fifo_din <= reg_array[15:8];
						8'b00011100:fifo_din <= reg_array[23:16];
						8'b00011100:fifo_din <= reg_array[31:24];
						//Registro
						8'b00011100:fifo_din <= reg_array[7:0];
						8'b00011100:fifo_din <= reg_array[15:8];
						8'b00011100:fifo_din <= reg_array[23:16];
						8'b00011100:fifo_din <= reg_array[31:24];
						//Registro
						8'b00011100:fifo_din <= reg_array[7:0];
						8'b00011100:fifo_din <= reg_array[15:8];
						8'b00011100:fifo_din <= reg_array[23:16];
						8'b00011100:fifo_din <= reg_array[31:24];
						//Registro
						8'b00011100:fifo_din <= reg_array[7:0];
						8'b00011100:fifo_din <= reg_array[15:8];
						8'b00011100:fifo_din <= reg_array[23:16];
						8'b00011100:fifo_din <= reg_array[31:24];
						//Registro
						8'b00011100:fifo_din <= reg_array[7:0];
						8'b00011100:fifo_din <= reg_array[15:8];
						8'b00011100:fifo_din <= reg_array[23:16];
						8'b00011100:fifo_din <= reg_array[31:24];
						//Registro
						8'b00011100:fifo_din <= reg_array[7:0];
						8'b00011100:fifo_din <= reg_array[15:8];
						8'b00011100:fifo_din <= reg_array[23:16];
						8'b00011100:fifo_din <= reg_array[31:24];
						//Registro
						8'b00011100:fifo_din <= reg_array[7:0];
						8'b00011100:fifo_din <= reg_array[15:8];
						8'b00011100:fifo_din <= reg_array[23:16];
						8'b00011100:fifo_din <= reg_array[31:24];
						//Registro
						8'b00011100:fifo_din <= reg_array[7:0];
						8'b00011100:fifo_din <= reg_array[15:8];
						8'b00011100:fifo_din <= reg_array[23:16];
						8'b00011100:fifo_din <= reg_array[31:24];
						//Registro
						8'b00011100:fifo_din <= reg_array[7:0];
						8'b00011100:fifo_din <= reg_array[15:8];
						8'b00011100:fifo_din <= reg_array[23:16];
						8'b00011100:fifo_din <= reg_array[31:24];
						//Registro
						8'b00011100:fifo_din <= reg_array[7:0];
						8'b00011100:fifo_din <= reg_array[15:8];
						8'b00011100:fifo_din <= reg_array[23:16];
						8'b00011100:fifo_din <= reg_array[31:24];
						//Registro
						8'b00011100:fifo_din <= reg_array[7:0];
						8'b00011100:fifo_din <= reg_array[15:8];
						8'b00011100:fifo_din <= reg_array[23:16];
						8'b00011100:fifo_din <= reg_array[31:24];*/
						//Default
						default:fifo_din <= PC_sumado_IF[7:0];
					endcase
					currentRegister=currentRegister+1;
					if(currentRegister==8'b00111110)//Ultimo valor +2
						begin
							currentRegister=8'b00000001;
							fifo_wr_en=0;
							next_state=DONE;
						end
				end
			DONE:
				begin
					if(rx_data!="A")
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
