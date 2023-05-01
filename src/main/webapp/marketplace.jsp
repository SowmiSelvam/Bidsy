<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="main.java.com.BidsyJava.*"%>
<%@ page import="main.java.com.BidsyJava.DeclareWinner"%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="marketplace.css">
<title>User Landing</title>
</head>
<body>

	<div class="alert" style="float: right">
		<a href='setAlerts.jsp'><button>set Alert</button></a>
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


	<div>
		<%
		DeclareWinner.declareWinner();
		String fname = (String) session.getAttribute("fname");
		String lname = (String) session.getAttribute("lname");
		out.print("<label style=\"float: left\" class = \"username\">Welcome " + fname + " " + lname + "</label>");
		%>
	</div>
	<div class="searchform">
		<form action="marketplace.jsp" method="post">

			<div class="form-group">
				<label for="ram">Sort by:</label><select class="form-control"
					id="sort" name="sort">
					<option value="" selected>Sort by</option>
					<option value="1">Price(Ascending)</option>
					<option value="2">Price(Descending)</option>
					<option value="3">Auction Start time</option>
					<option value="4">Auction End time</option>
					<option value="5">Alphabetical(A-Z)</option>
					<option value="6">Alphabetical(Z-A)</option>
				</select> <label for="ram">RAM:</label><select class="form-control" id="ram"
					name="ram">
					<option value="" selected>Select RAM</option>
					<option value="4 GB">4 GB</option>
					<option value="8 GB">8 GB</option>
					<option value="16 GB">16 GB</option>
					<option value="32 GB">32 GB</option>
				</select> <label for="displaySize">Select Display Size Less Than:</label> <input
					type="number" step=0.1 class="form-control" id="displaySize"
					name="displaySize"> <label for="operatingSystem">Operating
					System:</label> <select class="form-control" id="operatingSystem"
					name="operatingSystem">
					<option value="" selected>Select Operating System</option>
					<option value="Windows 11">Windows 11</option>
					<option value="Windows 10">Windows 10</option>
					<option value="MacOS">MacOS</option>
					<option value="Linux">Linux</option>
				</select> <label for="processor">Processor:</label> <select
					class="form-control" id="processor" name="processor">
					<option value="" selected>Select Processor</option>
					<option value="Intel Core">Intel Core</option>
					<option value="AMD Ryzen">AMD Ryzen</option>
					<option value="M1">M1</option>
					<option value="M2">M2</option>
				</select> <label for="hdd">HDD Size:</label> <select class="form-control"
					id="hdd" name="hdd">
					<option value="" selected>Select HDD</option>
					<option value="256">256 GB</option>
					<option value="512">512 GB</option>
					<option value="1024">1024 GB</option>
					<option value="2048">2048 GB</option>
				</select> <label for="processor">Graphics:</label> <select
					class="form-control" id="graphics" name="graphics">
					<option value="" selected>Select Graphics</option>
					<option value="Nvidia">Nvidia</option>
					<option value="Intel Graphics">Intel Graphics</option>
					<option value="AMD">AMD</option>
				</select>
			</div>
			<button type="submit" class="btn btn-primary">Search</button>
		</form>
	</div>
	<div class="user-dashboard">

		<div class="form">
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
				try {
					ApplicationDB ap = new ApplicationDB();
					Connection con = ap.getConnection();
					Statement stmt = con.createStatement();
					String minPrice = "";
					String maxPrice = "";
					String priceCondition = "";
					if (!(minPrice.isEmpty() && maxPrice.isEmpty())) {
						priceCondition = "and between " + minPrice + " and " + maxPrice + " ";
					}
					
					String sort = request.getParameter("sort");
					String sortCondition = "";
					if (sort != null && !sort.isEmpty()) {
						if(sort.equalsIgnoreCase("1")){
							sortCondition = " order by starting_price";
						}
						else if(sort.equalsIgnoreCase("2")){
							sortCondition = " order by starting_price desc";
						}
						else if(sort.equalsIgnoreCase("3")){
							sortCondition = " order by start_auction_time";
						}
						else if(sort.equalsIgnoreCase("4")){
							sortCondition = " order by end_auction_time";
						}
						else if(sort.equalsIgnoreCase("5")){
							sortCondition = " order by title";
						}
						else if(sort.equalsIgnoreCase("6")){
							sortCondition = " order by title desc";
						}
						
					}

					String ram = request.getParameter("ram");
					String ramCondition = "";
					if (ram != null && !ram.isEmpty()) {
						ramCondition = "and ram = '" + ram + "' ";
					}
					
					String displaySize = request.getParameter("displaySize");
					String dispSizeCondition = "";
					if (displaySize != null && !displaySize.isEmpty()) {
						dispSizeCondition = "and display_size < " + displaySize + " ";
					}
					
					String operatingSystem = request.getParameter("operatingSystem");
					String osCondition = "";
					if (operatingSystem != null && !operatingSystem.isEmpty()) {
						osCondition = "and operating_system = '" + operatingSystem + "' ";
					}
					String processor = request.getParameter("processor");
					String procCondition = "";
					if (processor != null && !processor.isEmpty()) {
						procCondition = "and processor = '" + processor + "' ";
					}
					String hdd = request.getParameter("hdd");
					String hddCondition = "";
					if (hdd != null && !hdd.isEmpty()) {
						hddCondition = "and hdd = " + hdd + " ";
					}

					String graphics = request.getParameter("graphics");
					String graphicsCondition = "";
					if (graphics != null && !graphics.isEmpty()) {
						graphicsCondition = "and graphics = " + graphics + " ";
					}

					String sql = "select title, itemDescription, item_id, starting_price, start_auction_time,"
					+ "end_auction_time, bid_id  from itemClassifies where end_auction_time > current_timestamp() and start_auction_time < current_timestamp() "
					+" and email not like '"+ session.getAttribute("user")+"' "
					+ priceCondition + ramCondition + dispSizeCondition + osCondition + procCondition + hddCondition + graphicsCondition +sortCondition+ ";";
					CustomLogger.log(sql);

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

						str.append("<tr><td>").append(title).append("</td>").append("<td>").append(itemDescription).append("</td>")
						.append("<td>").append(String.valueOf(starting_price)).append("</td>").append("<td>")
						.append(String.valueOf(bidding_price)).append("</td>").append("<td>")
						.append(String.valueOf(start_auction_time)).append(" to ").append(String.valueOf(end_auction_time))
						.append("</td>").append("<td>")
						.append("<form method=\"post\" action = \"product.jsp\"><input type=\"text\" name=\"item_id\" class=\"no-outline\" value =\"")
						.append(item_id).append("\"hidden>").append("<a href=\"product.jsp\"><button>View Product</button></a>")
						.append("</form>");

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