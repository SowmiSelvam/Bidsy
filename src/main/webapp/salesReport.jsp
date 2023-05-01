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
<link rel="stylesheet" href="marketplace.css">
<title>Sales Reports</title>
</head>
<body>
	<div class="form">
		<div class="home">
			<label style="float: left" class="logoutLblPos"> <a
				href="admin_landing.jsp"><button name="home">Home</button></a>
			</label>
		</div>
		<div class="logout">
			<form name="form1" method="post" action="logout">
				<label style="float: right" class="logoutLblPos">
					<button name="logout">logout</button>
				</label>
			</form>
		</div>
	</div>
	<div class="user-dashboard">

		<div class="form">
			<table class="datatable">
				<tr>
					<th>Total earnings</th>
				</tr>
				<%
				try {
					String user_id = (String) session.getAttribute("user");
					ApplicationDB ap = new ApplicationDB();
					Connection con = ap.getConnection();
					Statement stmt = con.createStatement();
					String sql = "Select sum(bidding_price) from bids where bid_id in (select winning_bid_id from itemClassifies where winning_bid_id is NOT null);";
					CustomLogger.log(sql);
					ResultSet rs = stmt.executeQuery(sql);
					rs.next();

					int totEarnings = rs.getInt(1);

					StringBuilder str = new StringBuilder();
					str.append("<tr><td>" + totEarnings + "</td></tr>");
					out.print(str);
				%>
			</table>
		</div>


	</div>

	<div class="user-dashboard">
		<div class="form">
			<div class="tableHeader">
				<label><b>Earnings per Item:</b></label>
			</div>
			<table class="datatable">
				<tr>
					<th>Title:</th>
					<th>Description:</th>
					<th>User Id:</th>
					<th>Earnings:</th>
				</tr>
				<%
				String winningBidsQuery = "select i.title, i.itemDescription, i.email, i.winning_bid_id, (select bidding_price b from bids where b.bid_id = i.winning_bid_id) earnings from itemClassifies i, bids b where is_auction_over = 1 and i.winning_bid_id is not null;";
				PreparedStatement ps2 = con.prepareStatement(winningBidsQuery);
				ResultSet rs3 = ps2.executeQuery();
				while (rs3.next()) {
					String title = rs3.getString("title");
					String itemDescription = rs3.getString("itemDescription");
					int winning_bid_id = rs3.getInt("winning_bid_id");
					String seller_user_id = rs3.getString("email");
					int earnings = rs3.getInt("earnings");

					StringBuilder str2 = new StringBuilder();

					str2.append("<tr><td>").append(title).append("</td>").append("<td>").append(itemDescription).append("</td>")
					.append("<td>").append(seller_user_id).append("</td>").append("<td>").append(String.valueOf(earnings))
					.append("</td></tr>");

					out.print(str2);
				}
				%>
			</table>
		</div>
	</div>

	<div class="user-dashboard">
		<div class="form">
			<div class="tableHeader">
				<label><b>Earnings per Item Type:</b></label>
			</div>
			<table class="datatable">
				<tr>
					<th>Item Type:</th>
					<th>Earnings:</th>
				</tr>
				<%
				String itemTypeQuery = "Select i.sub_category_index, sum(b.bidding_price) earnings, (Select s.sub_category_name from subcategoryBelongs s where s.sub_category_index = i.sub_category_index) sub_category_name from bids b, itemClassifies i where b.bid_id in (select i2.winning_bid_id from itemClassifies i2 where i2.winning_bid_id is NOT null) group by i.sub_category_index;";
				PreparedStatement ps3 = con.prepareStatement(itemTypeQuery);
				ResultSet rs4 = ps3.executeQuery();
				while (rs4.next()) {
					String title = rs4.getString("sub_category_index");
					String itemDescription = rs4.getString("sub_category_name");
					int earnings = rs4.getInt("earnings");

					StringBuilder str3 = new StringBuilder();

					str3.append("<tr><td>").append(title).append("</td>").append("<td>").append(String.valueOf(earnings))
					.append("</td></tr>");

					out.print(str3);
				}
				%>
			</table>
		</div>
	</div>

	<div class="user-dashboard">
		<div class="form">
			<div class="tableHeader">
				<label><b>Earnings per User:</b></label>
			</div>
			<table class="datatable">
				<tr>
					<th>User Name:</th>
					<th>Earnings:</th>
				</tr>
				<%
				String perUserQuery = "Select i.email, sum(b.bidding_price) earnings from bids b, itemClassifies i where b.bid_id = i.winning_bid_id group by i.email;";
				PreparedStatement ps4 = con.prepareStatement(perUserQuery);
				ResultSet rs5 = ps4.executeQuery();
				while (rs5.next()) {
					String seller_user_id = rs5.getString("email");
					int earnings = rs5.getInt("earnings");

					StringBuilder str4 = new StringBuilder();

					str4.append("<tr><td>").append(seller_user_id).append("</td>").append("<td>").append(String.valueOf(earnings))
					.append("</td></tr>");

					out.print(str4);
				}
				%>
			</table>
		</div>
	</div>

	<div class="user-dashboard">
		<div class="form">
			<div class="tableHeader">
				<label><b>Best Selling Items(Descending Order):</b></label>
			</div>
			<table class="datatable">
				<tr>
					<th>Item Type:</th>
					<th>Number of Items Sold:</th>
				</tr>
				<%
				String bestSellingItemsQuery = "Select i.sub_category_index, count(1) number_of_items_sold, (Select s.sub_category_name from subcategoryBelongs s where s.sub_category_index = i.sub_category_index) sub_category_name from bids b, itemClassifies i where b.bid_id in (select i2.winning_bid_id from itemClassifies i2 where i2.winning_bid_id is NOT null) group by i.sub_category_index order by number_of_items_sold desc;";
				PreparedStatement ps5 = con.prepareStatement(bestSellingItemsQuery);
				ResultSet rs6 = ps5.executeQuery();
				while (rs6.next()) {
					String title = rs6.getString("sub_category_index");
					String itemDescription = rs6.getString("sub_category_name");
					int number_of_items_sold = rs6.getInt("number_of_items_sold");

					StringBuilder str3 = new StringBuilder();

					str3.append("<tr><td>").append(title).append("</td>").append("<td>").append(String.valueOf(number_of_items_sold))
					.append("</td></tr>");

					out.print(str3);
				}
				%>
			</table>
		</div>
	</div>

	<div class="user-dashboard">
		<div class="form">
			<div class="tableHeader">
				<label><b>Best Buyers(Descending Order):</b></label>
			</div>
			<table class="datatable">
				<tr>
					<th>Buyer Id:</th>
					<th>Number of Items Bought:</th>
				</tr>
				<%
				String bestBuyerQuery = "Select i.email, count(1) num_items_bought from bids b, itemClassifies i where b.bid_id = i.winning_bid_id group by i.email order by num_items_bought desc;";
				PreparedStatement ps6 = con.prepareStatement(bestBuyerQuery);
				ResultSet rs7 = ps6.executeQuery();
				while (rs7.next()) {
					String buyer_id = rs7.getString("email");
					int num_items_bought = rs7.getInt("num_items_bought");

					StringBuilder str3 = new StringBuilder();

					str3.append("<tr><td>").append(buyer_id).append("</td>").append("<td>").append(String.valueOf(num_items_bought))
					.append("</td></tr>");

					out.print(str3);
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