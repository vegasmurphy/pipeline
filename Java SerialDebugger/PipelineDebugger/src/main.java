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
        serialPort = new SerialPort("COM5"); 
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
        print("PC: ");
        ByteBuffer bb = ByteBuffer.wrap(b);
        bb.order(ByteOrder.LITTLE_ENDIAN);
    	print(bb.getInt()+"");	
        println("");
        
        b=serialPort.readBytes(4);
        println("Instruccion:");
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
        
        boolean RegDest_ID,BranchEQ_ID,BranchNE_ID,MemRead_ID,MemToReg_ID,ALUOp1_ID,ALUOp2_ID,MemWrite_ID;
        
        b=serialPort.readBytes(1);
        //print("Flags: ");
        //bb = ByteBuffer.wrap(b);
        //bb.order(ByteOrder.LITTLE_ENDIAN);
        RegDest_ID=(b[0] & 0xFE)!=0;
        BranchEQ_ID=(b[0] & 0xFD)!=0;
        BranchNE_ID=(b[0] & 0xFB)!=0;
        MemRead_ID=(b[0] & 0xF7)!=0;
        MemToReg_ID=(b[0] & 0xEF)!=0;
        ALUOp1_ID=(b[0] & 0xDF)!=0;
        ALUOp2_ID=(b[0] & 0xBF)!=0;
        MemWrite_ID=(b[0] & 0x7F)!=0;
        println("RegDest_ID: "+RegDest_ID+" BranchEQ_ID: "+BranchEQ_ID+" BranchNE_ID: "+BranchNE_ID+" MemRead_ID: "+MemRead_ID+" MemToReg_ID: "+MemToReg_ID+" ALUOp1_ID: "+ALUOp1_ID+" ALUOp2_ID: "+ALUOp2_ID+" MemWrite_ID: "+MemWrite_ID);
    	//print(""+RegDest_ID+BranchEQ_ID+BranchNE_ID+MemRead_ID+MemToReg_ID+ALUOp1_ID+ALUOp2_ID+MemWrite_ID);	
        println("");
        
        
 boolean ALUSrc_ID,RegWrite_ID,ShiftToTrunk_ID,RegDest_EX,BranchEQ_EX,BranchNE_EX,MemRead_EX,MemToReg_EX;
        
        b=serialPort.readBytes(1);
        //print("Flags: ");
        //bb = ByteBuffer.wrap(b);
        //bb.order(ByteOrder.LITTLE_ENDIAN);
        ALUSrc_ID=(b[0] & 0xFE)!=0;
        RegWrite_ID=(b[0] & 0xFD)!=0;
        ShiftToTrunk_ID=(b[0] & 0xFB)!=0;
        RegDest_EX=(b[0] & 0xF7)!=0;
        BranchEQ_EX=(b[0] & 0xEF)!=0;
        BranchNE_EX=(b[0] & 0xDF)!=0;
        MemRead_EX=(b[0] & 0xBF)!=0;
        MemToReg_EX=(b[0] & 0x7F)!=0;
        println("ALUSrc_ID: "+ALUSrc_ID+" RegWrite_ID: "+RegWrite_ID+" ShiftToTrunk_ID: "+ShiftToTrunk_ID+" RegDest_EX: "+RegDest_EX+" BranchEQ_EX: "+BranchEQ_EX+" BranchNE_EX: "+BranchNE_EX+" MemRead_EX: "+MemRead_EX+" MemToReg_EX: "+MemToReg_EX);
    	//print(""+RegDest_ID+BranchEQ_ID+BranchNE_ID+MemRead_ID+MemToReg_ID+ALUOp1_ID+ALUOp2_ID+MemWrite_ID);	
        println("");
        
        
 boolean trunkMode_ID1,trunkMode_ID2,MemWrite_EX,ALUSrc_EX,RegWrite_EX,Jump_EX,trunkMode_EX1,trunkMode_EX2;
        
        b=serialPort.readBytes(1);
        //print("Flags: ");
        //bb = ByteBuffer.wrap(b);
        //bb.order(ByteOrder.LITTLE_ENDIAN);
        trunkMode_ID1=(b[0] & 0xFE)!=0;
        trunkMode_ID2=(b[0] & 0xFD)!=0;
        MemWrite_EX=(b[0] & 0xFB)!=0;
        ALUSrc_EX=(b[0] & 0xF7)!=0;
        RegWrite_EX=(b[0] & 0xEF)!=0;
        Jump_EX=(b[0] & 0xDF)!=0;
        trunkMode_EX1=(b[0] & 0xBF)!=0;
        trunkMode_EX2=(b[0] & 0x7F)!=0;
        println("trunkMode_ID1: "+trunkMode_ID1+" trunkMode_ID2: "+trunkMode_ID2+" MemWrite_EX: "+MemWrite_EX+" ALUSrc_EX: "+ALUSrc_EX+" RegWrite_EX: "+RegWrite_EX+" Jump_EX: "+Jump_EX+" trunkMode_EX1: "+trunkMode_EX1+" trunkMode_EX2: "+trunkMode_EX2);
    	//print(""+RegDest_ID+BranchEQ_ID+BranchNE_ID+MemRead_ID+MemToReg_ID+ALUOp1_ID+ALUOp2_ID+MemWrite_ID);	
        println("");   
        
        
        b=serialPort.readBytes(4);
        print("PC sumado Ex: ");
        bb = ByteBuffer.wrap(b);
        bb.order(ByteOrder.LITTLE_ENDIAN);
    	print(bb.getInt()+" ");	
        println("");
        
        b=serialPort.readBytes(4);
        print("Read data ex 1: ");
        bb = ByteBuffer.wrap(b);
        bb.order(ByteOrder.LITTLE_ENDIAN);
    	print(bb.getInt()+" ");	
        println("");
        
        b=serialPort.readBytes(4);
        print("Read data ex 2: ");
        bb = ByteBuffer.wrap(b);
        bb.order(ByteOrder.LITTLE_ENDIAN);
    	print(bb.getInt()+" ");	
        println("");
        
        b=serialPort.readBytes(4);
        print("Instruction Ex: ");
        bb = ByteBuffer.wrap(b);
        bb.order(ByteOrder.LITTLE_ENDIAN);
    	print(bb.getInt()+" ");	
        println("");
        
        
        b=serialPort.readBytes(4);
        print("ALU_result_EX: ");
        bb = ByteBuffer.wrap(b);
        bb.order(ByteOrder.LITTLE_ENDIAN);
    	print(bb.getInt()+" ");	
        println("");
        
        b=serialPort.readBytes(4);
        print("ALU_result_MEM: ");
        bb = ByteBuffer.wrap(b);
        bb.order(ByteOrder.LITTLE_ENDIAN);
    	print(bb.getInt()+" ");	
        println("");
        
        boolean ShiftToTrunk_EX,Zero_EX,BranchEQ_MEM,BranchNE_MEM,MemRead_MEM,MemToReg_MEM,MemWrite_MEM,RegWrite_MEM;        
        b=serialPort.readBytes(1);
        //print("Flags: ");
        //bb = ByteBuffer.wrap(b);
        //bb.order(ByteOrder.LITTLE_ENDIAN);
        ShiftToTrunk_EX=(b[0] & 0xFE)!=0;
        Zero_EX=(b[0] & 0xFD)!=0;
        BranchEQ_MEM=(b[0] & 0xFB)!=0;
        BranchNE_MEM=(b[0] & 0xF7)!=0;
        MemRead_MEM=(b[0] & 0xEF)!=0;
        MemToReg_MEM=(b[0] & 0xDF)!=0;
        MemWrite_MEM=(b[0] & 0xBF)!=0;
        RegWrite_MEM=(b[0] & 0x7F)!=0;
        println("ShiftToTrunk_EX: "+ShiftToTrunk_EX+" Zero_EX: "+Zero_EX+" BranchEQ_MEM: "+BranchEQ_MEM+" BranchNE_MEM: "+BranchNE_MEM+" MemRead_MEM: "+MemRead_MEM+" MemToReg_MEM: "+MemToReg_MEM+" MemWrite_MEM: "+MemWrite_MEM+" RegWrite_MEM: "+RegWrite_MEM);
    	//print(""+RegDest_ID+BranchEQ_ID+BranchNE_ID+MemRead_ID+MemToReg_ID+ALUOp1_ID+ALUOp2_ID+MemWrite_ID);	
        println(""); 
        
        
        boolean Jump_MEM,Zero_MEM,MemToReg_WB;        
        b=serialPort.readBytes(1);
        Jump_MEM=(b[0] & 0xDF)!=0;
        Zero_MEM=(b[0] & 0xBF)!=0;
        MemToReg_WB=(b[0] & 0x7F)!=0;
        int Write_register_EX=b[0] & 0x1F;
        println("Jump_MEM: "+Jump_MEM+" Zero_MEM: "+Zero_MEM+" MemToReg_WB: "+MemToReg_WB+" Write_register_EX: "+Write_register_EX);
        println(""); 
        
        boolean RegWrite_WB,BranchTaken,Jump_ID;        
        b=serialPort.readBytes(1);
        RegWrite_WB=(b[0] & 0xDF)!=0;
        BranchTaken=(b[0] & 0xBF)!=0;
        Jump_ID=(b[0] & 0x7F)!=0;
        int Write_register_MEM=b[0] & 0x1F;
        println("RegWrite_WB: "+RegWrite_WB+" BranchTaken: "+BranchTaken+" Jump_ID: "+Jump_ID+" Write_register_MEM: "+Write_register_MEM);
        println("");
        
        boolean IF_Flush1,IF_Flush2,forwardA;        
        b=serialPort.readBytes(1);
        IF_Flush1=(b[0] & 0xDF)!=0;
        IF_Flush2=(b[0] & 0xBF)!=0;
        forwardA=(b[0] & 0x7F)!=0;
        int Write_register_WB=b[0] & 0x1F;
        println("IF_Flush1: "+IF_Flush1+" IF_Flush2: "+IF_Flush2+" forwardA: "+forwardA+" Write_register_WB: "+Write_register_WB);
        println("");
        
        b=serialPort.readBytes(4);
        print("Read_data_MEM: ");
        bb = ByteBuffer.wrap(b);
        bb.order(ByteOrder.LITTLE_ENDIAN);
    	print(bb.getInt()+" ");	
        println("");
        
        b=serialPort.readBytes(4);
        print("Read_data_WB: ");
        bb = ByteBuffer.wrap(b);
        bb.order(ByteOrder.LITTLE_ENDIAN);
    	print(bb.getInt()+" ");	
        println("");
        
        b=serialPort.readBytes(4);
        print("ALU_result_WB: ");
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
