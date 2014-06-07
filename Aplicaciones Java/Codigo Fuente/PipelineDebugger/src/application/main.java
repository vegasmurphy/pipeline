package application;

import javax.swing.SwingUtilities;

import jssc.SerialPort;
import jssc.SerialPortEvent;
import jssc.SerialPortEventListener;
import jssc.SerialPortException;

public class main {

	static SerialPort serialPort;

	public static void main(String[] args) {
		// Interfaz Grafica
		GUI_Debugger gui = new GUI_Debugger();
		SwingUtilities.invokeLater(gui);
	}

}
