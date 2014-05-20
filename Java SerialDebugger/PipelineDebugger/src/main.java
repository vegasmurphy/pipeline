package pipeline;
import java.nio.ByteBuffer;
import java.nio.ByteOrder;
import java.util.Arrays;
import java.util.Collection;
import java.util.Collections;

import jssc.SerialPort;
import jssc.SerialPortEvent;
import jssc.SerialPortEventListener;
import jssc.SerialPortException;

public class Main {

    static SerialPort serialPort;
    static byte b[];
    public static void main(String[] args) {
        serialPort = new SerialPort("COM7"); 
        try {
            
            while(true){
            	serialPort.openPort();//Open port
                serialPort.setParams(2400, 8, 1, 0);//Set params
                int mask = SerialPort.MASK_RXCHAR + SerialPort.MASK_CTS + SerialPort.MASK_DSR;//Prepare mask
                serialPort.setEventsMask(mask);//Set mask
                //serialPort.addEventListener(new SerialPortReader());//Add SerialPortEventListener
                serialPort.writeBytes("A".getBytes());
                serialPort.writeBytes("b".getBytes());
                b=serialPort.readBytes(1);
                println("");
            	System.out.println("New read:");
	            readAllData();
	            serialPort.closePort();
	            /*serialPort.writeBytes("A".getBytes());
	            serialPort.writeBytes("b".getBytes());*/
            }
        }
        catch (SerialPortException ex) {
            System.out.println(ex);
        } 
    }
    private static void print(String a){
    	System.out.print(a);
    }
    
    private static void println(String a){
    	System.out.println(a);
    }
    
