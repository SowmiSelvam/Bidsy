<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="main.java.com.BidsyJava.*"%>
<%@ page import="main.java.com.BidsyJava.CustomLogger"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="user_landing.css">
<title>Edit Account</title>
</head>
<body>
	<div class="user-dashboard">
		<div class="form">
			<table>
				<tr>
					<th></th>
					<th></th>
				</tr>

				<%
				CustomLogger.log(request.getParameter("user_id"));
				String user_id = String.valueOf(request.getParameter("user_id"));
				ApplicationDB ap = new ApplicationDB();
				Connection con = ap.getConnection();
				try {

					Statement stmt = con.createStatement();
					CustomLogger.log("user_id:" + request.getParameter("user_id"));
					String sql = "select first_name, last_name, address, email, telephone_no, bank_acc_no, routing_no from bidsy_user where user_id=\""
					+ request.getParameter("user_id") + "\";";

					ResultSet rs = stmt.executeQuery(sql);
					// loop through the result set and create options for the select element
					while (rs.next()) {
						String first_name = rs.getString("first_name");
						String last_name = rs.getString("last_name");
						String address = rs.getString("address");
						String email = rs.getString("email");
						int telephone_no = rs.getInt("telephone_no");
						int bank_acc_no = rs.getInt("bank_acc_no");
						int routing_no = rs.getInt("routing_no");
						
						StringBuilder str = new StringBuilder();
						
						str.append("<tr><td>First Name:</td><td>").append(first_name).append("</td></tr>")
						.append("<tr><td>Last Name:</td><td>").append(last_name).append("</td></tr>")
						.append("<tr><td>Email:</td><td>").append(email).append("</td></tr>")
						.append("<tr><td>Address:</td><td>").append(address).append("</td></tr>")
						.append("<tr><td>Phone Number:</td><td>").append(telephone_no).append("</td></tr>")
						.append("<tr><td>Bank Account Number:</td><td>").append(bank_acc_no).append("</td></tr>")
						.append("<tr><td>Routing Number:</td><td>").append(routing_no).append("</td></tr>");

						out.print(str);
				%>
			</table>
			<%
			}

			} catch (SQLException e) {
			e.printStackTrace();
			} finally {
			ap.closeConnection(con);
			}
			%>
		</div>
	</div>
</body>
</html>