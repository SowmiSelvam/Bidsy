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
<title>Product</title>
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
				CustomLogger.log(request.getParameter("item_id"));
				int item_id = Integer.valueOf(request.getParameter("item_id"));
				ApplicationDB ap = new ApplicationDB();
				Connection con = ap.getConnection();
				try {

					Statement stmt = con.createStatement();
					CustomLogger.log("item_id:" + request.getParameter("item_id"));
					String sql = "select title, email, sub_category_index, itemDescription, item_id, starting_price, start_auction_time, end_auction_time, bid_id  from itemClassifies where item_id ="
					+ item_id + ";";

					ResultSet rs = stmt.executeQuery(sql);
					// loop through the result set and create options for the select element
					while (rs.next()) {
						String title = rs.getString("title");
						String itemDescription = rs.getString("itemDescription");
						Timestamp start_auction_time = rs.getTimestamp("start_auction_time");
						Timestamp end_auction_time = rs.getTimestamp("end_auction_time");
						int bid_id = rs.getInt("bid_id");
						int starting_price = rs.getInt("starting_price");
						String email = rs.getString("email");
						int sub_category_index = rs.getInt("sub_category_index");

						Statement stmt2 = con.createStatement();
						String sql2 = "select bidding_price from bids where bid_id = " + bid_id + ";";
						ResultSet rs2 = stmt2.executeQuery(sql2);

						int bidding_price = 0;
						while (rs2.next()) {
					bidding_price = rs2.getInt("bidding_price");

						}
						StringBuilder str = new StringBuilder();

						str.append("<tr><td>Title:</td><td>").append(title).append("</td></tr>")
						.append("<tr><td>Item Description:</td><td>").append(itemDescription).append("</td></tr>")
						.append("<tr><td>Starting Price:</td><td>").append(String.valueOf(starting_price)).append("</td></tr>")
						.append("<tr><td>Current Bidding Price:</td><td id=").append("\"currBiddingPrice\">")
						.append(String.valueOf(bidding_price)).append("</td></tr>")
						.append("<tr><td>Start Auction Time:</td><td>").append(String.valueOf(start_auction_time))
						.append("</td></tr>").append("<tr><td>End Auction Time:</td><td>")
						.append(String.valueOf(end_auction_time)).append("</td></tr>");

						out.print(str);
				%>
			</table>
			<br />

			<div>
				<table>
					<tr>
						<th>Questions</th>
						<th>Answers</th>
					</tr>

					<%
					try {
						if (request.getParameter("answer") != null && !request.getParameter("answer").isEmpty()) {
							PreparedStatement ps = con.prepareStatement(
							"update comments_inEditsContainsQnA set answer = ?, a_user_id = ? where item_id = ? and q_user_id = ? and date_time = ?;");
							ps.setString(1, request.getParameter("answer"));
							ps.setString(2, (String) session.getAttribute("user"));
							ps.setString(3, request.getParameter("item_id"));
							ps.setString(4, request.getParameter("questionUser"));
							ps.setString(5, request.getParameter("date_time"));

							int x = ps.executeUpdate();
							if (x > 0) {
						CustomLogger.log("Updated Answers");

							}
						}

						Statement stmt3 = con.createStatement();
						CustomLogger.log(String.valueOf(item_id));
						String sql3 = "select q_user_id, question, answer, date_time from comments_inEditsContainsQnA where item_id =" + item_id + ";";
						ResultSet rs3 = stmt3.executeQuery(sql3);
						// loop through the result set and create options for the select element

						while (rs3.next()) {
							String itemQuestion = rs3.getString("question");
							String questionUser = rs3.getString("q_user_id");
							CustomLogger.log(itemQuestion);
							String itemAnswer = rs3.getString("answer");
							String date_time = rs3.getString("date_time");
							
							CustomLogger.log("inside Loop");
							if (rs3.getString("answer") == null || rs3.getString("answer").isEmpty()) {
						StringBuilder str4 = new StringBuilder();
						CustomLogger.log("inside if");
						str4.append(
								"<form method=\"post\" action=\"productEdit.jsp\"><input type=\"text\" name=\"item_id\" value=\"")
								.append(item_id)
								.append("\"hidden><input type=\"text\" name=\"date_time\" value=\"")
								.append(date_time)
								.append("\"hidden><input type=\"text\" name=\"questionUser\" value=\"")
								.append(questionUser)
								.append("\"hidden><input type=\"text\" name=\"answer\" id=\"answer\"/><button>Post</button></form>");
						itemAnswer = str4.toString();
							} 

							StringBuilder str3 = new StringBuilder();

							str3.append("<tr><td>").append(itemQuestion).append("</td>").append("<td>").append(itemAnswer)
							.append("</td></tr>");

							out.print(str3);
						}
					} catch (SQLException e) {
						e.printStackTrace();
					}
					%>


				</table>
			</div>
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
	<script src="products.js"></script>
</body>
</html>