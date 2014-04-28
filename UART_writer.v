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


fifo f(
  .clk(clk),
  .rst(1'b0),
  .din(rx_data),
  .wr_en(rx_data_rdy),
  .rd_en(tx_done),
  .dout(palabra),
  .full(fifo_full),
  .empty(fifo_empty)
);


uart_rx r(
  // Write side inputs
  .clk_rx(clk),       // Clock input
  .rst_clk_rx(0),   // Active HIGH reset - synchronous to clk_rx
  .rxd_i(rx),        // RS232 RXD pin - Directly from pad
  .rx_data(rx_data),      // 8 bit data output
                                 //  - valid when rx_data_rdy is asserted
  .rx_data_rdy(rx_data_rdy)  // Ready signal for rx_data
        // The STOP bit was not detected
);

endmodule
