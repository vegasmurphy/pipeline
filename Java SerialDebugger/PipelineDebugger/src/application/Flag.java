package application;

public class Flag {
	private String nombre;
	private boolean estado;
	private int registro;
	private String valor;

	public Flag() {
		nombre = null;
		estado = false;
		registro = 0;
		valor="";
	}

	public Flag(String nombre) {
		this.nombre = nombre;
		estado=false;
		registro = 0;
		valor="";
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

}
