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
<link rel="stylesheet" href="signup.css">
<title>Edit Account</title>
</head>
<body>
	<div class="back">
		<label> <a href="usersList.jsp"><button
					name="back">Back</button></a>
		</label>
	</div>
	<div class="logout">
		<form name="form1" method="post" action="logout">
			<label style="float: right" class="logoutLblPos">
				<button name="logout">logout</button>
			</label>
		</form>
	</div>
	<%
	String user_id = String.valueOf(request.getParameter("user_id"));
	ApplicationDB ap = new ApplicationDB();
	Connection con = ap.getConnection();
	CustomLogger.log("first_name:" + request.getParameter("first_name"));
	if (request.getParameter("first_name") != null && !request.getParameter("first_name").isEmpty()) {
		PreparedStatement ps = con.prepareStatement(
		"update bidsy_user set first_name = ?, last_name = ?, email= ?, telephone_no= ?, bank_acc_no= ?, routing_no= ?, address=? where user_id=?");
		ps.setString(1, request.getParameter("first_name"));
		ps.setString(2, request.getParameter("last_name"));
		ps.setString(3, request.getParameter("email"));
		ps.setString(4, request.getParameter("telephone_no"));
		ps.setString(5, request.getParameter("bank_acc_no"));
		ps.setString(7, request.getParameter("address"));
		ps.setString(6, request.getParameter("routing_no"));
		ps.setString(8, user_id);

		int x = ps.executeUpdate();
		if (x > 0) {
			CustomLogger.log("Updated Details");
	%>
	<div>
		<label><b>Account Edited Successfully.</b></label>
	</div>
	<%
	}

	}
	%>
	<div class="user-dashboard">
		<div class="form">
			<form class="register-form" method="post" action='accountEdit.jsp'>


				<%
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

						str.append("<input type = \"text\" name= \"user_id\" value=\"").append(user_id).append("\" hidden><br/>")
						.append("<label>First Name:</label><input type = \"text\" name= \"first_name\" value=\"")
						.append(first_name).append("\"><br/>")
						.append("<label>Last Name:</label><input type = \"text\" name= \"last_name\" value=\"")
						.append(last_name).append("\"><br/>")
						.append("<label>Email:</label><input type = \"text\" name= \"email\" value=\"").append(email)
						.append("\"><br/>").append("<label>Address:</label><input type = \"text\" name= \"address\" value=\"")
						.append(address).append("\"><br/>")
						.append("<label>Phone Number:</label><input type = \"text\" name= \"telephone_no\" value=\"")
						.append(telephone_no).append("\"><br/>")
						.append("<label>Bank Account Number:</label><input type = \"text\" name= \"bank_acc_no\" value=\"")
						.append(bank_acc_no).append("\"><br/>")
						.append("<label>Routing Number:</label><input type = \"text\" name= \"routing_no\" value=\"")
						.append(routing_no).append("\"><br/>");

						out.print(str);
					}

				} catch (SQLException e) {
					e.printStackTrace();
				} finally {
					ap.closeConnection(con);
				}
				%>

				<button>Edit</button>
			</form>
		</div>
	</div>
</body>
</html>