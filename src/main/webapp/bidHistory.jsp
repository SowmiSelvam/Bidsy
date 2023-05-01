<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="main.java.com.BidsyJava.*"%>
<%@ page import="main.java.com.BidsyJava.CustomLogger"%>
<%@ page import="main.java.com.BidsyJava.DeclareWinner"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="user_landing.css">
<title>Bid History</title>
</head>
<body>
<%				int item_id = Integer.valueOf(request.getParameter("item_id"));%>
	<div class="back">
	<form name="form1" method="post" action="product.jsp">
		<label>
		<input type="text" name="item_id" class="no-outline" value ="<%=item_id%>" hidden>
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
	<div class="user-dashboard">
		<div class="form">
			<table>
				<tr>
					<th>Bid ID:</th>
					<th>User ID:</th>
					<th>Bidding Price:</th>
					<th>Time of bid:</th>
				</tr>
				<%
				DeclareWinner.declareWinner();
				CustomLogger.log(request.getParameter("item_id"));

				ApplicationDB ap = new ApplicationDB();
				Connection con = ap.getConnection();
				try {

					Statement stmt = con.createStatement();
					String sql = "SELECT bid_id, bidding_price, bid_time, user_id, isAnonymous FROM bids where item_id ="
					+ item_id + ";";

					ResultSet rs = stmt.executeQuery(sql);
					// loop through the result set and create options for the select element
					while (rs.next()) {
						Timestamp bid_time = rs.getTimestamp("bid_time");
						int bid_id = rs.getInt("bid_id");
						String user_id = rs.getString("user_id");
						int bidding_price = rs.getInt("bidding_price");
						int isAnonymous = rs.getInt("isAnonymous");
						if(isAnonymous == 1){
							user_id = "Anonymous_User";
						}
						
						
						StringBuilder str = new StringBuilder();

						str.append("<tr><td>").append(bid_id).append("</td>")
						.append("<td>").append(user_id).append("</td>")
						.append("<td>").append(String.valueOf(bidding_price))
						.append("</td>").append("<td>")
						.append(String.valueOf(bid_time)).append("</td></tr>");

						out.print(str);
					}
				

			} catch (SQLException e) {
			e.printStackTrace();
			} finally {
			ap.closeConnection(con);
			}
				%>

			</table>
		</div>
	</div>


</body>
</html>