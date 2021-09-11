package main;

import java.io.*;
import java.net.InetSocketAddress;
import java.util.concurrent.Executor;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.sun.net.httpserver.HttpContext;
import com.sun.net.httpserver.HttpHandler;
import com.sun.net.httpserver.HttpServer;

public class EmailCheck extends HttpServer {

	public void doGet(HttpServletRequest req, HttpServletResponse res) throws  IOException {
		PrintWriter out = res.getWriter();
		res.setContentType("text/html");

		String email = req.getParameter("email");
System.out.println(email);
		try {
			if (email != null && email.length() != 0) {
				DatabaseConnection checkTTNCode = new DatabaseConnection();
				
				if (checkTTNCode.email_check(email) == true) {
					out.println("{\"email\":true}");
				} else {
					out.println("{\"email\":false}");
				}
			}
		} catch (Exception ex) {
			out.println("{\"message\":\"exception\"}");
		}
		out.close();
	}

	public void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doGet(req, res);
	}

	@Override
	public void bind(InetSocketAddress addr, int backlog) throws IOException {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void start() {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void setExecutor(Executor executor) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public Executor getExecutor() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void stop(int delay) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public HttpContext createContext(String path, HttpHandler handler) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public HttpContext createContext(String path) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void removeContext(String path) throws IllegalArgumentException {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void removeContext(HttpContext context) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public InetSocketAddress getAddress() {
		// TODO Auto-generated method stub
		return null;
	}
	
}
