package main;

public class ReportObject {
	
	String email,fullname,age,gender,address,postcode,ttn,testresult;
	
	public ReportObject(String email, String fullname, String age, String gender, String address, String postcode,
			String ttn_code, String test_result) {
		super();
		this.email = email;
		this.fullname = fullname;
		this.age = age;
		this.gender = gender;
		this.address = address;
		this.postcode = postcode;
		this.ttn = ttn_code;
		this.testresult = test_result;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getFullname() {
		return fullname;
	}

	public void setFullname(String fullname) {
		this.fullname = fullname;
	}

	public String getAge() {
		return age;
	}

	public void setAge(String age) {
		this.age = age;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getPostcode() {
		return postcode;
	}

	public void setPostcode(String postcode) {
		this.postcode = postcode;
	}

	public String getTtn_code() {
		return ttn;
	}

	public void setTtn_code(String ttn_code) {
		this.ttn = ttn_code;
	}

	public String getTest_result() {
		return testresult;
	}

	public void setTest_result(String test_result) {
		this.testresult = test_result;
	}
	

}
