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
<link rel="stylesheet" href="marketplace.css">
<title>Similar Items</title>
</head>
<body>

<%				int prod_item_id = Integer.valueOf(request.getParameter("item_id"));%>
	<div class="back">
	<form name="form1" method="post" action="product.jsp">
		<label>
		<input type="text" name="item_id" class="no-outline" value ="<%=prod_item_id%>" hidden>
		<a href="product.jsp"><button
					name="back">Back</button></a>
		</label>
		</form>
	</div>
	<div class="logout">
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
	<div>
	<br>
	<br>
	</div>
	<div class="user-dashboard">
		<div class="form">
			<table>
				<tr>
					<th>Title:</th>
					<th>Description:</th>
					<th>Starting Price:</th>
					<th>Current Bidding Price:</th>
					<th>Auction Duration:</th>
					<th>View Product</th>
				</tr>

				<%
				int sub_category_index = Integer.valueOf(request.getParameter("sub_category_index"));
				try {
					ApplicationDB ap = new ApplicationDB();
					Connection con = ap.getConnection();
					Statement stmt = con.createStatement();
					

					String sql = "select title, itemDescription, item_id, starting_price, start_auction_time, end_auction_time, bid_id "
							+"from itemClassifies where end_auction_time > current_timestamp() and start_auction_time < current_timestamp() "+
							"and sub_category_index = "+sub_category_index+" and email not like '"+ session.getAttribute("user")+"';";
					ResultSet rs = stmt.executeQuery(sql);
					int i = 0;
					// loop through the result set and create options for the select element
					while (rs.next()) {
						String title = rs.getString("title");
						String itemDescription = rs.getString("itemDescription");
						Timestamp start_auction_time = rs.getTimestamp("start_auction_time");
						Timestamp end_auction_time = rs.getTimestamp("end_auction_time");
						int bid_id = rs.getInt("bid_id");
						int starting_price = rs.getInt("starting_price");
						int item_id = rs.getInt("item_id");
						
						Statement stmt2 = con.createStatement();
						String sql2 = "select bidding_price from bids where bid_id = " + bid_id + ";";
						ResultSet rs2 = stmt2.executeQuery(sql2);

						int bidding_price = 0;
						while (rs2.next()) {
					bidding_price = rs2.getInt("bidding_price");

						}
						StringBuilder str = new StringBuilder();

						str.append("<tr><td>").append(title).append("</td>")
						.append("<td>").append(itemDescription).append("</td>")
						.append("<td>").append(String.valueOf(starting_price)).append("</td>")
						.append("<td>").append(String.valueOf(bidding_price)).append("</td>")
						.append("<td>").append(String.valueOf(start_auction_time)).append(" to ").append(String.valueOf(end_auction_time)).append("</td>")
						.append("<td>").append("<form method=\"post\" action = \"product.jsp\"><input type=\"text\" name=\"item_id\" class=\"no-outline\" value =\"").append(item_id).append( "\"hidden>")
						.append("<a href=\"product.jsp\"><button>View Product</button></a>").append("</form>");

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