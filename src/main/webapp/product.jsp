<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="main.java.com.BidsyJava.*"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Product</title>
</head>
<body>

	<%
					try {
						ApplicationDB ap = new ApplicationDB();
						Connection con = ap.getConnection();
						Statement stmt = con.createStatement();
						int item_id = Integer.valueOf(request.getParameter("item_id"));
						//if(item_id == )
						String sql = "select title, itemDescription, item_id, starting_price, start_auction_time, end_auction_time, bid_id  from itemClassifies where item_id ="+item_id+";";
						
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
							
							
							String sql2 = "select bidding_price from bids where bid_id = "+bid_id+";";
							ResultSet rs2 = stmt.executeQuery(sql2);
							
							int bidding_price = 0;
							while(rs2.next()){
								bidding_price = rs2.getInt("bidding_price");
								
							}
							StringBuilder str = new StringBuilder();
							str.append("<div class=\"user-dashboard\">")
							.append("<div class=\"form\">")
							.append("<tr><td>Title:</td><td>").append(title).append("</td></tr><tr><td>Item Description:</td><td>")
							.append(itemDescription) .append("</td></tr><tr><td>Start Auction Time:</td><td>")
							.append(String.valueOf(start_auction_time)).append("</td></tr><tr><td>End Auction Time:</td><td>")
							.append(String.valueOf(end_auction_time)) .append("</td></tr><tr><td>Bid ID:</td><td>")
							.append(String.valueOf(bid_id)) .append("</td></tr><tr><td>Starting Price:</td><td>")
							.append(String.valueOf(starting_price)) 
							.append("</td></tr></table></div>");
							
							out.print(str);
							i++;
						}
						
					} catch (SQLException e) {
						e.printStackTrace();
					}			
	
	%>



</body>
</html>