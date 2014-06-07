package application;

import java.util.ArrayList;

public class Flag {
	private String nombre;
	private boolean estado;
	private int registro;
	private String valor;

	public Flag() {
		nombre = null;
		estado = false;
		registro = 0;
		valor="0";
	}

	public Flag(String nombre) {
		this.nombre = nombre;
		estado=false;
		registro = 0;
		valor="0";
	}

	public void setEstado(boolean nuevoEstado) {
		estado = nuevoEstado;
	}

	public void setNombre(String nombre) {
		this.nombre = nombre;
	}

	public String getNombre() {
		return nombre;
	}

	public boolean getEstado() {
		return estado;
	}
	
	public void setRegistro(int registro){
		this.registro=registro;
	}
	
	public int getRegistro(){
		return registro;
	}
	
	public String getValor(){
		return valor;
	}
	
	public void setValor(String valor){
		this.valor=valor;
	}

	
	
	/*
	 * InstruccionesYRegistros=new ArrayList<Flag>();
		InstruccionesYRegistros.add(new Flag("\nInstruccion(IF): "));		//0
		InstruccionesYRegistros.add(new Flag("\tInstruccion(ID): "));		//1
		InstruccionesYRegistros.add(new Flag("\tInstruction(EX):   "));		//2
		InstruccionesYRegistros.add(new Flag("\tReg-s: "));					//3
		InstruccionesYRegistros.add(new Flag("\t\tReg-t: "));				//4
		InstruccionesYRegistros.add(new Flag("\nPC sumado (EX): "));		//5
		InstruccionesYRegistros.add(new Flag("\t\tRead_Data_1 (EX): "));	//6
		InstruccionesYRegistros.add(new Flag("\tRead_Data_2 (EX): "));		//7
		InstruccionesYRegistros.add(new Flag("\tRead_Data_2 (MEM)"));		//8
		InstruccionesYRegistros.add(new Flag("\tALU_Result (EX):    "));	//9
		InstruccionesYRegistros.add(new Flag("\tALU_Result (MEM): "));		//10
		InstruccionesYRegistros.add(new Flag("\tALU_Result (WB): "));		//11
		InstruccionesYRegistros.add(new Flag("\nRead_Data (MEM): "));		//12
		InstruccionesYRegistros.add(new Flag("\tRead_Data (WB): "));*/		//13



















}
