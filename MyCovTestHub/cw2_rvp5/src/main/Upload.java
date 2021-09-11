package main;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;



@WebServlet("/Report")
public class Upload extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		// TODO Auto-generated method stub

		PrintWriter out = response.getWriter();

		String email = request.getParameter("email");
		String fullname = request.getParameter("fname");
		String age = request.getParameter("age");
		String gender = request.getParameter("gender");
		String address = request.getParameter("address");
		String postcode = request.getParameter("postcode");
		String ttn_code = request.getParameter("ttncode");
		String test_result = request.getParameter("testresult");

		System.out.println(" " + email + " " + fullname + " " + age + " " + gender + " " + address + " " + postcode
				+ " " + ttn_code + " " + test_result);

		ReportObject model = new ReportObject(email, fullname, age, gender, address, postcode, ttn_code, test_result);

		DatabaseConnection db = new DatabaseConnection();

		try {
			if (db.upload(model)) {
				out.println("{\"upload\":true}");
			} else {
				out.println("{\"upload\":false}");
			}
		} catch (Exception ex) {
			out.println("{\"message\":\"exception\"}");
		}

		out.close();

	}

}
