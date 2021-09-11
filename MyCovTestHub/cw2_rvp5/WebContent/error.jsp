<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="main.*"%>
<html>
<head>
<title>error</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script
	src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</head>

<body>
	
	<%
			HttpSession se = request.getSession();
			AdminUser u = null;
			String errorMsg = "Access denied";

			if (se.getAttribute("User") != null) {
				response.sendRedirect("dashboard.jsp");
			}
		%>
	
	<div>
		<label  style="color:red"><%=errorMsg%></label> </br><label>Please <a
			href="Login.html">Login</a> or </label>
			<label>Go-Back to <a
			href="webhome.html">Home</a></label>
	</div>
</body>
</html>