    private static void readAllData(){
    	try {
			
    	b=serialPort.readBytes(4);
        System.out.print("PC: ");
        ByteBuffer bb = ByteBuffer.wrap(b);
        bb.order(ByteOrder.LITTLE_ENDIAN);
    	print(bb.getInt()+"");	
        println("");
        
        b=serialPort.readBytes(4);
        System.out.println("Instruccion:");
        for (int i=0;i<b.length;i++)
    		print(b[i]+" ");
        println("");
        
        b=serialPort.readBytes(4);
        print("Reg0: ");
        bb = ByteBuffer.wrap(b);
        bb.order(ByteOrder.LITTLE_ENDIAN);
    	print(bb.getInt()+" ");	
        //println("");
        
        b=serialPort.readBytes(4);
        print("Reg1: ");
        bb = ByteBuffer.wrap(b);
        bb.order(ByteOrder.LITTLE_ENDIAN);
    	print(bb.getInt()+" ");	
        //println("");
        
        b=serialPort.readBytes(4);
        print("Reg2: ");
        bb = ByteBuffer.wrap(b);
        bb.order(ByteOrder.LITTLE_ENDIAN);
    	print(bb.getInt()+" ");	
        //println("");
        
        b=serialPort.readBytes(4);
        print("Reg3: ");
        bb = ByteBuffer.wrap(b);
        bb.order(ByteOrder.LITTLE_ENDIAN);
    	print(bb.getInt()+" ");	
        println("");
        
        b=serialPort.readBytes(4);
        print("Reg4: ");
        bb = ByteBuffer.wrap(b);
        bb.order(ByteOrder.LITTLE_ENDIAN);
    	print(bb.getInt()+" ");	
        //println("");
        
        b=serialPort.readBytes(4);
        print("Reg5: ");
        bb = ByteBuffer.wrap(b);
        bb.order(ByteOrder.LITTLE_ENDIAN);
    	print(bb.getInt()+" ");	
        //println("");
        
        b=serialPort.readBytes(4);
        print("Reg6: ");
        bb = ByteBuffer.wrap(b);
        bb.order(ByteOrder.LITTLE_ENDIAN);
    	print(bb.getInt()+" ");	
        //println("");
        
        b=serialPort.readBytes(4);
        print("Reg7: ");
        bb = ByteBuffer.wrap(b);
        bb.order(ByteOrder.LITTLE_ENDIAN);
    	print(bb.getInt()+" ");	
        println("");
        
        b=serialPort.readBytes(4);
        print("Reg8: ");
        bb = ByteBuffer.wrap(b);
        bb.order(ByteOrder.LITTLE_ENDIAN);
    	print(bb.getInt()+" ");	
        //println("");
        
        b=serialPort.readBytes(4);
        print("Reg9: ");
        bb = ByteBuffer.wrap(b);
        bb.order(ByteOrder.LITTLE_ENDIAN);
    	print(bb.getInt()+" ");	
        //println("");
        
        b=serialPort.readBytes(4);
        print("Reg10: ");
        bb = ByteBuffer.wrap(b);
        bb.order(ByteOrder.LITTLE_ENDIAN);
    	print(bb.getInt()+" ");	
        //println("");
        
        b=serialPort.readBytes(4);
        print("Reg11: ");
        bb = ByteBuffer.wrap(b);
        bb.order(ByteOrder.LITTLE_ENDIAN);
    	print(bb.getInt()+" ");	
        println("");
        

        b=serialPort.readBytes(4);
        print("Reg12: ");
        bb = ByteBuffer.wrap(b);
        bb.order(ByteOrder.LITTLE_ENDIAN);
    	print(bb.getInt()+" ");	
        //println("");
        
        b=serialPort.readBytes(4);
        print("Reg13: ");
        bb = ByteBuffer.wrap(b);
        bb.order(ByteOrder.LITTLE_ENDIAN);
    	print(bb.getInt()+" ");	
        //println("");
        
        b=serialPort.readBytes(4);
        print("Reg14: ");
        bb = ByteBuffer.wrap(b);
        bb.order(ByteOrder.LITTLE_ENDIAN);
    	print(bb.getInt()+" ");	
        //println("");
        
        b=serialPort.readBytes(4);
        print("Reg15: ");
        bb = ByteBuffer.wrap(b);
        bb.order(ByteOrder.LITTLE_ENDIAN);
    	print(bb.getInt()+" ");	
        println("");
        
        b=serialPort.readBytes(4);
        print("Reg16: ");
        bb = ByteBuffer.wrap(b);
        bb.order(ByteOrder.LITTLE_ENDIAN);
    	print(bb.getInt()+" ");	
        //println("");
        
        b=serialPort.readBytes(4);
        print("Reg17: ");
        bb = ByteBuffer.wrap(b);
        bb.order(ByteOrder.LITTLE_ENDIAN);
    	print(bb.getInt()+" ");	
        //println("");
        
        b=serialPort.readBytes(4);
        print("Reg18: ");
        bb = ByteBuffer.wrap(b);
        bb.order(ByteOrder.LITTLE_ENDIAN);
    	print(bb.getInt()+" ");	
        //println("");
        
        b=serialPort.readBytes(4);
        print("Reg19: ");
        bb = ByteBuffer.wrap(b);
        bb.order(ByteOrder.LITTLE_ENDIAN);
    	print(bb.getInt()+" ");	
        println("");
        
        b=serialPort.readBytes(4);
        print("Reg20: ");
        bb = ByteBuffer.wrap(b);
        bb.order(ByteOrder.LITTLE_ENDIAN);
    	print(bb.getInt()+" ");	
        //println("");
        
        b=serialPort.readBytes(4);
        print("Reg21: ");
        bb = ByteBuffer.wrap(b);
        bb.order(ByteOrder.LITTLE_ENDIAN);
    	print(bb.getInt()+" ");	
        //println("");
        
        b=serialPort.readBytes(4);
        print("Reg22: ");
        bb = ByteBuffer.wrap(b);
        bb.order(ByteOrder.LITTLE_ENDIAN);
    	print(bb.getInt()+" ");	
        //println("");
        
        b=serialPort.readBytes(4);
        print("Reg23: ");
        bb = ByteBuffer.wrap(b);
        bb.order(ByteOrder.LITTLE_ENDIAN);
    	print(bb.getInt()+" ");	
        println("");
        
        b=serialPort.readBytes(4);
        print("Reg24: ");
        bb = ByteBuffer.wrap(b);
        bb.order(ByteOrder.LITTLE_ENDIAN);
    	print(bb.getInt()+" ");	
        //println("");
        
        b=serialPort.readBytes(4);
        print("Reg25: ");
        bb = ByteBuffer.wrap(b);
        bb.order(ByteOrder.LITTLE_ENDIAN);
    	print(bb.getInt()+" ");	
        //println("");
        
        b=serialPort.readBytes(4);
        print("Reg26: ");
        bb = ByteBuffer.wrap(b);
        bb.order(ByteOrder.LITTLE_ENDIAN);
    	print(bb.getInt()+" ");	
       // println("");
        
        b=serialPort.readBytes(4);
        print("Reg27: ");
        bb = ByteBuffer.wrap(b);
        bb.order(ByteOrder.LITTLE_ENDIAN);
    	print(bb.getInt()+" ");	
        println("");
        
        b=serialPort.readBytes(4);
        print("Reg28: ");
        bb = ByteBuffer.wrap(b);
        bb.order(ByteOrder.LITTLE_ENDIAN);
    	print(bb.getInt()+" ");	
        //println("");
        
        b=serialPort.readBytes(4);
        print("Reg29: ");
        bb = ByteBuffer.wrap(b);
        bb.order(ByteOrder.LITTLE_ENDIAN);
    	print(bb.getInt()+" ");	
       // println("");
        
        b=serialPort.readBytes(4);
        print("Reg30: ");
        bb = ByteBuffer.wrap(b);
        bb.order(ByteOrder.LITTLE_ENDIAN);
    	print(bb.getInt()+" ");	
       // println("");
        
        b=serialPort.readBytes(4);
        print("Reg31: ");
        bb = ByteBuffer.wrap(b);
        bb.order(ByteOrder.LITTLE_ENDIAN);
    	print(bb.getInt()+" ");	
        println("");
        
        b=serialPort.readBytes(4);
        System.out.println("Instruccion ID:");
        for (int i=0;i<b.length;i++)
    		print(b[i]+" ");
        println("");
        
        b=serialPort.readBytes(4);
        print("Rs: ");
        bb = ByteBuffer.wrap(b);
        bb.order(ByteOrder.LITTLE_ENDIAN);
    	print(bb.getInt()+" ");	
        println("");
        
        b=serialPort.readBytes(4);
        print("Rt: ");
        bb = ByteBuffer.wrap(b);
        bb.order(ByteOrder.LITTLE_ENDIAN);
    	print(bb.getInt()+" ");	
        println("");
        
        
        //b=serialPort.readBytes(1);
    	} catch (SerialPortException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
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
                        byte[] b=serialPort.readBytes(4);
                    	for (int i=0;i<b.length;i++)
                    		System.out.println(b[i]);
                    	//System.out.println(event.getEventValue());
                        serialPort.writeBytes("b".getBytes());
                        serialPort.writeBytes("A".getBytes());
                    }
                    catch (SerialPortException ex) {
                        System.out.println(ex);
                    }
                }
            }
         
        }
    }
