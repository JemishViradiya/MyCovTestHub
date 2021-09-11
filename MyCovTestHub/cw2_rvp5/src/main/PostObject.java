package main;

public class PostObject {
	String postcode;
	int count;

	
	public PostObject(String postcode, int pos_case) {
		super();
		this.postcode = postcode;
		this.count = pos_case;
	}

	public String getPostcode() {
		return postcode;
	}

	public void setPostcode(String postcode) {
		this.postcode = postcode;
	}

	public int getPos_case() {
		return count;
	}

	public void setPos_case(int pos_case) {
		this.count = pos_case;
	}
	
	
}
