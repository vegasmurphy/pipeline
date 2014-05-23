package application;

import java.awt.BorderLayout;
import java.awt.Color;
import java.awt.Container;
import java.awt.Dimension;
import java.awt.FlowLayout;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

import javax.swing.Box;
import javax.swing.BoxLayout;
import javax.swing.JButton;
import javax.swing.JComboBox;
import javax.swing.JFrame;
import javax.swing.JMenu;
import javax.swing.JMenuBar;
import javax.swing.JMenuItem;
import javax.swing.JOptionPane;
import javax.swing.JPanel;
import javax.swing.JScrollPane;
import javax.swing.JTextArea;
import javax.swing.JTextPane;
import javax.swing.text.BadLocationException;
import javax.swing.text.SimpleAttributeSet;
import javax.swing.text.StyleConstants;

import jssc.SerialPort;

/**
 * @biref Clase que define el comportamiento de la interfaz grafica.
 * @author Marcelo
 * 
 */
public class GUI_Debugger extends JFrame implements Runnable {
	private JTextPane PCPaneActual;
	private JTextPane printer;
	private static String NOMBREVENTANA = "Debugger MIPS: Arquitectura de Computadoras";
	private SerialManager serialManager;

	/**
	 * @brief Funcion principal de la GUI
	 */
	public void run() {
		serialManager = new SerialManager(this);
		Container panelContenedor = getContentPane(); // Panel general (border
														// layout)
		panelContenedor.setLayout(new BorderLayout());
		// Barra de menu
		generateMenu();

		// Panel Con Opciones y Botones
		generateDisplay(panelContenedor);

		// Area de texto para los prints
		generatePrintingArea(panelContenedor);

		setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		setSize(700, 400);
		setLocationRelativeTo(null);
		setTitle(NOMBREVENTANA);
		// setResizable(false);
		setVisible(true);
	}

	/**
	 * @brief Funcion que genera el display donde se muestran los valores
	 *        numericos
	 * @param panelContenedor
	 */
	private void generateDisplay(Container panelContenedor) {
		JPanel boxPanel = new JPanel();
		boxPanel.setLayout(new BoxLayout(boxPanel, BoxLayout.PAGE_AXIS));

		// FLow
		JPanel upperFlowPanel = new JPanel(new FlowLayout(FlowLayout.LEFT));

		JTextPane textPC = new JTextPane();
		textPC.setEditable(false);
		textPC.setText("Contador de Programa");
		textPC.setBackground(Color.WHITE);

		PCPaneActual = new JTextPane();
		PCPaneActual.setText("       0");

		upperFlowPanel.add(textPC);
		upperFlowPanel.add(PCPaneActual);
		// ----Flow end-----

		// --- Button ----
		// Para que queden parejos el boton y las luces
		upperFlowPanel.add(Box.createRigidArea(new Dimension(0, 1)));
		upperFlowPanel.add(generateNextPCButton());
		/*JButton printButton = new JButton("BlackTestText");
		printButton.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent evento) {
				// printer.append("Apretaste el Boton\n");
				printBlack("Registro1: ");
			}
		});
		JButton printButtonGray = new JButton("GrayTestText");
		printButtonGray.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent evento) {
				// printer.append("Apretaste el Boton\n");
				printGray("FF4562F1\n");
			}
		});
		upperFlowPanel.add(printButton);
		upperFlowPanel.add(printButtonGray);*/

		boxPanel.add(upperFlowPanel);

		panelContenedor.add(boxPanel, BorderLayout.NORTH);
	}

