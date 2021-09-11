package main;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/AdminLogin")
public class Login extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public Login() {
		super();
		// TODO Auto-generated constructor stub
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		PrintWriter out = response.getWriter();
		String name = request.getParameter("email");
		String psw = request.getParameter("psw");

		DatabaseConnection db = new DatabaseConnection();
		if (db.checkAdmin(name)) {
			AdminUser u = db.getUser(name, psw);
			HttpSession se = request.getSession();
			if (u != null) {
				se.setAttribute("User", u);
				out.println("{\"login\":true}");
			} else {
				out.println("{\"login\":false}");
			}
		} else {
			out.println("{\"admin\":false}");
		}
		out.close();
	}

}
