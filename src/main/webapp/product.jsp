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
					String sql = "select title, email, sub_category_index, itemDescription, item_id, ram, display_size, operating_system, processor, hdd, graphics, starting_price, start_auction_time, end_auction_time, bid_id  from itemClassifies where item_id ="
					+ item_id + ";";

					ResultSet rs = stmt.executeQuery(sql);
					// loop through the result set and create options for the select element
					while (rs.next()) {
						String title = rs.getString("title");
						String itemDescription = rs.getString("itemDescription");
						String ram = rs.getString("ram");
						String operating_system = rs.getString("operating_system");
						String processor = rs.getString("processor");
						int hdd = rs.getInt("hdd");
						String graphics = rs.getString("graphics");
						float display_size = rs.getFloat("display_size");
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
						.append("<tr><td>RAM:</td><td>").append(ram).append("</td></tr>")
						.append("<tr><td>Operating System:</td><td>").append(operating_system).append("</td></tr>")
						.append("<tr><td>Processor:</td><td>").append(processor).append("</td></tr>")
						.append("<tr><td>HDD:</td><td>").append(hdd).append("</td></tr>")
						.append("<tr><td>Graphics:</td><td>").append(graphics).append("</td></tr>")
						.append("<tr><td>Display Size:</td><td>").append(display_size).append("</td></tr>")
						.append("<tr><td>Starting Price:</td><td>").append(String.valueOf(starting_price)).append("</td></tr>")
						.append("<tr><td>Current Bidding Price:</td><td id=").append("\"currBiddingPrice\">").append(String.valueOf(bidding_price))
						.append("</td></tr>").append("<tr><td>Start Auction Time:</td><td>")
						.append(String.valueOf(start_auction_time)).append("</td></tr>")
						.append("<tr><td>End Auction Time:</td><td>").append(String.valueOf(end_auction_time))
						.append("</td></tr>");

						out.print(str);
				%>
			</table>
			<br />

			<div>
					<input name="bidAmount" id = "bidAmount" placeholder="Bid Amount" required>
					<input type="checkbox" id="anonymousBid" name="anonymousBid">
					<label for="anonymousBid">Bid Anonymous</label> <input
						type="checkbox" id="autoBid" name="autoBid"> <label
						for="autoBid">Enable Auto Bid</label>
						<input name="secretUpperLimit" id = "secretUpperLimit" placeholder="Secret Upper Limit" disabled>
						<input name="autoBidIncrement" id = "autoBidIncrement" placeholder="Auto Bid Increment" disabled>
					<button id="bid">Bid</button>
			</div>
			<br />
			<div>
				<form method="post">
					<input type="text" value="<%=item_id%>" name="item_id" id="item_id" hidden /> <input
						type="text" value="<%=email%>" name="email" hidden /> <input
						type="text" value="<%=sub_category_index%>"
						name="sub_category_index" hidden /> <input type="submit"
						value="History of Bids" formaction="bidHistory.jsp"> <input
						type="submit" value="View Similar Items"
						formaction="similarItems.jsp"> <input type="submit"
						value="History of Seller" formaction="sellerHistory.jsp">
				</form>
			</div>

			<div>
				<table>
					<tr>
						<th>Questions</th>
						<th>Answers</th>
					</tr>

					<%
					try {
						if (request.getParameter("questionUser") != null && !request.getParameter("questionUser").isEmpty()) {
							PreparedStatement ps = con.prepareStatement(
							"insert into comments_inEditsContainsQnA(q_user_id,date_time,item_id,question) values(?,CURRENT_TIMESTAMP,?,?)");
							ps.setString(1, (String) session.getAttribute("user"));
							ps.setString(2, request.getParameter("item_id"));
							ps.setString(3, request.getParameter("questionUser"));

							int x = ps.executeUpdate();
							if (x > 0) {
						CustomLogger.log("Inserted into Questions");

							}
						}

						Statement stmt3 = con.createStatement();
						CustomLogger.log(String.valueOf(item_id));
						String sql3 = "select question, answer from comments_inEditsContainsQnA where item_id =" + item_id + ";";
						ResultSet rs3 = stmt3.executeQuery(sql3);
						// loop through the result set and create options for the select element
						
						while (rs3.next()) {
							String itemQuestion = rs3.getString("question");
							CustomLogger.log(itemQuestion);

							String itemAnswer = (rs3.getString("answer") != null) ? rs3.getString("answer") : "";
							CustomLogger.log(itemAnswer);

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
				<form style="float: left" method='post' action='product.jsp'>
					<input type="text" name="item_id" value="<%=item_id%>" hidden>
					<input type="text" name="questionUser" id="questionUser" />

					<button>Post</button>
				</form>
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