	/**
	 * @brief Funcion que crea el boton que cambia la temperatura maxima
	 * @return
	 */
	private JButton generateNextPCButton() {
		JButton boton = new JButton("Avanzar");
		boton.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent evento) {
				// printer.append("Apretaste el Boton\n");
				startSerialCom();
			}
		});
		return boton;
	}

	/**
	 * @brief Funcion que actualiza el valor del PC
	 * @param valorNuevo
	 */
	public void actualizartextPC(int valorNuevo) {
		String cadena = "" + valorNuevo;
		cadena = String.format("%03d", Integer.parseInt(cadena));
		PCPaneActual.setText(cadena);
	}

	/**
	 * @brief Funcion que genera el area de texto en donde se muestran los
	 *        prints
	 * @param panelContenedor
	 */
	private void generatePrintingArea(Container panelContenedor) {
		printer = new JTextPane();
		printer.setEditable(false);
		JScrollPane scrollPane = new JScrollPane(printer);
		panelContenedor.add(scrollPane, BorderLayout.CENTER);
	}

	/**
	 * @brief Funcion que genera la barra de menu
	 */
	private void generateMenu() {
		JMenuBar menuBar = new JMenuBar();
		JMenu fileMenu = createFileMenu();
		JMenu optionsMenu = createOptionsMenu();
		JMenu helpMenu = createAboutMenu();
		// Agregar los menues a la brra de menu
		menuBar.add(fileMenu);
		menuBar.add(optionsMenu);
		menuBar.add(helpMenu);
		// Ponerle la barra de menu a la ventana
		setJMenuBar(menuBar);
	}

	/**
	 * Este metodo Genera el menu archivo y hace los llamados a funcion
	 * correspondientes a cada opcion.
	 */
	private JMenu createFileMenu() {
		JMenu fileMenu = new JMenu("Archivo");

		// Falta preguntar si desea guardar
		JMenuItem elementoSalir = new JMenuItem("Salir");
		fileMenu.add(elementoSalir);
		elementoSalir.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent evento) {
				System.exit(0);
			}
		});

		return fileMenu;
	}// **************************************************************************************************************//

	/**
	 * @brief: Crea el menu de "Opciones"
	 * @return
	 */
	private JMenu createOptionsMenu() {
		JMenu optionsMenu = new JMenu("Opciones");

		JMenuItem serialPort = new JMenuItem("Elegir Puerto Serie");
		optionsMenu.add(serialPort);
		serialPort.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent evento) {
				chooseSerialPort();
			}
		});

		return optionsMenu;
	}// **************************************************************************************************************//

	/**
	 * @brief: Creates The "Ayuda" Menu
	 * @return
	 */
	private JMenu createAboutMenu() {
		JMenu aboutMenu = new JMenu("Ayuda");

		JMenuItem elementoAbout = new JMenuItem("Acerca de " + NOMBREVENTANA);
		aboutMenu.add(elementoAbout);
		elementoAbout.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent evento) {
				acercaDe();
			}
		});
		return aboutMenu;
	}// **************************************************************************************************************//

	/**
	 * Despliega una ventana de da datos sobre el programa al clickear la opcion
	 * "acerca de" del menu Ayuda
	 */
	private void acercaDe() {
		JOptionPane
				.showMessageDialog(
						null,
						"Integrantes:\n"
								+ "  - Murphy Vegas\n"
								+ "  - Schild Marcelo\n\n"
								+ "Version 0.04"
								+ "\nFunciones implementadas:\n"
								+ "  - Interfaz Grafica\n  - Boton para avanzar una instruccion\n",
						"Acerca de " + NOMBREVENTANA,
						JOptionPane.INFORMATION_MESSAGE);
	}// **************************************************************************************************************//

	/**
	 * @brief Funcion que elige el puerto para la comunicacion serie.
	 */
	private void chooseSerialPort() {
		String[] ports = serialManager.getPorts();
		String puerto = (String) JOptionPane.showInputDialog(null,
				"Elija el Puerto serie a Utilizar", "Elegir Puerto Serie",
				JOptionPane.PLAIN_MESSAGE, null, ports, ports[0]);

		if (puerto != null)
			serialManager.setSerialPort(puerto);// serialPort = new
												// SerialPort(puerto);
	}

	/**
	 * @brief Funcion que inicia la comunicacion Serie
	 */
	private void startSerialCom() {
		if (serialManager.getSerialPort() == null) {
			JOptionPane
					.showMessageDialog(null, "ERROR: Puerto serie Nulo",
							"Instrucciones Soportadas",
							JOptionPane.INFORMATION_MESSAGE);
		} else {
			// System.err.println("Falta Implementar");
			serialManager.serialComunication();
		}
	}

	public void printBlack(String cadena) {
		// Agregar el include coloreado y devolver una linea vacia
		SimpleAttributeSet[] formatos = initAttributes(cadena.length() + 10);
		try {
			printer.getStyledDocument().insertString(printer.getStyledDocument().getLength(), cadena, formatos[1]);
		} catch (BadLocationException h) {
			System.err.println("Excepcion de mala ubicacion (TextPane)");
		}
	}
	
	public void printGray(String cadena) {
		// Agregar el include coloreado y devolver una linea vacia
		SimpleAttributeSet[] formatos = initAttributes(cadena.length() + 10);
		try {
			printer.getStyledDocument().insertString(printer.getStyledDocument().getLength(), cadena, formatos[4]);
		} catch (BadLocationException h) {
			System.err.println("Excepcion de mala ubicacion (TextPane)");
		}
	}

	/**
	 * @brief Funcion que permite imprimir texto en el area de texto de la GUI
	 * @param cadena
	 */
	public void printText(String cadena) {
		// Agregar el include coloreado y devolver una linea vacia
		SimpleAttributeSet[] formatos = initAttributes(cadena.length() + 10);
		try {
			printer.getStyledDocument().insertString(printer.getStyledDocument().getLength(), cadena, formatos[0]);
		} catch (BadLocationException h) {
			System.err.println("Excepcion de mala ubicacion (TextPane)");
		}
	}

	public void printTextLine(String cadena) {
		printText(cadena+"\n");
	}

	/**
	 * @brief: Metodo que inicializa la fuente por defecto del campo de texto.
	 * @param length
	 * @return
	 */
	protected SimpleAttributeSet[] initAttributes(int length) {
		// Hard-code some attributes.
		SimpleAttributeSet[] attrs = new SimpleAttributeSet[length];

		// Palabras Normales
		attrs[0] = new SimpleAttributeSet();
		StyleConstants.setFontFamily(attrs[0], "SansSerif");
		StyleConstants.setFontSize(attrs[0], 12);

		// Palabras reservadas (negrita)
		attrs[1] = new SimpleAttributeSet(attrs[0]);
		StyleConstants.setBold(attrs[1], true);

		// Registros (azul)
		attrs[2] = new SimpleAttributeSet(attrs[0]);
		StyleConstants.setForeground(attrs[2], Color.blue);

		// Literales (magenta)
		attrs[3] = new SimpleAttributeSet(attrs[0]);
		StyleConstants.setForeground(attrs[3], Color.magenta);

		// Comentarios (gris)
		attrs[4] = new SimpleAttributeSet(attrs[0]);
		StyleConstants.setForeground(attrs[4], Color.gray);
		StyleConstants.setBold(attrs[4], true);
		StyleConstants.setItalic(attrs[4], true);

		// Includes (verde)
		attrs[5] = new SimpleAttributeSet(attrs[0]);
		StyleConstants.setForeground(attrs[5], Color.orange);
		StyleConstants.setBold(attrs[5], true);
		StyleConstants.setItalic(attrs[5], false);

		return attrs;
	}

}
