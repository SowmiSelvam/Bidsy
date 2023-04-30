<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="main.java.com.BidsyJava.*"%>
<%@ page import="main.java.com.BidsyJava.DeclareWinner"%>
<%@ page import="main.java.com.BidsyJava.CustomLogger"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="checkAlerts.css">
<title>set Alerts</title>
</head>
<body>
	<div class="alert" style="float: right">
		<a href='marketplace.jsp'><button>back</button></a>
	</div>
	<div class="home">
		<label style="float: left" class="logoutLblPos"> <a
			href="user_landing.jsp"><button name="home">Home</button></a>
		</label>
	</div>
	<div class="logout">
		<form name="form1" method="post" action="logout">
			<label style="float: right" class="logoutLblPos">
				<button name="logout">logout</button>
			</label>
		</form>
	</div>
	<div class="user-dashboard">
		<%
		DeclareWinner.declareWinner();
		try {
			String user_id = (String) session.getAttribute("user");
			ApplicationDB ap = new ApplicationDB();
			Connection con = ap.getConnection();
			Statement stmt = con.createStatement();
			String sql = "select alerts from bids_alerts where user_id = '" + user_id + "';";
			CustomLogger.log(sql);
			ResultSet rs = stmt.executeQuery(sql);
			while (rs.next()) {

				String itemAlert = rs.getString("alerts");
				CustomLogger.log(itemAlert);
				PreparedStatement ps = con.prepareStatement(itemAlert);
				ResultSet rs1 = ps.executeQuery();
		%>
		<div class="form">
			<div class="tableHeader">
				<label><b>The following items are available based on
						your set alert:</b></label>
			</div>
			<table class="datatable">
				<tr>
					<th>Title:</th>
					<th>Description:</th>
					<th>Starting Price:</th>
					<th>Current Bidding Price:</th>
					<th>Auction Duration:</th>
					<th>View Product</th>
				</tr>
				<%

				while (rs1.next()) {
					String title = rs1.getString("title");
					String itemDescription = rs1.getString("itemDescription");
					Timestamp start_auction_time = rs1.getTimestamp("start_auction_time");
					Timestamp end_auction_time = rs1.getTimestamp("end_auction_time");
					int bid_id = rs1.getInt("bid_id");
					int starting_price = rs1.getInt("starting_price");
					int item_id = rs1.getInt("item_id");

					Statement stmt2 = con.createStatement();
					String sql2 = "select bidding_price from bids where bid_id = " + bid_id + ";";
					ResultSet rs2 = stmt2.executeQuery(sql2);

					int bidding_price = 0;
					while (rs2.next()) {
						bidding_price = rs2.getInt("bidding_price");

					}
					StringBuilder str = new StringBuilder();

					str.append("<tr><td>").append(title).append("</td>").append("<td>").append(itemDescription).append("</td>")
					.append("<td>").append(String.valueOf(starting_price)).append("</td>").append("<td>")
					.append(String.valueOf(bidding_price)).append("</td>").append("<td>")
					.append(String.valueOf(start_auction_time)).append(" to ").append(String.valueOf(end_auction_time))
					.append("</td>").append("<td>")
					.append("<form method=\"post\" action = \"product.jsp\"><input type=\"text\" name=\"item_id\" class=\"no-outline\" value =\"")
					.append(item_id).append("\"hidden>").append("<a href=\"product.jsp\"><button>View Product</button></a>")
					.append("</form>");

					out.print(str);
				}
				}
				%>
			</table>
		</div>


	</div>

	<div class="user-dashboard">
		<div class="form">
			<div class="tableHeader">
				<label><b>Congratulations!! You won the following bids:</b></label>
			</div>
			<table class="datatable">
				<tr>
					<th>Title:</th>
					<th>Description:</th>
					<th>Starting Price:</th>
					<th>Current Bidding Price:</th>
					<th>Auction Duration:</th>
					<th>View Product</th>
				</tr>
				<%
				String winningBidsQuery = "select itemClassifies.title, itemClassifies.itemDescription, itemClassifies.item_id, itemClassifies.starting_price, itemClassifies.start_auction_time, itemClassifies.end_auction_time, itemClassifies.winning_bid_id  from itemClassifies, bids where itemClassifies.winning_bid_id = bids.bid_id and bids.user_id = '"
						+ user_id + "';";
				PreparedStatement ps2 = con.prepareStatement(winningBidsQuery);
				ResultSet rs3 = ps2.executeQuery();
				while (rs3.next()) {
					String title = rs3.getString("title");
					String itemDescription = rs3.getString("itemDescription");
					Timestamp start_auction_time = rs3.getTimestamp("start_auction_time");
					Timestamp end_auction_time = rs3.getTimestamp("end_auction_time");
					int bid_id = rs3.getInt("bid_id");
					int starting_price = rs3.getInt("starting_price");
					int item_id = rs3.getInt("item_id");

					Statement stmt2 = con.createStatement();
					String sql2 = "select bidding_price from bids where bid_id = " + bid_id + ";";
					ResultSet rs2 = stmt2.executeQuery(sql2);

					int bidding_price = 0;
					while (rs2.next()) {
						bidding_price = rs2.getInt("bidding_price");

					}
					StringBuilder str = new StringBuilder();

					str.append("<tr><td>").append(title).append("</td>").append("<td>").append(itemDescription).append("</td>")
					.append("<td>").append(String.valueOf(starting_price)).append("</td>").append("<td>")
					.append(String.valueOf(bidding_price)).append("</td>").append("<td>")
					.append(String.valueOf(start_auction_time)).append(" to ").append(String.valueOf(end_auction_time))
					.append("</td>").append("<td>")
					.append("<form method=\"post\" action = \"product.jsp\"><input type=\"text\" name=\"item_id\" class=\"no-outline\" value =\"")
					.append(item_id).append("\"hidden>").append("<a href=\"product.jsp\"><button>View Product</button></a>")
					.append("</form>");

					out.print(str);
				}
				%>
			</table>
		</div>
	</div>

	<div class="user-dashboard">
		<div class="form">
			<div class="tableHeader">
				<label><b>Your manual bids for following items were outbid by other users:</b></label>
			</div>
			<table class="datatable">
				<tr>
					<th>Title:</th>
					<th>Description:</th>
					<th>Starting Price:</th>
					<th>Current Bidding Price:</th>
					<th>Auction Duration:</th>
					<th>Outbid by:</th>
					<th>Your Bid Amount:</th>
					<th>View Product</th>
				</tr>
				<%
				String manual_Outbid_Query = "select itemClassifies.title, itemClassifies.itemDescription, itemClassifies.item_id, itemClassifies.starting_price, itemClassifies.start_auction_time, itemClassifies.end_auction_time, itemClassifies.bid_id  from itemClassifies, bids where itemClassifies.bid_id = bids.bid_id and itemClassifies.end_auction_time > NOW() and bids.isAutoBid = 0 and bids.user_id != '"+user_id+"';";
				PreparedStatement ps3 = con.prepareStatement(manual_Outbid_Query);
				ResultSet rs4 = ps3.executeQuery();
				while (rs4.next()) {
					String title = rs4.getString("title");
					String itemDescription = rs4.getString("itemDescription");
					Timestamp start_auction_time = rs4.getTimestamp("start_auction_time");
					Timestamp end_auction_time = rs4.getTimestamp("end_auction_time");
					int bid_id = rs4.getInt("bid_id");
					int starting_price = rs4.getInt("starting_price");
					int item_id = rs4.getInt("item_id");

					Statement stmt2 = con.createStatement();
					String sql2 = "select bidding_price from bids where bid_id = " + bid_id + ";";
					ResultSet rs2 = stmt2.executeQuery(sql2);

					int bidding_price = 0;
					String outbid_by = "";
					while (rs2.next()) {
						bidding_price = rs2.getInt("bidding_price");
						outbid_by = rs2.getString("user_id");
					}
					
					Statement stmt3 = con.createStatement();
					String sql3 = "select bidding_price from bids where user_id = '" + user_id + "' and item_id = "+item_id+";";
					ResultSet rs6 = stmt2.executeQuery(sql3);
					int currUserBidAmt = 0;
					while(rs6.next()){
						currUserBidAmt = rs6.getInt("bidding_price");
					}
					
					
					StringBuilder str = new StringBuilder();

					str.append("<tr><td>").append(title).append("</td>").append("<td>").append(itemDescription).append("</td>")
					.append("<td>").append(String.valueOf(starting_price)).append("</td>").append("<td>")
					.append(String.valueOf(bidding_price)).append("</td>").append("<td>")
					.append(String.valueOf(start_auction_time)).append(" to ").append(String.valueOf(end_auction_time))
					.append("</td>").append("<td>").append(String.valueOf(outbid_by)).append("</td>").append("<td>")
					.append(String.valueOf(currUserBidAmt)).append("</td>").append("<td>")
					.append("<form method=\"post\" action = \"product.jsp\"><input type=\"text\" name=\"item_id\" class=\"no-outline\" value =\"")
					.append(item_id).append("\"hidden>").append("<a href=\"product.jsp\"><button>View Product</button></a>")
					.append("</form>");

					out.print(str);
				}
				%>
			</table>
		</div>
	</div>
	
		<div class="user-dashboard">
		<div class="form">
			<div class="tableHeader">
				<label><b>Your Auto bids for following items were outbid by other users:</b></label>
			</div>
			<table class="datatable">
				<tr>
					<th>Title:</th>
					<th>Description:</th>
					<th>Starting Price:</th>
					<th>Current Bidding Price:</th>
					<th>Auction Duration:</th>
					<th>Outbid by:</th>
					<th>Your Bid Amount:</th>
					<th>View Product</th>
				</tr>
				<%
				String auto_Outbid_Query = "select itemClassifies.title, itemClassifies.itemDescription, itemClassifies.item_id, itemClassifies.starting_price, itemClassifies.start_auction_time, itemClassifies.end_auction_time, itemClassifies.bid_id  from itemClassifies, bids where itemClassifies.bid_id = bids.bid_id and itemClassifies.end_auction_time > NOW() and bids.isAutoBid = 1 and bids.user_id != '"+user_id+"';";
				PreparedStatement ps4 = con.prepareStatement(auto_Outbid_Query);
				ResultSet rs5 = ps4.executeQuery();
				while (rs5.next()) {
					String title = rs5.getString("title");
					String itemDescription = rs5.getString("itemDescription");
					Timestamp start_auction_time = rs5.getTimestamp("start_auction_time");
					Timestamp end_auction_time = rs5.getTimestamp("end_auction_time");
					int bid_id = rs5.getInt("bid_id");
					int starting_price = rs5.getInt("starting_price");
					int item_id = rs5.getInt("item_id");

					Statement stmt2 = con.createStatement();
					String sql2 = "select bidding_price, user_id from bids where bid_id = " + bid_id + ";";
					ResultSet rs2 = stmt2.executeQuery(sql2);

					int bidding_price = 0;
					String outbid_by = "";
					while (rs2.next()) {
						bidding_price = rs2.getInt("bidding_price");
						outbid_by = rs2.getString("user_id");
					}
					
					Statement stmt3 = con.createStatement();
					String sql3 = "select bidding_price from bids where user_id = '" + user_id + "' and item_id = "+item_id+";";
					ResultSet rs6 = stmt2.executeQuery(sql3);
					int currUserBidAmt = 0;
					while(rs6.next()){
						currUserBidAmt = rs6.getInt("bidding_price");
					}
					
					StringBuilder str = new StringBuilder();

					str.append("<tr><td>").append(title).append("</td>").append("<td>").append(itemDescription).append("</td>")
					.append("<td>").append(String.valueOf(starting_price)).append("</td>").append("<td>")
					.append(String.valueOf(bidding_price)).append("</td>").append("<td>")
					.append(String.valueOf(start_auction_time)).append(" to ").append(String.valueOf(end_auction_time))
					.append("</td>").append("<td>").append(String.valueOf(outbid_by)).append("</td>").append("<td>")
					.append(String.valueOf(currUserBidAmt)).append("</td>").append("<td>")
					.append("<form method=\"post\" action = \"product.jsp\"><input type=\"text\" name=\"item_id\" class=\"no-outline\" value =\"")
					.append(item_id).append("\"hidden>").append("<a href=\"product.jsp\"><button>View Product</button></a>")
					.append("</form>");

					out.print(str);
				}
				%>
			</table>
		</div>
	</div>
	
	<%
	} catch (SQLException e) {
	e.printStackTrace();
	}
	%>
</body>
</html>