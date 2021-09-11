package main;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;






public class DatabaseConnection {
	private static Connection connect = null;
	private static String host = "localhost";
	private static String db = "cw";
	private static String user = "root";
	private static String psw = "jemish1998";

	public static Connection getConnection() {
		if (connect == null) {
			try {
				Class.forName("com.mysql.cj.jdbc.Driver");
				String conn_string = "jdbc:mysql://" + host + "/" + db;
				Connection connect = DriverManager.getConnection(conn_string, user, psw);
				return connect;
			} catch (Exception ex) {
				return null;
			}
		} else {
			return connect;
		}
	}

	public boolean checkAdmin(String email) {
		String sql = "SELECT * from Admin WHERE Username=?";
		boolean user = false;
		try (Connection connect = getConnection(); PreparedStatement pstmt = connect.prepareStatement(sql);) {
			pstmt.setString(1, email);
			try (ResultSet rs = pstmt.executeQuery();) {
				while (rs.next()) {
					user = true;
					break;
				}
			}
		} catch (SQLException ex) {
			ex.printStackTrace();
		}
		return user;
	}

	public AdminUser getUser(String user, String password) {
		String sql = "SELECT * from Admin WHERE Username=? AND PasswordHash=?";
		AdminUser admin = null;
		try (Connection connect = getConnection(); PreparedStatement pstmt = connect.prepareStatement(sql);) {
			pstmt.setString(1, user);
			pstmt.setString(2, HashGenerator.getSHA256(password));
			try (ResultSet rs = pstmt.executeQuery();) {
				while (rs.next()) {
					String uname = rs.getString("UserName");
					String pass = rs.getString("PasswordHash");
					admin = new AdminUser(uname, pass);
					break;
				}
			}
		} catch (SQLException ex) {
			ex.printStackTrace();
		}
		return admin;
	}

	public boolean email_check(String email) {
		String sql = "SELECT * from TestResult WHERE Email=?";
		boolean checkEmail = false;

		try (Connection connect = getConnection(); PreparedStatement pstmt = connect.prepareStatement(sql);) {
			pstmt.setString(1, email);
			try (ResultSet rs = pstmt.executeQuery();) {
				while (rs.next()) {
					checkEmail = true;
					break;
				}
			}
		} catch (SQLException ex) {
			ex.printStackTrace();
		}
		return checkEmail;
	}

	public boolean ttn_check(String ttn_code) {
		String sql = "SELECT * from HomeTestKit WHERE TNN_Code=?";
		boolean checkttn = false;

		try (Connection connect = getConnection(); PreparedStatement pstmt = connect.prepareStatement(sql);) {
			pstmt.setString(1, ttn_code);
			try (ResultSet rs = pstmt.executeQuery();) {
				while (rs.next()) {
					checkttn = true;
					break;
				}
			}
		} catch (SQLException ex) {
			ex.printStackTrace();
		}
		return checkttn;
	}

	public boolean ttnWDEmail(String ttn_code, String email) {
		String sql = "SELECT * from TestResult WHERE TTN=? AND Email=?";
		boolean isfound = false;

		try (Connection connect = getConnection(); PreparedStatement pstmt = connect.prepareStatement(sql);) {
			pstmt.setString(1, ttn_code);
			pstmt.setString(2, email);
			try (ResultSet rs = pstmt.executeQuery();) {
				while (rs.next()) {
					isfound = true;
					break;
				}
			}
		} catch (SQLException ex) {
			ex.printStackTrace();
		}
		return isfound;
	}

	public boolean ttnStatus(String ttn_code) {
		String sql = "SELECT * from HomeTestKit WHERE TNN_Code=?";
		boolean change = false;

		try (Connection connect = getConnection(); PreparedStatement pstmt = connect.prepareStatement(sql);) {
			pstmt.setString(1, ttn_code);
			try (ResultSet rs = pstmt.executeQuery();) {
				while (rs.next()) {
					String used = rs.getString("used");
					if (used.equals("1")) {
						change = true;
					}
					break;
				}
			}
		} catch (SQLException ex) {
			ex.printStackTrace();
		}
		return change;
	}

