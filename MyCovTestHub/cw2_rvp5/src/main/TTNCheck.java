package main;

import java.io.*;

import javax.servlet.*; 
import javax.servlet.http.*;

public class TTNCheck extends HttpServlet {
	
	public void doGet(HttpServletRequest req, 
			        HttpServletResponse res) 
	            throws ServletException, IOException {
		PrintWriter out = res.getWriter();
		res.setContentType("text/html");

		String ttn=req.getParameter("ttn");
		System.out.println(ttn);
		try{
			if(ttn!=null && ttn.length()!=0){
				DatabaseConnection checkTTNCode=new DatabaseConnection();
				if(checkTTNCode.ttn_check(ttn)==true){
					if(checkTTNCode.ttnStatus(ttn)) {
						out.println("{\"used\":true}");
						System.out.println("true");
					}else {
						out.println("{\"ttn\":true}");
					}
				}else{
					out.println("{\"ttn\":false}");
				}
			}
		}catch(Exception ex){
			out.println("{\"message\":\"exception\"}");	
			System.out.println("Exception ex");
		}
		out.close();
	}
	public void doPost(HttpServletRequest req, 
				HttpServletResponse res) 
	            throws ServletException, IOException {
		doGet(req, res);
	}
}

