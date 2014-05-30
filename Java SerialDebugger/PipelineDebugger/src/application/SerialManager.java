package application;

import java.nio.*;
import java.util.ArrayList;

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
	private final static String[] registros = { "Reg0:   ", "Reg1:   ",
			"Reg2:   ", "Reg3:   ", "Reg4:   ", "Reg5:   ", "Reg6:   ",
			"Reg7:   ", "Reg8:   ", "Reg9:   ", "Reg10: ", "Reg11: ",
			"Reg12: ", "Reg13: ", "Reg14: ", "Reg15: ", "Reg16: ", "Reg17: ",
			"Reg18: ", "Reg19: ", "Reg20: ", "Reg21: ", "Reg22: ", "Reg23: ",
			"Reg24: ", "Reg25: ", "Reg26: ", "Reg27: ", "Reg28: ", "Reg29: ",
			"Reg30: ", "Reg31: " };
	private static ArrayList<Flag> flagsID;
	private static ArrayList<Flag> flagsEX;
	private static ArrayList<Flag> flagsMEM;
	private static ArrayList<Flag> flagsWB;
	private static ArrayList<Flag> flagsIF;
	private static ArrayList<Flag> InstruccionesYRegistros;

	/**
	 * @brief Constructor
	 * @param gui
	 */
	public SerialManager(GUI_Debugger gui) {
		this.gui = gui;
		inicializarFLags();
		inicializarInstruccionesYRegistros();
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
			serialPort.writeBytes("o".getBytes());
			b = serialPort.readBytes(1);
			printOrange("\n\nNueva Lectura:\n---------------------------------------------------------------------------------------------"
					+ "-----------------------------------------------------------------------------------------------------------------\n");
			readAllData();
			serialPort.closePort();
			// }
		} catch (SerialPortException ex) {
			System.out.println(ex);
		}
	}
	
	
	public void serialMemory() {
		try {
	
			serialPort.openPort();// Open port
			serialPort.setParams(2400, 8, 1, 0);// Set params
			int mask = SerialPort.MASK_RXCHAR + SerialPort.MASK_CTS
					+ SerialPort.MASK_DSR;// Prepare mask
			serialPort.setEventsMask(mask);// Set mask
			serialPort.writeBytes("B".getBytes());
			serialPort.writeBytes("v".getBytes());
			//b = serialPort.readBytes(1);
			printOrange("\n\nDatos de la RAM:");
			readRAM();
			serialPort.closePort();
			// }
		} catch (SerialPortException ex) {
			System.out.println(ex);
		}
	}
	
	
	

	// ***********************************Printing************************************************//

	private static void print(String a) {
		System.out.print(a);
		gui.printText(a);
	}

	private static void printBlack(String a) {
		System.out.print(a);
		gui.printBlack(a);
	}

	private static void printGray(String a) {
		System.out.print(a);
		gui.printGray(a);
	}

	private static void printOrange(String a) {
		System.out.print(a);
		gui.printOrange(a);
	}
	
	private static void printFlag(boolean flag){
		if(flag){
			gui.printBlue("\t"+flag);}
		else{gui.printRed("\t"+flag);}
		System.out.println("\t"+flag);
	}
	

	private static void readAllData() {
		ByteBuffer bb = null;

		// Imprimir el PC
		readAndUpdateProgramCounter(bb);

		// Imprimir Instruccion y registros
		readAndPrintInstruction("\nInstruccion(IF): ");

		// Imprimir los 32 Registros
		readAndPrintRegisters(bb);

		// Imprimir el contenido del Latch ID
		readAndPrintInstruction("\n\nInstruccion(ID): ");

		readAndPrintValue("\tReg-s: ", bb);
		readAndPrintValue("\t\tReg-t: ", bb);

		// Print Flags ID
		readAndSaveIDEXFlags(bb);

		// Print Etapa EX
		readAndPrintValue("\n\nPC sumado (EX): ", bb);
		readAndPrintValue("\t\tRead_Data_1 (EX): ", bb);
		readAndPrintValue("\tRead_Data_2 (EX): ", bb);
		readAndPrintInstruction("\nInstruction(EX):   ");

		readAndPrintValue("\tALU_Result (EX):    ", bb);
		readAndPrintValue("\tALU_Result (MEM): ", bb);

		//Print Flags EX/MEM
		readAndPrintEXFlags(bb);
		readAndPrintMEMFlags(bb);

		readAndPrintValue("\nRead_Data (MEM): ", bb);
		readAndPrintValue("\tRead_Data (WB): ", bb);
		readAndPrintValue("\tALU_Result (WB): ", bb);
		readAndPrintValue("\tRead_Data_2 (MEM)",bb);
		
		readAndSaveJALFlags();
		printAllFlags();
	}

	/*
	 * @brief Funion que imprime los 32 Registros
	 */
	private static void readAndPrintRegisters(ByteBuffer bb) {
		try {
			for (int i = 0; i < 32; i++) {
				b = serialPort.readBytes(4);
				if (i % 5 == 0) {
					printBlack("\n");
				} else {
					printBlack("\t");
				}
				printBlack(registros[i]);
				bb = ByteBuffer.wrap(b);
				bb.order(ByteOrder.LITTLE_ENDIAN);
				printGray(bb.getInt() + " ");
			}
		} catch (SerialPortException e) {
			System.err.println("Serial Port Exception");
		}
	}

	/**
	 * @brief Funcion que imprime <nombreDato>: <Valor leido por UART>
	 * @param nombre
	 * @param bb
	 */
	private static void readAndPrintValue(String nombre, ByteBuffer bb) {
		try {

			b = serialPort.readBytes(4);
			printBlack(nombre);
			bb = ByteBuffer.wrap(b);
			bb.order(ByteOrder.LITTLE_ENDIAN);
			printGray(bb.getInt() + " ");

		} catch (SerialPortException e) {
			System.err.println("Serial Port Exception");
		}
	}

	/**
	 * @brief Funcion que imprime <nombreDeInstruccion>: <Valor leido por UART>
	 * @param nombre
	 * @param bb
	 */
	private static void readAndPrintInstruction(String nombre) {
		try {
			b = serialPort.readBytes(4);
			byte[] b2=new byte[4];
			printBlack(nombre);
			for (int i = 0; i < b.length; i++){
				b2[3-i]=b[i];
				//printGray(b[b.length-i-1] + " ");
				}
			printGray(bytArrayToHex(b2));
		} catch (SerialPortException e) {
			System.err.println("Serial Port Exception");
		}
	}
	
	private static String bytArrayToHex(byte[] a) {
		   StringBuilder sb = new StringBuilder();
		   for(byte b: a)
		      sb.append(String.format("%02x", b&0xff));
		   return sb.toString();
		}


	/**
	 * @brief Funcion que actualiza el PC
	 */
	private static void readAndUpdateProgramCounter(ByteBuffer bb) {
		try {
			b = serialPort.readBytes(4);
			bb = ByteBuffer.wrap(b);
			System.out.print("PC: ");
			bb.order(ByteOrder.LITTLE_ENDIAN);
			int PC = bb.getInt();
			printBlack("PC: ");
			printGray(PC + "");
			gui.actualizartextPC(PC);
		} catch (SerialPortException e) {
			System.err.println("Serial Port Exception");
		}

	}

	/**
	 * @brief Funcion ASCO!!
	 */
	private static void readAndSaveIDEXFlags(ByteBuffer bb) {
		// Habria que hacer una Funcion "Asco" para estasflags //
		try {
			boolean RegDest_ID, BranchEQ_ID, BranchNE_ID, MemRead_ID, MemToReg_ID, ALUOp1_ID, ALUOp2_ID, MemWrite_ID;
			b = serialPort.readBytes(1);
			RegDest_ID = (b[0] & 0x80) != 0;
			BranchEQ_ID = (b[0] & 0x40) != 0;
			BranchNE_ID = (b[0] & 0x20) != 0;
			MemRead_ID = (b[0] & 0x10) != 0;
			MemToReg_ID = (b[0] & 0x08) != 0;
			ALUOp1_ID = (b[0] & 0x04) != 0;
			ALUOp2_ID = (b[0] & 0x02) != 0;
			MemWrite_ID = (b[0] & 0x01) != 0;
			flagsID.get(0).setEstado(RegDest_ID);
			flagsID.get(1).setEstado(MemRead_ID);
			flagsID.get(2).setEstado(MemToReg_ID);
			flagsID.get(3).setEstado(ALUOp1_ID);
			flagsID.get(4).setEstado(ALUOp2_ID);
			flagsID.get(5).setEstado(MemWrite_ID);
			/*printBlack("\nRegDest (ID): ");printFlag(RegDest_ID);
			//printBlack("\tBranchEQ (ID): ");printFlag(BranchEQ_ID);
			//printBlack("\nBranchNE (ID): ");printFlag(BranchNE_ID);
			printBlack("\tMemRead (ID): ");printFlag(MemRead_ID);
			printBlack("\nMemToReg (ID): ");printFlag(MemToReg_ID);
			printBlack("\tALUOp1 (ID): ");printFlag(ALUOp1_ID);
			printBlack("\nALUOp2 (ID): ");printFlag(ALUOp2_ID);
			printBlack("\tMemWrite (ID): ");printFlag(MemWrite_ID);*/

			boolean ALUSrc_ID, RegWrite_ID, ShiftToTrunk_ID, RegDest_EX, BranchEQ_EX, BranchNE_EX, MemRead_EX, MemToReg_EX;
			b = serialPort.readBytes(1);
			ALUSrc_ID = (b[0] & 0x80) != 0;
			RegWrite_ID = (b[0] & 0x40) != 0;
			ShiftToTrunk_ID = (b[0] & 0x20) != 0;
			RegDest_EX = (b[0] & 0x10) != 0;
			BranchEQ_EX = (b[0] & 0x08) != 0;
			BranchNE_EX = (b[0] & 0x04) != 0;
			MemRead_EX = (b[0] & 0x02) != 0;
			MemToReg_EX = (b[0] & 0x01) != 0;
			flagsID.get(6).setEstado(ALUSrc_ID);
			flagsID.get(7).setEstado(RegWrite_ID);
			flagsID.get(8).setEstado(ShiftToTrunk_ID);
			flagsEX.get(0).setEstado(RegDest_EX);
			flagsEX.get(1).setEstado(MemRead_EX);
			flagsEX.get(2).setEstado(MemToReg_EX);
			/*printBlack("\nALUSrc (ID): \t");printFlag(ALUSrc_ID);
			printBlack("\tRegWrite (ID): ");printFlag(RegWrite_ID);
			printBlack("\nShiftToTrunk (ID): ");printFlag(ShiftToTrunk_ID);
			printBlack("\tRegDest (EX): ");printFlag(RegDest_EX);
			//printBlack("\nBranchEQ (EX): ");printFlag(BranchEQ_EX);
			//printBlack("\tBranchNE (EX): ");printFlag(BranchNE_EX);
			printBlack("\nMemRead (EX): ");printFlag(MemRead_EX);
			printBlack("\tMemToReg (EX): ");printFlag(MemToReg_EX);*/

			boolean trunkMode_ID1, trunkMode_ID2, MemWrite_EX, ALUSrc_EX, RegWrite_EX, Jump_EX, trunkMode_EX1, trunkMode_EX2;
			b = serialPort.readBytes(1);
			trunkMode_ID1 = (b[0] & 0x80) != 0;
			trunkMode_ID2 = (b[0] & 0x40) != 0;
			MemWrite_EX = (b[0] & 0x20) != 0;
			ALUSrc_EX = (b[0] & 0x10) != 0;
			RegWrite_EX = (b[0] & 0x08) != 0;
			Jump_EX = (b[0] & 0x04) != 0;
			trunkMode_EX1 = (b[0] & 0x02) != 0;
			trunkMode_EX2 = (b[0] & 0x01) != 0;
			flagsID.get(9).setEstado(trunkMode_ID1);
			flagsID.get(10).setEstado(trunkMode_ID2);
			flagsEX.get(3).setEstado(MemWrite_EX);
			flagsEX.get(4).setEstado(ALUSrc_EX);
			flagsEX.get(5).setEstado(RegWrite_EX);
			flagsEX.get(6).setEstado(Jump_EX);
			flagsEX.get(7).setEstado(trunkMode_EX1);
			flagsEX.get(8).setEstado(trunkMode_EX2);
			/*printBlack("\nTrunkMode_1 (ID): ");printFlag(trunkMode_ID1);
			printBlack("\tTrunkMode_2 (ID): ");printFlag(trunkMode_ID2);
			printBlack("\nMemWrite (EX): ");printFlag(MemWrite_EX);
			printBlack("\tALUSrc (EX): ");printFlag(ALUSrc_EX);
			printBlack("\nRegWrite (EX): ");printFlag(RegWrite_EX);
			printBlack("\tJump (EX): \t");printFlag(Jump_EX);
			printBlack("\nTrunkMode_1 (EX): ");printFlag(trunkMode_EX1);
			printBlack("\tTrunkMode_2 (EX): ");printFlag(trunkMode_EX2);*/
		} catch (SerialPortException e) {
			System.err.println("Serial Port Exception");
		}

	}

	private static void readAndPrintEXFlags(ByteBuffer bb) {
		try {
			print("\n");
			boolean ShiftToTrunk_EX, Zero_EX, BranchEQ_MEM, BranchNE_MEM, MemRead_MEM, MemToReg_MEM, MemWrite_MEM, RegWrite_MEM;
			b = serialPort.readBytes(1);
			ShiftToTrunk_EX = (b[0] & 0x80) != 0;
			Zero_EX = (b[0] & 0x40) != 0;
			BranchEQ_MEM = (b[0] & 0x20) != 0;
			BranchNE_MEM = (b[0] & 0x10) != 0;
			MemRead_MEM = (b[0] & 0x08) != 0;
			MemToReg_MEM = (b[0] & 0x04) != 0;
			MemWrite_MEM = (b[0] & 0x02) != 0;
			RegWrite_MEM = (b[0] & 0x01) != 0;
			flagsEX.get(9).setEstado(ShiftToTrunk_EX);
			flagsEX.get(10).setEstado(Zero_EX);
			flagsMEM.get(0).setEstado(MemRead_MEM);
			flagsMEM.get(1).setEstado(MemToReg_MEM);
			flagsMEM.get(2).setEstado(MemWrite_MEM);
			flagsMEM.get(3).setEstado(RegWrite_MEM);
			/*printBlack("\nShiftToTrunk (EX): ");printFlag(ShiftToTrunk_EX);
			printBlack("\tZero (EX): \t");printFlag(Zero_EX);
			//printBlack("\nBranchEQ (MEM): ");printFlag(BranchEQ_MEM);
			//printBlack("\tBranchNE (MEM): ");printFlag(BranchNE_MEM);
			printBlack("\nMemRead (MEM): ");printFlag(MemRead_MEM);
			printBlack("\tMemToReg (MEM): ");printFlag(MemToReg_MEM);
			printBlack("\nMemWrite (MEM): ");printFlag(MemWrite_MEM);
			printBlack("\tRegWrite (MEM): ");printFlag(RegWrite_MEM);*/
		} catch (SerialPortException e) {
			System.err.println("Serial Port Exception");
		}
	}

	private static void readAndPrintMEMFlags(ByteBuffer bb) {
		try {
			boolean Jump_MEM, Zero_MEM, MemToReg_WB;
			b = serialPort.readBytes(1);
			Jump_MEM = (b[0] & 0x80) != 0;
			Zero_MEM = (b[0] & 0x40) != 0;
			MemToReg_WB = (b[0] & 0x20) != 0;
			int Write_register_EX = b[0] & 0x1F;
			flagsMEM.get(4).setEstado(Jump_MEM);
			flagsMEM.get(5).setEstado(Zero_MEM);
			flagsWB.get(0).setEstado(MemToReg_WB);
			flagsEX.get(11).setRegistro(Write_register_EX);
			/*printBlack("\nJump (MEM): ");printFlag(Jump_MEM);
			printBlack("\tZero (MEM): \t");printFlag(Zero_MEM);
			printBlack("\nMemToReg (WB): ");printFlag(MemToReg_WB);
			printBlack("\tWrite_Register (EX): ");printGray("\t"+Write_register_EX+"");*/
			
			boolean RegWrite_WB, BranchTaken, Jump_ID;
			b = serialPort.readBytes(1);
			RegWrite_WB = (b[0] & 0x80) != 0;
			BranchTaken = (b[0] & 0x40) != 0;
			Jump_ID = (b[0] & 0x20) != 0;
			int Write_register_MEM = b[0] & 0x1F;
			flagsWB.get(1).setEstado(RegWrite_WB);
			flagsID.get(11).setEstado(BranchTaken);
			flagsID.get(12).setEstado(Jump_ID);
			flagsMEM.get(6).setRegistro(Write_register_MEM);
			/*printBlack("\nRegWrite (WB): ");printFlag(RegWrite_WB);
			printBlack("\tBranchTaken (ID): ");printFlag(BranchTaken);
			printBlack("\nJump (ID): \t");printFlag(Jump_ID);
			printBlack("\tWrite_Register (MEM): ");printGray("\t"+Write_register_MEM+"");*/
			
			boolean IF_Flush1, IF_Flush2, forwardA;
			b = serialPort.readBytes(1);
			IF_Flush1 = (b[0] & 0x80) != 0;
			IF_Flush2 = (b[0] & 0x40) != 0;
			forwardA = (b[0] & 0x20) != 0;
			int Write_register_WB = b[0] & 0x1F;
			flagsIF.get(0).setEstado(IF_Flush1);
			flagsIF.get(1).setEstado(IF_Flush2);
			flagsIF.get(2).setEstado(forwardA);
			flagsWB.get(2).setRegistro(Write_register_WB);
			/*printBlack("\nIF_Flush1: \t");printFlag(IF_Flush1);
			printBlack("\tIF_Flush2: \t");printFlag(IF_Flush2);
			printBlack("\nforwardA: \t");printFlag(forwardA);
			printBlack("\tWrite_Register (WB): ");printGray("\t"+Write_register_WB+"");*/
		} catch (SerialPortException e) {
			System.err.println("Serial Port Exception");
		}

	}
	
	
	private static void readRAM(){
		ByteBuffer bb = null;
		{
			try {
				b = serialPort.readBytes(1);//leer el primer cero
				for (int i = 0; i < 20; i++) {
					b = serialPort.readBytes(4);
					if (i % 5 == 0) {
						printBlack("\n");
					} else {
						printBlack("\t");
					}
					printBlack("Direccion["+i+"]: ");
					bb = ByteBuffer.wrap(b);
					bb.order(ByteOrder.LITTLE_ENDIAN);
					printGray(bb.getInt() + " ");
				}
			} catch (SerialPortException e) {
				System.err.println("Serial Port Exception");
			}
		}
	}
	
	
	private static void readAndSaveJALFlags(){
		try {
			boolean savePc_ID,savePc_EX,savePc_MEM,savePc_WB,JReg_ID;
			b = serialPort.readBytes(1);
			savePc_ID = (b[0] & 0x80) != 0;
			savePc_EX = (b[0] & 0x40) != 0;
			savePc_MEM = (b[0] & 0x20) != 0;
			savePc_WB = (b[0] & 0x10) != 0;
			JReg_ID = (b[0] & 0x08) != 0;
			printBlack("\nSavePc (ID): ");printFlag(savePc_ID);
			printBlack("\tSavePc (EX): ");printFlag(savePc_EX);
			printBlack("\tSavePc (MEM): ");printFlag(savePc_MEM);
			printBlack("\nSavePc (WB): ");printFlag(savePc_WB);
			printBlack("\tJReg (ID): ");printFlag(JReg_ID);
			
		}catch (SerialPortException e) {
			System.err.println("Serial Port Exception");
		}
	}
	
	
	
	private void inicializarFLags(){
		flagsID = new ArrayList<Flag>();		
		flagsID.add(new Flag("\nRegDest (ID): "));
		//flagsID.add(new Flag("\tBranchEQ (ID): "));
		//flagsID.add(new Flag("\nBranchNE (ID): "));
		flagsID.add(new Flag("\tMemRead (ID): "));
		flagsID.add(new Flag("\tMemToReg (ID): "));
		flagsID.add(new Flag("\nALUOp1 (ID): "));
		flagsID.add(new Flag("\tALUOp2 (ID): "));
		flagsID.add(new Flag("\tMemWrite (ID): "));
		flagsID.add(new Flag("\nALUSrc (ID): \t"));
		flagsID.add(new Flag("\tRegWrite (ID): "));
		flagsID.add(new Flag("\tShiftToTrunk (ID): "));
		flagsID.add(new Flag("\nTrunkMode_1 (ID): "));
		flagsID.add(new Flag("\tTrunkMode_2 (ID): "));
		flagsID.add(new Flag("\tBranchTaken (ID): "));
		flagsID.add(new Flag("\nJump (ID): \t")); 
		//flagsID.add(new Flag("\tSavePc (ID): ")); 
		
		flagsEX = new ArrayList<Flag>();
		flagsEX.add(new Flag("\nRegDest (EX): "));
		//flagsEX.add(new Flag("\tBranchEQ (EX): "));
		//flagsEX.add(new Flag("\nBranchNE (EX): "));
		flagsEX.add(new Flag("\tMemRead (EX): "));
		flagsEX.add(new Flag("\tMemToReg (EX): "));
		flagsEX.add(new Flag("\nMemWrite (EX): "));
		flagsEX.add(new Flag("\tALUSrc (EX): "));
		flagsEX.add(new Flag("\tRegWrite (EX): "));
		flagsEX.add(new Flag("\nJump (EX): \t"));
		flagsEX.add(new Flag("\tTrunkMode_1 (EX): "));
		flagsEX.add(new Flag("\tTrunkMode_2 (EX): "));
		flagsEX.add(new Flag("\nShiftToTrunk (EX): "));
		flagsEX.add(new Flag("\tZero (EX): \t"));
		//flagsEX.add(new Flag("\tSavePc (ID): "));
		flagsEX.add(new Flag("\nWrite_Register (EX): "));
		
		flagsMEM = new ArrayList<Flag>();
		//flagsMEM.add(new Flag("\nBranchEQ (MEM): "));
		//flagsMEM.add(new Flag("\tBranchNE (MEM): "));
		flagsMEM.add(new Flag("\nMemRead (MEM): "));
		flagsMEM.add(new Flag("\tMemToReg (MEM): "));
		flagsMEM.add(new Flag("\tMemWrite (MEM): "));
		flagsMEM.add(new Flag("\nRegWrite (MEM): "));
		flagsMEM.add(new Flag("\tJump (MEM): "));
		flagsMEM.add(new Flag("\tZero (MEM): \t"));
		flagsMEM.add(new Flag("\nWrite_Register (MEM): "));
		
		flagsWB = new ArrayList<Flag>();
		flagsWB.add(new Flag("\nMemToReg (WB): "));
		flagsWB.add(new Flag("\tRegWrite (WB): "));
		flagsWB.add(new Flag("\nWrite_Register (WB): "));
		
		flagsIF = new ArrayList<Flag>();
		flagsIF.add(new Flag("\nIF_Flush1: \t"));
		flagsIF.add(new Flag("\tIF_Flush2: \t"));
		flagsIF.add(new Flag("\tForwardA: \t"));
		
		/*
		 *printBlack("\nSavePc (ID): ");printFlag(savePc_ID);
			printBlack("\tSavePc (EX): ");printFlag(savePc_EX);
			printBlack("\tSavePc (MEM): ");printFlag(savePc_MEM);
			printBlack("\nSavePc (WB): ");printFlag(savePc_WB);
			printBlack("\tJReg (ID): ");printFlag(JReg_ID);*/
	}
	
	
	private void inicializarInstruccionesYRegistros(){
		InstruccionesYRegistros=new ArrayList<Flag>();
		InstruccionesYRegistros.add(new Flag("\nInstruccion(IF): "));
		InstruccionesYRegistros.add(new Flag("\n\nInstruccion(ID): "));
		InstruccionesYRegistros.add(new Flag("\nInstruction(EX):   "));
		InstruccionesYRegistros.add(new Flag("\tReg-s: "));
		InstruccionesYRegistros.add(new Flag("\t\tReg-t: "));
		InstruccionesYRegistros.add(new Flag("\n\nPC sumado (EX): "));
		InstruccionesYRegistros.add(new Flag("\t\tRead_Data_1 (EX): "));
		InstruccionesYRegistros.add(new Flag("\tRead_Data_2 (EX): "));
		InstruccionesYRegistros.add(new Flag("\tALU_Result (EX):    "));
		InstruccionesYRegistros.add(new Flag("\tALU_Result (MEM): "));
		InstruccionesYRegistros.add(new Flag("\nRead_Data (MEM): "));
		InstruccionesYRegistros.add(new Flag("\tRead_Data (WB): "));
		InstruccionesYRegistros.add(new Flag("\tALU_Result (WB): "));
		InstruccionesYRegistros.add(new Flag("\tRead_Data_2 (MEM)"));
	}
	
	
	private static void printAllFlagsID(){
		printOrange("\nFlags ID:");
		for(int i=0;i<flagsID.size();i++){
			printBlack(flagsID.get(i).getNombre()+"["+i+"] ");
			printFlag(flagsID.get(i).getEstado());
		}
	}
	
	private static void printAllFlagsEX(){
		printOrange("\nFlags EX:");
		for(int i=0;i<flagsEX.size()-1;i++){
			printBlack(flagsEX.get(i).getNombre()+"["+i+"] ");
			printFlag(flagsEX.get(i).getEstado());
		}
		printBlack(flagsEX.get(flagsEX.size()-1).getNombre()+"["+(flagsEX.size()-1)+"] ");
		printGray(flagsEX.get(flagsEX.size()-1).getRegistro()+"");
	}
	
	
	private static void printAllFlagsMEM(){
		printOrange("\nFlags MEM:");
		for(int i=0;i<flagsMEM.size()-1;i++){
			printBlack(flagsMEM.get(i).getNombre()+"["+i+"] ");
			printFlag(flagsMEM.get(i).getEstado());
		}
		printBlack(flagsMEM.get(flagsMEM.size()-1).getNombre()+"["+(flagsMEM.size()-1)+"] ");
		printGray(flagsMEM.get(flagsMEM.size()-1).getRegistro()+"");
		
	}
	
	private static void printAllFlagsWB(){
		printOrange("\nFlags WB:");
		for(int i=0;i<flagsWB.size()-1;i++){
			printBlack(flagsWB.get(i).getNombre()+"["+i+"] ");
			printFlag(flagsWB.get(i).getEstado());
		}
		printBlack(flagsWB.get(flagsWB.size()-1).getNombre()+"["+(flagsWB.size()-1)+"] ");
		printGray(flagsWB.get(flagsWB.size()-1).getRegistro()+"");
	}
	private static void printAllFlagsIF(){
		printOrange("\nFlags IF:");
		for(int i=0;i<flagsIF.size();i++){
			printBlack(flagsIF.get(i).getNombre()+"["+i+"] ");
			printFlag(flagsIF.get(i).getEstado());
		}
	}
	
	public static void printAllFlags(){
		printAllFlagsID();
		printAllFlagsEX();
		printAllFlagsMEM();
		printAllFlagsWB();
		printAllFlagsIF();
	}
	
	
	

	// *************************************************************************************************************//
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
