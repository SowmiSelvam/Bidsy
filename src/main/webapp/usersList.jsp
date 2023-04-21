<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="main.java.com.BidsyJava.*"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="user_landing.css">
<title>User List</title>
</head>
<body>

	<div class="logout">
		<label style="float: right" class="logoutLblPos"> <a
			href="user_landing.jsp"><button name="home">Home</button></a>
		</label>
		<form name="form1" method="post" action="logout">
			<label style="float: right" class="logoutLblPos">
				<button name="logout">logout</button>
			</label>
		</form>
	</div>


	<div>
		<%
		String fname = (String) session.getAttribute("fname");
		String lname = (String) session.getAttribute("lname");
		out.print("<label style=\"float: left\" class = \"UserName\">Welcome " + fname + " " + lname + "</label>");
		%>
	</div>
	<div class="user-dashboard">
		<div class="form">
			<table>
				<tr>
					<th>First Name:</th>
					<th>Last Name:</th>
					<th>Email Address:</th>
					<th>Phone Number:</th>
					<th>Address:</th>
					<th>Account Number:</th>
					<th>Routing Number:</th>
					<th>Edit User:</th>
					<th>Delete User:</th>
				</tr>

				<%

				ApplicationDB ap = new ApplicationDB();
				Connection con = ap.getConnection();
				if (request.getParameter("user_id") != null && !request.getParameter("user_id").isEmpty())
				{
					CustomLogger.log("user_id "+request.getParameter("user_id"));
					Statement stmt2 = con.createStatement();
					String sql2 = "Delete from bidsy_user where user_id =\""+request.getParameter("user_id")+"\";";
					stmt2.execute(sql2);
				}
				try {
					Statement stmt = con.createStatement();
					

					String sql = "select user_id, first_name, last_name, address, email, telephone_no, bank_acc_no, routing_no from bidsy_user where is_user = 1;";
					ResultSet rs = stmt.executeQuery(sql);
					int i = 0;
					// loop through the result set and create options for the select element
					while (rs.next()) {
						String first_name = rs.getString("first_name");
						String last_name = rs.getString("last_name");
						String address = rs.getString("address");
						String email = rs.getString("email");
						String user_id = rs.getString("user_id");
						int telephone_no = rs.getInt("telephone_no");
						int bank_acc_no = rs.getInt("bank_acc_no");
						int routing_no = rs.getInt("routing_no");
						
						StringBuilder str = new StringBuilder();

						str.append("<tr><td>").append(first_name).append("</td>")
						.append("<td>").append(last_name).append("</td>")
						.append("<td>").append(email).append("</td>")
						.append("<td>").append(address).append("</td>")
						.append("<td>").append(telephone_no).append("</td>")
						.append("<td>").append(bank_acc_no).append("</td>")
						.append("<td>").append(routing_no).append("</td>")
						.append("<td>").append("<form method=\"post\" action = \"accountEdit.jsp\"><input type=\"text\" name=\"user_id\" class=\"no-outline\" value =\"").append(user_id).append( "\"hidden>")
						.append("<a href=\"accountEdit.jsp\"><button>Edit User</button></a>").append("</form></td>")
						.append("<td>").append("<form method=\"post\" action = \"usersList.jsp\"><input type=\"text\" name=\"user_id\" class=\"no-outline\" value =\"").append(user_id).append( "\"hidden>")
						.append("<a href=\"usersList.jsp\"><button>Delete Auction</button></a>").append("</form></td>");

						out.print(str);
						i++;
					}

				} catch (SQLException e) {
					e.printStackTrace();
				}
				%>
			</table>
		</div>
	</div>
</body>
</html>