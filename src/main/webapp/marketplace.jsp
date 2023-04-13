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
<title>User Landing</title>
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
			out.print("<label style=\"float: left\" class = \"UserName\">Welcome " + fname + " " + lname+"</label>");
			%>
	</div>

	<%
					try {
						ApplicationDB ap = new ApplicationDB();
						Connection con = ap.getConnection();
						Statement stmt = con.createStatement();
						
						String sql = "select title, itemDescription, item_id, starting_price, start_auction_time, end_auction_time, bid_id  from itemClassifies where end_auction_time > current_timestamp();";
						ResultSet rs = stmt.executeQuery(sql);
						int i = 0;
						// loop through the result set and create options for the select element
						while (rs.next()) {
							String title = rs.getString("title");
							String itemDescription = rs.getString("itemDescription");
							Timestamp start_auction_time =  rs.getTimestamp("start_auction_time");
							Timestamp end_auction_time =  rs.getTimestamp("end_auction_time");
							int bid_id = rs.getInt("bid_id");
							int starting_price = rs.getInt("starting_price");
							int item_id = rs.getInt("item_id");
							
							
							String sql2 = "select bidding_price from bids where bid_id = "+bid_id+";";
							ResultSet rs2 = stmt.executeQuery(sql2);
							
							int bidding_price = 0;
							while(rs2.next()){
								bidding_price = rs2.getInt("bidding_price");
								
							}
							StringBuilder str = new StringBuilder();
							str.append("<div class=\"user-dashboard\">")
							.append("<div class=\"form\">")
							.append("<form method=\"post\" action = \"product.jsp\">")
							.append("<label id=\"productName\">").append(title) .append("</label>")
							.append("<br/><label id=\"productDescription\"> Description: ").append(itemDescription) .append("</label>")
							.append("<br/><label id=\"productStartingPrice\"> Starting Price:").append(String.valueOf(starting_price)) .append("</label>")
							.append("<br/><label id=\"productBiddingPrice\"> Current Bid: ").append(String.valueOf(bidding_price)) .append("</label>")										
							.append("<br/><label id=\"auctionDuration\">").append(String.valueOf(start_auction_time)) .append(" to ").append(String.valueOf(end_auction_time)) .append("</label>")
							.append("<input type=\"hidden\" name = \"ItemId\" value = \"").append(item_id).append("\" disabled>")
							.append("<br/><a href=\"product.jsp\"><button>View Product</button></a>")
							.append("</form></div></div>");
							
							out.print(str);
							i++;
						}
						
					} catch (SQLException e) {
						e.printStackTrace();
					}

			
	
	%>
</body>
</html>