`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   16:04:29 03/19/2014
// Design Name:   Pipeline
// Module Name:   C:/Users/vegas/Desktop/Arquitectura/pipeline/pipelineTest.v
// Project Name:  ArquitecturaPIPELINE
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Pipeline
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module pipelineTest;

	// Inputs
	reg clk;

	// Outputs
	wire [31:0] resultadoALU;
	wire [31:0] Instruction;
	wire [31:0] writeData;
	wire [31:0] rsData;
	wire [31:0] rtData;
	wire carryALU;
	wire zeroALU;
	wire RegDest;
	wire Branch;
	wire MemRead;
	wire MemToReg;
	wire ALUOp1;
	wire ALUOp2;
	wire MemWrite;
	wire ALUSrc;
	wire RegWrite;
	wire [31:0] dataMemoryReadData;
	wire Jump;
	wire branchAndZero_flag;
	wire [3:0]aluInstruction;
	// Instantiate the Unit Under Test (UUT)
	Pipeline uut (
		.clk(clk), 
		.resultadoALU(resultadoALU), 
		.Instruction(Instruction),  
		.writeData(writeData), 
		.rsData(rsData), 
		.rtData(rtData), 
		.carryALU(carryALU), 
		.zeroALU(zeroALU), 
		.RegDest(RegDest), 
		.Branch(Branch), 
		.MemRead(MemRead), 
		.MemToReg(MemToReg), 
		.ALUOp1(ALUOp1), 
		.ALUOp2(ALUOp2), 
		.MemWrite(MemWrite), 
		.ALUSrc(ALUSrc), 
		.RegWrite(RegWrite), 
		.dataMemoryReadData(dataMemoryReadData), 
		.Jump(Jump), 
		.branchAndZero_flag(branchAndZero_flag),
		.aluInstruction(aluInstruction)
	);
	always #100 clk=~clk;
	initial begin
		// Initialize Inputs
		clk = 0;

		// Wait 100 ns for global reset to finish
		#100;
       
		// Add stimulus here

	end
      
endmodule

