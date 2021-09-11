<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@ page import="java.util.*,java.sql.*"%>
<%@ page import="com.google.gson.Gson"%>
<%@ page import="com.google.gson.JsonObject"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="main.*,java.util.ArrayList"%>

<%
	HttpSession se = request.getSession();
AdminUser u = null;

if (se.getAttribute("User") != null) {
	u = (AdminUser) se.getAttribute("User");
} else {
	response.sendRedirect("error.jsp");
}
if (u != null) {
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="generator" content="Mobirise v4.6.4, mobirise.com">
<meta name="viewport"
	content="width=device-width, initial-scale=1, minimum-scale=1">
<link rel="shortcut icon" href="assets/images/jay-corona-1181x1181.png"
	type="image/x-icon">
<meta name="description" content="">
<title>Home</title>
<link rel="stylesheet" href="assets/bootstrap/css/bootstrap.min.css">
<link rel="stylesheet"
	href="assets/bootstrap/css/bootstrap-grid.min.css">
<link rel="stylesheet"
	href="assets/bootstrap/css/bootstrap-reboot.min.css">
<link rel="stylesheet" href="assets/dropdown/css/style.css">
<link rel="stylesheet"
	href="assets/as-pie-progress/css/progress.min.css">
<link rel="stylesheet" href="assets/theme/css/style.css">
<link rel="stylesheet" href="assets/mobirise/css/mbr-additional.css"
	type="text/css">



</head>

<%int count = 0;
int kitcount = 0;
int Usedkits = 0;
int Pos = 0;
int Neg = 0;
int Inc = 0;

DatabaseConnection db = new DatabaseConnection();

count = db.totalKits();
kitcount = db.stillRemainingkits();
Usedkits = db.totalsedkits();
Pos = db.totalRecords("Positive");
Neg = db.totalRecords("Negative");
Inc = db.totalRecords("Inconclusive");

int kitcountpr = (int) Math.round((kitcount * 100) / count);
int Usedkitspr = (int) Math.round((Usedkits * 100) / count);
int Pospr = (int) Math.round((Pos * 100) / count);
int Negpr = (int) Math.round((Neg * 100) / count);
int Incpr = (int) Math.round((Inc * 100) / count);
%>



<body>

	<h2 style="color: #f44336;">MyCoVTestHub DashBoard</h2>



	<div class="container">
		<div class="row">
			<div class="col-sm-3 col-md-6 col-lg-4"
				style="color: #10343c; font-size: 16px">
				Hello,
				<%=u.getName()%>!
			</div>
			<div class="col-sm-9 col-md-6 col-lg-8">
				<a href="./servlets/Logout" style="float: right; font-size: 16px">Logout</a>
			</div>
		</div>
		<section class="progress-bars3 cid-si4AFdrhWo" id="progress-bars3-1q">
			<h2
				class="mbr-section-title pb-3 align-center mbr-fonts-style display-2"
				style="color: #10343c">Demographics statistics</h2>

			<h3 class="mbr-section-subtitle mbr-fonts-style display-5">Test
				result analysis and test-kits tracking</h3>

			<div class="media-container-row pt-5 mt-2">
				<div class="card p-3 align-center">
					<div class="wrap">
						<div class="pie_progress progress1" role="progressbar"
							data-goal="<%=kitcountpr%>">
							<p class="pie_progress__number mbr-fonts-style display-5"></p>
						</div>
					</div>
					<div class="mbr-crt-title pt-3">
						<h4 class="card-title py-2 mbr-fonts-style display-5"
							style="color: #3366cb">Available-Kits</h4>
					</div>
				</div>

				<div class="card p-3 align-center">
					<div class="wrap">
						<div class="pie_progress progress2" role="progressbar"
							data-goal="<%=Usedkitspr%>">
							<p class="pie_progress__number mbr-fonts-style display-5"></p>
						</div>
					</div>
					<div class="mbr-crt-title pt-3">
						<h4 class="card-title py-2 mbr-fonts-style display-5"
							style="color: #d9534e">Usedkits</h4>
					</div>
				</div>

				<div class="card p-3 align-center">
					<div class="wrap">
						<div class="pie_progress progress3" role="progressbar"
							data-goal="<%=Pospr%>">
							<p class="pie_progress__number mbr-fonts-style display-5"></p>
						</div>
					</div>
					<div class="mbr-crt-title pt-3">
						<h4 class="card-title py-2 mbr-fonts-style display-5"
							style="color: #f0ad4e">Positive cases</h4>
					</div>
				</div>

				<div class="card p-3 align-center">
					<div class="wrap">
						<div class="pie_progress progress3" role="progressbar"
							data-goal="<%=Negpr%>">
							<p class="pie_progress__number mbr-fonts-style display-5"></p>
						</div>
					</div>
					<div class="mbr-crt-title pt-3">
						<h4 class="card-title py-2 mbr-fonts-style display-5"
							style="color: #5cb85b">Negative cases</h4>
					</div>
				</div>
				<div class="card p-3 align-center">
					<div class="wrap">
						<div class="pie_progress progress3" role="progressbar"
							data-goal="<%=Incpr%>">
							<p class="pie_progress__number mbr-fonts-style display-5"></p>
						</div>
					</div>
					<div class="mbr-crt-title pt-3">
						<h4 class="card-title py-2 mbr-fonts-style display-5"
							style="color: #5bc0de">Inconclusive cases</h4>
					</div>
				</div>


			</div>
		</section>
	</div>



	<script src="assets/web/assets/jquery/jquery.min.js"></script>
	<script src="assets/tether/tether.min.js"></script>
	<script src="assets/popper/popper.min.js"></script>
	<script src="assets/bootstrap/js/bootstrap.min.js"></script>
	<script src="assets/as-pie-progress/jquery-as-pie-progress.min.js"></script>
	<script src="assets/theme/js/script.js"></script>

	<div id="scrollToTop" class="scrollToTop mbr-arrow-up">
		<a style="text-align: center;"><i></i></a>
	</div>
	<div class="container">



		<h4 style="color: #10343c;">Infection rate & Positive cases
			distribution</h4>
		<div class="row">
			<div class="col-sm-6">
				<div class="card"
					style="display: table; margin-right: auto; margin-left: auto;">
					<h5 style="color: #3366cb;">
						<strong>Real-time statistics of cases</strong>
					</h5>
					<div id="piechart"></div>

					<script type="text/javascript"
						src="https://www.gstatic.com/charts/loader.js"></script>

					<script type="text/javascript">
						// Load google charts
						google.charts.load('current', {
							'packages' : [ 'corechart' ]
						});
						google.charts.setOnLoadCallback(drawChart);

						// Draw the chart and set the chart values
						function drawChart() {
							var data = [];
							var Header = [ 'case', 'percentage', {
								role : 'style'
							} ];

							data.push(Header);

							var data = google.visualization.arrayToDataTable([

							[ 'case', 'percentage' ], [ 'Positive',
					<%=Pos%>
						],
									[ 'Negative',
					<%=Neg%>
						],
									[ 'Inconclusive',
					<%=Inc%>
						]

							]);

							// Optional; add a title and set the width and height of the chart
							var options = {
								'title' : 'Reported Test result',
								'width' : 400,
								'height' : 300
							};

							var chart = new google.visualization.PieChart(
									document.getElementById('piechart'));
							chart.draw(data, options);
						}
					</script>
				</div>
			</div>
			<div class="col-sm-6">
				<div class="card" style="overflow-x: auto;">
					<h5 style="color: #3366cb;">
						<strong>Positive cases distribution by postcode</strong>
					</h5>
					<div class="table-wrap">
						<table class="table" style="background-color: white;">

							<thead>
								<tr style="background-color: #10343c; color: white;">
									<th style="text-align: center">PostCode</th>
									<th style="text-align: center">Positive Cases</th>
								</tr>
							</thead>
							<%
								ArrayList<PostObject> list = db.getDatabypostcode();
							for (int i = 0; i < list.size(); i++) {
								String postcode = list.get(i).getPostcode();
								int pos_c = list.get(i).getPos_case();
							%>
							<tbody>
								<tr>
									<td><%=postcode%></td>
									<td><%=pos_c%></td>
								</tr>
							</tbody>
							<%
								}
							%>
						</table>
					</div>
				</div>
			</div>

		</div>

		<h4 style="color: #10343c;">Full Data about MyCoVTest Hub</h4>

		<div class="row">

			<div class="card" style="overflow-x: auto;">
				<div class="table-wrap">
					<table class="table" style="background-color: white;">

						<thead>
							<tr style="background-color: #10343c; color: white;">
								<th style="text-align: center">Email</th>
								<th style="text-align: center">Fullname</th>
								<th style="text-align: center">Age</th>
								<th style="text-align: center">Gender</th>
								<th style="text-align: center">Address</th>
								<th style="text-align: center">Postcode</th>
								<th style="text-align: center">TTN</th>
								<th style="text-align: center">TestResult</th>
							</tr>
						</thead>
						<%
							ArrayList<ReportObject> datalist = db.getReportObjectList();
						for (int i = 0; i < datalist.size(); i++) {
						%>
						<tbody>
							<tr>
								<td><%=datalist.get(i).getEmail()%></td>
								<td><%=datalist.get(i).getFullname()%></td>
								<td><%=datalist.get(i).getAge()%></td>
								<td><%=datalist.get(i).getGender()%></td>
								<td><%=datalist.get(i).getAddress()%></td>
								<td><%=datalist.get(i).getPostcode()%></td>
								<td><%=datalist.get(i).getTtn_code()%></td>
								<td><%=datalist.get(i).getTest_result()%></td>
							</tr>
						</tbody>
						<%
							}
						}
						%>
					</table>
				</div>
			</div>
		</div>
	</div>


</body>

</html>
