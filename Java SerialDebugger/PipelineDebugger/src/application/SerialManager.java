package application;

import java.nio.*;
import jssc.SerialPort;
import jssc.SerialPortEvent;
import jssc.SerialPortEventListener;
import jssc.SerialPortException;

public class SerialManager {
	private String PC = "    0";
	private static GUI_Debugger gui;
	private static SerialPort serialPort;
	private final String[] ports = { "COM0", "COM1", "COM2", "COM3", "COM4",
			"COM5", "COM6", "COM7", "COM8", "COM9", "COM10", "COM11", "COM12",
			"COM13", "COM14", "COM15", "COM16" };
	private static byte b[];
	private final static String[] registros = { "Reg0:  ", "Reg1:  ",
			"Reg2:  ", "Reg3:  ", "Reg4:  ", "Reg5:  ", "Reg6:  ", "Reg7:  ",
			"Reg8:  ", "Reg9:  ", "Reg10: ", "Reg11: ", "Reg12: ", "Reg13: ",
			"Reg14: ", "Reg15: ", "Reg16: ", "Reg17: ", "Reg18: ", "Reg19: ",
			"Reg20: ", "Reg21: ", "Reg22: ", "Reg23: ", "Reg24: ", "Reg25: ",
			"Reg26: ", "Reg27: ", "Reg28: ", "Reg29: ", "Reg30: ", "Reg31: " };

	/**
	 * @brief Constructor
	 * @param gui
	 */
	public SerialManager(GUI_Debugger gui) {
		this.gui = gui;
	}

	public void setSerialPort(String port) {
		serialPort = new SerialPort(port);
	}

	public SerialPort getSerialPort() {
		return serialPort;
	}

	public String[] getPorts() {
		return ports;
	}

	/**
	 * @brief Funcion que lleva a cabo la comunicacion serie. ESTA ES LA QUE HAY
	 *        QUE MODIFICIAR PARA AGREGAR COSAS
	 */
	public void serialComunication() {
		try {
			// while (true) {
			serialPort.openPort();// Open port
			serialPort.setParams(2400, 8, 1, 0);// Set params
			int mask = SerialPort.MASK_RXCHAR + SerialPort.MASK_CTS
					+ SerialPort.MASK_DSR;// Prepare mask
			serialPort.setEventsMask(mask);// Set mask
			serialPort.writeBytes("A".getBytes());
			serialPort.writeBytes("b".getBytes());
			b = serialPort.readBytes(1);
			println("");
			System.out.println("New read:");
			readAllData();
			serialPort.closePort();
			// }
		} catch (SerialPortException ex) {
			System.out.println(ex);
		}
	}

	// ********************Printing***************************//

	private static void print(String a) {
		System.out.print(a);
		gui.printText(a);
	}

	private static void println(String a) {
		print(a + "\n");
	}

	private static void printBlack(String a) {
		System.out.print(a);
		gui.printBlack(a);
	}

	private static void printGray(String a) {
		System.out.print(a);
		gui.printGray(a);
	}