	public boolean upload(ReportObject model) {
		String sql = "insert into TestResult (Email, Fullname, Age, Gender, Address,Postcode,TTN,TestResult)"
				+ "values (?, ?, ?, ?, ?, ?, ?, ?)";
		boolean insert = false;
		try (Connection connect = getConnection(); PreparedStatement pstmt = connect.prepareStatement(sql);) {
			pstmt.setString(1, model.email);
			pstmt.setString(2, model.fullname);
			pstmt.setString(3, model.age);
			pstmt.setString(4, model.gender);
			pstmt.setString(5, model. address);
			pstmt.setString(6, model.postcode);
			pstmt.setString(7, model.ttn);
			pstmt.setString(8, model.testresult);
			pstmt.execute();
			insert=ttnUpdate(model.ttn);
		} catch (SQLException ex) {
			ex.printStackTrace();
			System.out.println(ex.getMessage());
			return insert;
		}
		return insert;
	}
	
	
	public boolean ttnUpdate(String ttn_code) {
		String sql = "update HomeTestKit set used = ? where TNN_Code = ?";
		boolean update = false;
		try (Connection connect = getConnection(); PreparedStatement pstmt = connect.prepareStatement(sql);) {
			pstmt.setString(1, "1");
			pstmt.setString(2, ttn_code);
			pstmt.execute();
			update=true;
		} catch (SQLException ex) {
			ex.printStackTrace();
			System.out.println(ex.getMessage());
		}
		return update;
	}

	
	public int stillRemainingkits() {
		String sql = "SELECT count(*) from HomeTestKit WHERE used=?";
		int count = 0;

		try (Connection connect = getConnection(); PreparedStatement pstmt = connect.prepareStatement(sql);) {
			pstmt.setString(1, "0");
			try (ResultSet rs = pstmt.executeQuery();) {
				while (rs.next()) {
					count = rs.getInt(1);
				}
			}
		} catch (SQLException ex) {
			ex.printStackTrace();
		}
		return count;
	}

	public int totalKits() {
		String sql = "SELECT count(*) from HomeTestKit";
		int count = 0;

		try (Connection connect = getConnection(); PreparedStatement pstmt = connect.prepareStatement(sql);) {
			try (ResultSet rs = pstmt.executeQuery();) {
				while (rs.next()) {
					count = rs.getInt(1);
				}
			}
		} catch (SQLException ex) {
			ex.printStackTrace();
		}
		return count;
	}

	public int totalsedkits() {
		String sql = "SELECT count(*) from HomeTestKit WHERE used=?";
		int count = 0;

		try (Connection connect = getConnection(); PreparedStatement pstmt = connect.prepareStatement(sql);) {
			pstmt.setString(1, "1");
			try (ResultSet rs = pstmt.executeQuery();) {
				while (rs.next()) {
					count = rs.getInt(1);
				}
			}
		} catch (SQLException ex) {
			ex.printStackTrace();
		}
		return count;
	}

	public int totalRecords(String result) {
		String sql = "SELECT count(*) from TestResult WHERE TestResult=?";
		int count = 0;

		try (Connection connect = getConnection(); PreparedStatement pstmt = connect.prepareStatement(sql);) {
			pstmt.setString(1, result);
			try (ResultSet rs = pstmt.executeQuery();) {
				while (rs.next()) {
					count = rs.getInt(1);
				}
			}
		} catch (SQLException ex) {
			ex.printStackTrace();
		}
		return count;
	}

	public ArrayList<ReportObject> getReportObjectList() {

		String sql = "SELECT * from TestResult";
		ArrayList<ReportObject> list = new ArrayList<ReportObject>();

		try (Connection connect = getConnection(); PreparedStatement pstmt = connect.prepareStatement(sql);) {

			try (ResultSet rs = pstmt.executeQuery();) {
				while (rs.next()) {

					String email = rs.getString("Email");
					String fullname = rs.getString("Fullname");
					String age = rs.getString("Age");
					String gender = rs.getString("Gender");
					String address = rs.getString("Address");
					String postcode = rs.getString("Postcode");
					String ttn = rs.getString("TTN");
					String testresult = rs.getString("TestResult");

					ReportObject model = new ReportObject(email, fullname, age, gender, address, postcode, ttn,
							testresult);
					list.add(model);
				}
			}
		} catch (SQLException ex) {
			ex.printStackTrace();
		}
		return list;
	}

public ArrayList<PostObject> getDatabypostcode() {
		
		String sql = "SELECT COUNT(TestResult) as total, Postcode FROM TestResult WHERE TestResult=? GROUP BY Postcode";
		
		ArrayList<PostObject> datalist=new ArrayList<PostObject>();
		
		try (Connection connect = getConnection(); PreparedStatement pstmt = connect.prepareStatement(sql);) {
			pstmt.setString(1, "Positive");
			
			try (ResultSet rs = pstmt.executeQuery();) {
				while (rs.next()) {
					
					
					String postcode = rs.getString("Postcode");
					int test_result = rs.getInt("total");

					PostObject model = new PostObject(postcode,test_result);
					datalist.add(model);
				}
			}
		} catch (SQLException ex) {
			ex.printStackTrace();
		}
		return datalist;
	}
	
	public static void main(String[] args) {
		DatabaseConnection data = new DatabaseConnection();

		ArrayList<PostObject> list=data.getDatabypostcode();
		System.out.println(list.size()+"");
		for(int i=0;i<list.size();i++) {
			System.out.println( list.get(i).getPostcode()+" :: "+ list.get(i).getPos_case());

		}
	}

}
