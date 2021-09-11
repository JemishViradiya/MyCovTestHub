package main;

public class AdminUser {
	
	String unm;
	String psw;
	
	public String getName() {
		return unm;
	}
	public void setName(String name) {
		this.unm = name;
	}
	public String getPasswordHash() {
		return psw;
	}
	public void setPasswordHash(String passwordHash) {
		this.psw = passwordHash;
	}
	
	public AdminUser(String name,String passwordHash) {
		super();
		this.unm = name;
		this.psw = passwordHash;
	}
	

}
