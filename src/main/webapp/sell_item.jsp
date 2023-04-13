<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="main.java.com.BidsyJava.*"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Sell Item</title>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</head>
<body>
	<div class="logout">
			<label style="float: right" class="logoutLblPos">
				<a href="user_landing.jsp"><button name="home">Home</button></a>
			</label>
	</div>
	<div class="container">
		<h1 class="text-center">Sell Item</h1>
		<form action="SellItem" method="post">
			<div class="form-group">
				<label for="title">Title:</label> <input type="text"
					class="form-control" id="title" name="title" required>
			</div>
			<div class="form-group">
				<label for="startingPrice">Starting Price:</label> <input
					type="number" class="form-control" id="startingPrice"
					name="startingPrice" required>
			</div>
			<div class="form-group">
				<label for="itemDescription">Item Description:</label>
				<textarea class="form-control" rows="5" id="itemDescription"
					name="itemDescription" required></textarea>
			</div>
			<div class="form-group">
				<label for="startAuctionTime">Start Auction Time:</label> <input
					type="datetime-local" class="form-control" id="startAuctionTime"
					name="startAuctionTime" required>
			</div>
			<div class="form-group">
				<label for="endAuctionTime">End Auction Time:</label> <input
					type="datetime-local" class="form-control" id="endAuctionTime"
					name="endAuctionTime" required>
			</div>
			<div class="form-group">
				<label for="secretMinimumPrice">Secret Minimum Price:</label> <input
					type="number" class="form-control" id="secretMinPrice"
					name="secretMinPrice" required>
			</div>
			<div class="form-group">
				<label for="bidIncrements">Bid Increments:</label> <input
					type="number" class="form-control" id="bidIncrements"
					name="bidIncrements" required>
			</div>
			<div class="form-group">
				<label for="subCategory">Subcategory:</label> <select
					class="form-control" id="subCategory" name="subCategory" required>
					<option value="" selected disabled hidden> Select subCategory</option>
					<%
					try {
						// get subcategories from the database
						ApplicationDB ap = new ApplicationDB();
						Connection con = ap.getConnection();
						Statement stmt = con.createStatement();
						String sql = "SELECT * FROM subcategoryBelongs";
						ResultSet rs = stmt.executeQuery(sql);
						
						// loop through the result set and create options for the select element
						while (rs.next()) {
							int subCategoryIndex = rs.getInt("sub_category_index");
							String subCategoryName = rs.getString("sub_category_name");
							int categoryIndex = rs.getInt("category_index");
							
							// get category name from category table
							Statement stmt2 = con.createStatement();
							String sql2 = "SELECT category_name FROM category WHERE category_index=" + categoryIndex;
							ResultSet rs2 = stmt2.executeQuery(sql2);
							rs2.next();
							String categoryName = rs2.getString("category_name");
							%>
					<option value="<%= subCategoryIndex %>"><%= categoryName %>
						-
						<%= subCategoryName %></option>
					<%
						}
					} catch (SQLException e) {
						e.printStackTrace();
					}
					%>
				</select>
			</div>
			<button type="submit" class="btn btn-primary">Sell Item</button>
		</form>
	</div>
</body>
</html>
