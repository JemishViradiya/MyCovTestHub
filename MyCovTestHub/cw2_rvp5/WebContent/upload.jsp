<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<html>

<head>
<title>Report</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script
	src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

</head>


<body style="background-image: url('assets/images/mbr-1920x1080.jpg');">

	<div class="container">
		<h2 style="color: #f44336;">Upload Report</h2>
		</br>
		<form class="form-horizontal" id="form">

			<div class="form-group">
				<label class="control-label col-sm-2" for="email">Email:</label>
				<div class="col-sm-10">
					<input class="form-control" type="email" id="email" name="email"
						placeholder="Your Email" required
						pattern="^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$"
						title="Please enter valid Email">
				</div>
			</div>

			<div class="form-group">
				<label class="control-label col-sm-2" for="fname">Full name:</label>
				<div class="col-sm-10">
					<input type="text" class="form-control" id="fname"
						placeholder="Enter full name" name="fname" required>
				</div>
			</div>

			<div class="form-group">
				<label class="control-label col-sm-2" for="age">Age:</label>
				<div class="col-sm-10">
					<input class="form-control" type="text" id="age" name="age"
						placeholder="Your Age" required
						pattern="^(?:1[01][0-9]|120|1[7-9]|[2-9][0-9])$"
						title="Please enter valid age number">
				</div>
			</div>


			<div class="form-group">
				<label class="control-label col-sm-2" for="gender">Gender:</label>
				<div class="col-sm-10">
					<input type="radio" id="male" name="gender" value="M" required>
					<label for="male">Male</label> <input type="radio" id="female"
						name="gender" value="F"> <label for="female">Female</label>
					<input type="radio" id="other" name="gender" value="O"> <label
						for="other">Other</label>
				</div>
			</div>


			<div class="form-group">
				<label class="control-label col-sm-2" for="add">Address:</label>
				<div class="col-sm-10">
					<input class="form-control" type="text" id="add" name="add"
						placeholder="Your Address" required>
				</div>
			</div>

			<div class="form-group">
				<label class="control-label col-sm-2" for="postcode">Postcode:</label>
				<div class="col-sm-10">
					<input class="form-control" type="text" id="postcode"
						name="postcode" placeholder="Your postcode"
						pattern="([Gg][Ii][Rr] 0[Aa]{2})|((([A-Za-z][0-9]{1,2})|(([A-Za-z][A-Ha-hJ-Yj-y][0-9]{1,2})|(([A-Za-z][0-9][A-Za-z])|([A-Za-z][A-Ha-hJ-Yj-y][0-9][A-Za-z]?))))\s?[0-9][A-Za-z]{2})"
						title="Please enter valid UK postCode (ex:Le4 5bg)" required>
				</div>
			</div>

			<div class="form-group">
				<label class="control-label col-sm-2" for="ttncode">TTN
					Code:</label>
				<div class="col-sm-10">
					<input class="form-control" type="text" id="ttncode" name="ttncode"
						placeholder="Your TTN Code" required>
				</div>
			</div>

			<div class="form-group">
				<label class="control-label col-sm-2" for="testresult">Test
					result:</label>
				<div class="col-sm-10">
					<select id="testresult" name="testresult" required>
						<option value="">Select Your test result</option>
						<option value="Positive">Positive</option>
						<option value="Negative">Negative</option>
						<option value="Inconclusive">Inconclusive</option>
					</select>
				</div>
			</div>

			<div class="form-group">
				<div class="col-sm-offset-2 col-sm-10">
					<button type="submit" class="btn btn-default" name="submit"
						id="submit" style="border: 1px solid #f44336">Upload
						Report</button>
				</div>
			</div>
		</form>
		<div class="alert alert-success" id="success" style="display: none">
		</div>
		<div class="alert alert-warning" id="error" style="display: none">
		</div>

	</div>













	<script>
		$(function() {

			var successmsg = $("#success");
			var failmsg = $("#error");
			var email_error = false;
			var ttn_error = false;
			var ttn_msg = "";
			var email_msg = "";

			$("#email")
					.change(
							function() {
								$
										.ajax({
											type : "POST",
											url : "./servlets/EmailCheck",
											data : {
												email : $("#email").val()
											},
											success : function(result) {
												var ret = jQuery
														.parseJSON(result);

												if (ret.email == true) {
													email_msg = "The provided email is already associated with another (used) Home Test Kit";
													failmsg
															.html("The provided email is already associated with another (used) Home Test Kit");
													failmsg.show();
													email_error = true;

													$("#submit").prop(
															'disabled', true);

												} else {
													email_error = false;

													if (ttn_error == true) {
														failmsg.html(ttn_msg);
														failmsg.show();
													} else {
														failmsg.hide();
														$("#submit").prop(
																'disabled',
																false);
													}
												}
											},
											error : function() {
												alert("failure");
											}
										});
							});

			$("#ttncode")
					.change(
							function() {
								$
										.ajax({
											type : "POST",
											url : "./servlets/TTNCheck",
											data : {
												ttn : $("#ttncode").val()
											},
											success : function(result) {
												var ret = jQuery
														.parseJSON(result);

												if (ret.used == true) {
													ttn_error = true;
													ttn_msg = "Another person has already used the provided TTN code";
													failmsg
															.html("Another person has already used the provided TTN code");
													failmsg.show();
													$("#submit").prop(
															'disabled', true);

												} else if (ret.ttn == false) {
													ttn_error = true;
													ttn_msg = "TTN code does not match the record in the database";
													failmsg
															.html("TTN code does not match the record in the database");
													failmsg.show();
													$("#submit").prop(
															'disabled', true);

												} else {
													ttn_error = false;
													successmsg
															.html("TTN code successfully match in Record");
													successmsg.show();
													if (email_error == true) {
														failmsg.html(email_msg);
														failmsg.show();
													} else {
														failmsg.hide();
														$("#submit").prop(
																'disabled',
																false);
													}
												}
											},
											error : function() {
												alert("failure");
											}
										});
							});

			$("#form").submit(function(e) {
				e.preventDefault();
				$.ajax({
					type : "POST",
					url : "./servlets/Upload",
					data : {
						email : $("#email").val(),
						fname : $("#fname").val(),
						age : $("#age").val(),
						gender : $("input[name='gender']:checked").val(),
						address : $("#add").val(),
						postcode : $("#postcode").val(),
						ttncode : $("#ttncode").val(),
						testresult : $("#testresult").val()
					},
					success : function(result) {
						var ret = jQuery.parseJSON(result);

						successmsg.hide();
						failmsg.hide();

						if (ret.upload == true) {
							successmsg.html("Uploaded successfully");
							successmsg.show();
							$('#form').trigger("reset");
						} else {
							failmsg.html("Uploading Faild!");
							failmsg.show();
						}
					},
					error : function(result) {
						alert("failure");
					}
				});
			});

		});
	</script>
</body>
</html>