	private static void readAllData() {
		try {
			// Imprimir el PC
			b = serialPort.readBytes(4);
			System.out.print("PC: ");
			ByteBuffer bb = ByteBuffer.wrap(b);
			bb.order(ByteOrder.LITTLE_ENDIAN);
			int PC = bb.getInt();
			System.out.print(PC + "\n");
			gui.actualizartextPC(PC);

			// Imprimir Instruccion y registros
			b = serialPort.readBytes(4);
			printBlack("Instruccion: ");
			for (int i = 0; i < b.length; i++)
				printGray(b[i] + " ");

			// Imprimir los 32 Registros
			readAndPrintRegisters(bb);

			// Imprimir el contenido del Latch ID
			b = serialPort.readBytes(4);
			printBlack("\n\nInstruccion ID:");
			for (int i = 0; i < b.length; i++)
				printGray(b[i] + " ");

			b = serialPort.readBytes(4);
			printBlack("\nRs: ");
			bb = ByteBuffer.wrap(b);
			bb.order(ByteOrder.LITTLE_ENDIAN);
			printGray(bb.getInt() + " ");

			b = serialPort.readBytes(4);
			printBlack("\nRt: ");
			bb = ByteBuffer.wrap(b);
			bb.order(ByteOrder.LITTLE_ENDIAN);
			printGray(bb.getInt() + " ");

			// Habria que hacer una Funcion "Asco" para estasflags //
			boolean RegDest_ID, BranchEQ_ID, BranchNE_ID, MemRead_ID, MemToReg_ID, ALUOp1_ID, ALUOp2_ID, MemWrite_ID;

			b = serialPort.readBytes(1);
			// print("Flags: ");
			// bb = ByteBuffer.wrap(b);
			// bb.order(ByteOrder.LITTLE_ENDIAN);
			RegDest_ID = (b[0] & 0xFE) != 0;
			BranchEQ_ID = (b[0] & 0xFD) != 0;
			BranchNE_ID = (b[0] & 0xFB) != 0;
			MemRead_ID = (b[0] & 0xF7) != 0;
			MemToReg_ID = (b[0] & 0xEF) != 0;
			ALUOp1_ID = (b[0] & 0xDF) != 0;
			ALUOp2_ID = (b[0] & 0xBF) != 0;
			MemWrite_ID = (b[0] & 0x7F) != 0;
			println("RegDest_ID: " + RegDest_ID + " BranchEQ_ID: "
					+ BranchEQ_ID + " BranchNE_ID: " + BranchNE_ID
					+ " MemRead_ID: " + MemRead_ID + " MemToReg_ID: "
					+ MemToReg_ID + " ALUOp1_ID: " + ALUOp1_ID + " ALUOp2_ID: "
					+ ALUOp2_ID + " MemWrite_ID: " + MemWrite_ID);
			// print(""+RegDest_ID+BranchEQ_ID+BranchNE_ID+MemRead_ID+MemToReg_ID+ALUOp1_ID+ALUOp2_ID+MemWrite_ID);
			println("");

			boolean ALUSrc_ID, RegWrite_ID, ShiftToTrunk_ID, RegDest_EX, BranchEQ_EX, BranchNE_EX, MemRead_EX, MemToReg_EX;

			b = serialPort.readBytes(1);
			// print("Flags: ");
			// bb = ByteBuffer.wrap(b);
			// bb.order(ByteOrder.LITTLE_ENDIAN);
			ALUSrc_ID = (b[0] & 0xFE) != 0;
			RegWrite_ID = (b[0] & 0xFD) != 0;
			ShiftToTrunk_ID = (b[0] & 0xFB) != 0;
			RegDest_EX = (b[0] & 0xF7) != 0;
			BranchEQ_EX = (b[0] & 0xEF) != 0;
			BranchNE_EX = (b[0] & 0xDF) != 0;
			MemRead_EX = (b[0] & 0xBF) != 0;
			MemToReg_EX = (b[0] & 0x7F) != 0;
			println("ALUSrc_ID: " + ALUSrc_ID + " RegWrite_ID: " + RegWrite_ID
					+ " ShiftToTrunk_ID: " + ShiftToTrunk_ID + " RegDest_EX: "
					+ RegDest_EX + " BranchEQ_EX: " + BranchEQ_EX
					+ " BranchNE_EX: " + BranchNE_EX + " MemRead_EX: "
					+ MemRead_EX + " MemToReg_EX: " + MemToReg_EX);
			// print(""+RegDest_ID+BranchEQ_ID+BranchNE_ID+MemRead_ID+MemToReg_ID+ALUOp1_ID+ALUOp2_ID+MemWrite_ID);
			println("");

			boolean trunkMode_ID1, trunkMode_ID2, MemWrite_EX, ALUSrc_EX, RegWrite_EX, Jump_EX, trunkMode_EX1, trunkMode_EX2;

			b = serialPort.readBytes(1);
			// print("Flags: ");
			// bb = ByteBuffer.wrap(b);
			// bb.order(ByteOrder.LITTLE_ENDIAN);
			trunkMode_ID1 = (b[0] & 0xFE) != 0;
			trunkMode_ID2 = (b[0] & 0xFD) != 0;
			MemWrite_EX = (b[0] & 0xFB) != 0;
			ALUSrc_EX = (b[0] & 0xF7) != 0;
			RegWrite_EX = (b[0] & 0xEF) != 0;
			Jump_EX = (b[0] & 0xDF) != 0;
			trunkMode_EX1 = (b[0] & 0xBF) != 0;
			trunkMode_EX2 = (b[0] & 0x7F) != 0;
			println("trunkMode_ID1: " + trunkMode_ID1 + " trunkMode_ID2: "
					+ trunkMode_ID2 + " MemWrite_EX: " + MemWrite_EX
					+ " ALUSrc_EX: " + ALUSrc_EX + " RegWrite_EX: "
					+ RegWrite_EX + " Jump_EX: " + Jump_EX + " trunkMode_EX1: "
					+ trunkMode_EX1 + " trunkMode_EX2: " + trunkMode_EX2);
			// print(""+RegDest_ID+BranchEQ_ID+BranchNE_ID+MemRead_ID+MemToReg_ID+ALUOp1_ID+ALUOp2_ID+MemWrite_ID);

			b = serialPort.readBytes(4);
			printBlack("\nPC sumado Ex: ");
			bb = ByteBuffer.wrap(b);
			bb.order(ByteOrder.LITTLE_ENDIAN);
			printGray(bb.getInt() + " ");

			b = serialPort.readBytes(4);
			printBlack("\nRead data ex 1: ");
			bb = ByteBuffer.wrap(b);
			bb.order(ByteOrder.LITTLE_ENDIAN);
			printGray(bb.getInt() + " ");

			b = serialPort.readBytes(4);
			printBlack("Read data ex 2: ");
			bb = ByteBuffer.wrap(b);
			bb.order(ByteOrder.LITTLE_ENDIAN);
			printGray(bb.getInt() + " ");

			b = serialPort.readBytes(4);
			printBlack("Instruction Ex: ");
			bb = ByteBuffer.wrap(b);
			bb.order(ByteOrder.LITTLE_ENDIAN);
			printGray(bb.getInt() + " ");

			boolean ShiftToTrunk_EX, Zero_EX, BranchEQ_MEM, BranchNE_MEM, MemRead_MEM, MemToReg_MEM, MemWrite_MEM, RegWrite_MEM;
			b = serialPort.readBytes(1);
			// print("Flags: ");
			// bb = ByteBuffer.wrap(b);
			// bb.order(ByteOrder.LITTLE_ENDIAN);
			ShiftToTrunk_EX = (b[0] & 0xFE) != 0;
			Zero_EX = (b[0] & 0xFD) != 0;
			BranchEQ_MEM = (b[0] & 0xFB) != 0;
			BranchNE_MEM = (b[0] & 0xF7) != 0;
			MemRead_MEM = (b[0] & 0xEF) != 0;
			MemToReg_MEM = (b[0] & 0xDF) != 0;
			MemWrite_MEM = (b[0] & 0xBF) != 0;
			RegWrite_MEM = (b[0] & 0x7F) != 0;
			println("ShiftToTrunk_EX: " + ShiftToTrunk_EX + " Zero_EX: "
					+ Zero_EX + " BranchEQ_MEM: " + BranchEQ_MEM
					+ " BranchNE_MEM: " + BranchNE_MEM + " MemRead_MEM: "
					+ MemRead_MEM + " MemToReg_MEM: " + MemToReg_MEM
					+ " MemWrite_MEM: " + MemWrite_MEM + " RegWrite_MEM: "
					+ RegWrite_MEM);
			// print(""+RegDest_ID+BranchEQ_ID+BranchNE_ID+MemRead_ID+MemToReg_ID+ALUOp1_ID+ALUOp2_ID+MemWrite_ID);
			println("");

			// b=serialPort.readBytes(1);
		} catch (SerialPortException e) {
			e.printStackTrace();
		}

	}

