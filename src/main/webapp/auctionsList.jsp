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
<title>Auction List</title>
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
					<th>Title:</th>
					<th>Description:</th>
					<th>Starting Price:</th>
					<th>Current Bidding Price:</th>
					<th>Auction Duration:</th>
					<th>View Product</th>
					<th>Delete Product</th>
				</tr>

				<%

				ApplicationDB ap = new ApplicationDB();
				Connection con = ap.getConnection();
				if (request.getParameter("item_id") != null && !request.getParameter("item_id").isEmpty())
				{
					Statement stmt2 = con.createStatement();
					String sql2 = "Delete from itemClassifies where item_id ="+request.getParameter("item_id")+";";
					stmt2.execute(sql2);
				}
				try {
					Statement stmt = con.createStatement();
					

					String sql = "select title, itemDescription, item_id, starting_price, start_auction_time, end_auction_time, bid_id  from itemClassifies;";
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
						.append("<td>").append("<form method=\"post\" action = \"productEdit.jsp\"><input type=\"text\" name=\"item_id\" class=\"no-outline\" value =\"").append(item_id).append( "\"hidden>")
						.append("<a href=\"productEdit.jsp\"><button>View Auction</button></a>").append("</form></td>")
						.append("<td>").append("<form method=\"post\" action = \"auctionsList.jsp\"><input type=\"text\" name=\"item_id\" class=\"no-outline\" value =\"").append(item_id).append( "\"hidden>")
						.append("<a href=\"auctionsList.jsp\"><button>Delete Auction</button></a>").append("</form></td>");
	//create a product page with edit
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