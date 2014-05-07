

import jssc.SerialPort;
import jssc.SerialPortEvent;
import jssc.SerialPortEventListener;
import jssc.SerialPortException;

public class main {

    static SerialPort serialPort;

    public static void main(String[] args) {
        serialPort = new SerialPort("COM4"); 
        try {
            serialPort.openPort();//Open port
            serialPort.setParams(2400, 8, 1, 0);//Set params
            int mask = SerialPort.MASK_RXCHAR + SerialPort.MASK_CTS + SerialPort.MASK_DSR;//Prepare mask
            serialPort.setEventsMask(mask);//Set mask
            serialPort.addEventListener(new SerialPortReader());//Add SerialPortEventListener
            serialPort.writeBytes("A".getBytes());
        }
        catch (SerialPortException ex) {
            System.out.println(ex);
        }
    }
    
    /*
     * In this class must implement the method serialEvent, through it we learn about 
     * events that happened to our port. But we will not report on all events but only 
     * those that we put in the mask. In this case the arrival of the data and change the 
     * status lines CTS and DSR
     */
    static class SerialPortReader implements SerialPortEventListener {

        public void serialEvent(SerialPortEvent event) {
            if(event.isRXCHAR()){//If data is available
               
                    try {
                        System.out.println(serialPort.readBytes(1)[0]);
                        serialPort.writeBytes("A".getBytes());
                    }
                    catch (SerialPortException ex) {
                        System.out.println(ex);
                    }
                }
            }
         
        }
    }