	/*
	 * @brief Funion que imprime los 32 Registros
	 */
	private static void readAndPrintRegisters(ByteBuffer bb) {
		try {
			for (int i = 0; i < 32; i++) {
				b = serialPort.readBytes(4);
				printBlack("\n" + registros[i]);
				bb = ByteBuffer.wrap(b);
				bb.order(ByteOrder.LITTLE_ENDIAN);
				printGray(bb.getInt() + " ");
			}
		} catch (SerialPortException e) {
			System.err.println("Serial Port Exception");
		}
	}

	/*
	 * In this class must implement the method serialEvent, through it we learn
	 * about events that happened to our port. But we will not report on all
	 * events but only those that we put in the mask. In this case the arrival
	 * of the data and change the status lines CTS and DSR
	 */
	static class SerialPortReader implements SerialPortEventListener {

		public void serialEvent(SerialPortEvent event) {
			if (event.isRXCHAR()) {// If data is available

				try {
					byte[] b = serialPort.readBytes(4);
					for (int i = 0; i < b.length; i++)
						System.out.println(b[i]);
					// System.out.println(event.getEventValue());
					serialPort.writeBytes("b".getBytes());
					serialPort.writeBytes("A".getBytes());
				} catch (SerialPortException ex) {
					System.out.println(ex);
				}
			}
		}

	}

}
