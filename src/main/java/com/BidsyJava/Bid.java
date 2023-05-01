package main.java.com.BidsyJava;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.text.SimpleDateFormat;
import java.time.format.DateTimeFormatter;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

public class Bid extends HttpServlet {

	private static final long serialVersionUID = 1L;

	public static String getBody(HttpServletRequest request) throws IOException {

		String body = null;
		StringBuilder stringBuilder = new StringBuilder();
		BufferedReader bufferedReader = null;

		try {
			InputStream inputStream = request.getInputStream();
			if (inputStream != null) {
				bufferedReader = new BufferedReader(new InputStreamReader(inputStream));
				char[] charBuffer = new char[128];
				int bytesRead = -1;
				while ((bytesRead = bufferedReader.read(charBuffer)) > 0) {
					stringBuilder.append(charBuffer, 0, bytesRead);
				}
			} else {
				stringBuilder.append("");
			}
		} catch (IOException ex) {
			throw ex;
		} finally {
			if (bufferedReader != null) {
				try {
					bufferedReader.close();
				} catch (IOException ex) {
					throw ex;
				}
			}
		}

		body = stringBuilder.toString();
		return body;
	}

	public static void autoIncrementFunctionality_AutoBid(Connection conn, String item_id) {
		try {
			PreparedStatement ps = null;

			String query = "SELECT bid_id, secret_upper_price, bidding_price, bid_time, increment_bid,user_id,item_id, isAutoBid FROM bids where item_id = "+item_id+" and isAutoBid = 1 order by secret_upper_price desc;";
			ps = conn.prepareStatement(query);
			ResultSet rs = ps.executeQuery();

			rs.next();
			int first_secret_upper_price = rs.getInt("secret_upper_price");
			int first_BidId = rs.getInt("bid_id");
			CustomLogger.log("first_BidId: "+ first_BidId);
			int first_bidding_price = rs.getInt("bidding_price");
			CustomLogger.log("first_bidding_price: "+ first_bidding_price);
			Date first_bid_time = rs.getDate("bid_time"); 
			int first_Increment_Bid = rs.getInt("increment_bid");
			String first_User_Id = rs.getString("user_id");
			int first_Item_Id = rs.getInt("item_id");

			if(rs.next()) {
				int second_secret_upper_price = rs.getInt("secret_upper_price");
				int second_BidId = rs.getInt("bid_id");
				CustomLogger.log("second_BidId: "+ second_BidId);
				int second_bidding_price = rs.getInt("bidding_price");
				CustomLogger.log("second_bidding_price: "+ second_bidding_price);
				Date second_bid_time = rs.getDate("bid_time"); 
				int second_Increment_Bid = rs.getInt("increment_bid");
				String second_User_Id = rs.getString("user_id");
				int second_Item_Id = rs.getInt("item_id");

				int temp_bid_price = first_bidding_price;

				while(temp_bid_price <= second_secret_upper_price) {
					temp_bid_price+=first_Increment_Bid;
				}
				if(temp_bid_price > first_secret_upper_price) {
					temp_bid_price = first_secret_upper_price;
				}

				String update_Max_Bid1 = "Update bids set bidding_price = "+temp_bid_price+", bid_time = CURRENT_TIMESTAMP where bid_id = "+first_BidId+";";
				PreparedStatement ps2 = conn.prepareStatement(update_Max_Bid1);


				String update_Bids = "Update bids set bidding_price = secret_upper_price, bid_time = CURRENT_TIMESTAMP where item_id = "+item_id+"  and isAutoBid = 1 and NOT bid_id = "+first_BidId+";";
				PreparedStatement ps3 = conn.prepareStatement(update_Bids);
				ps3.executeUpdate();
				ps2.executeUpdate();
			}

			String update_Items_Table = "Update itemClassifies set bid_id = "+first_BidId+" where item_id = "+item_id+";";
			PreparedStatement ps4 = conn.prepareStatement(update_Items_Table);
			ps4.executeUpdate();

		}
		catch(Exception e) {
			e.printStackTrace();
		}

	}

	public static void autoIncrementFunctionality_ManualBid(Connection conn, String item_id, String bid_Amt, String user_id) {
		try {
			CustomLogger.log("Inside Manual Auto bid");
			PreparedStatement ps = null;

			String query = "SELECT bid_id, secret_upper_price, bidding_price, bid_time, increment_bid,user_id,item_id, isAutoBid FROM bids where item_id = "+item_id+" and isAutoBid = 1 order by secret_upper_price desc;";
			ps = conn.prepareStatement(query);
			ResultSet rs = ps.executeQuery();

			if(rs.next()) {
				int first_secret_upper_price = rs.getInt("secret_upper_price");
				int first_BidId = rs.getInt("bid_id");
				CustomLogger.log("first_BidId: "+ first_BidId);
				int first_bidding_price = rs.getInt("bidding_price");
				CustomLogger.log("first_bidding_price: "+ first_bidding_price);
				Date first_bid_time = rs.getDate("bid_time"); 
				int first_Increment_Bid = rs.getInt("increment_bid");
				String first_User_Id = rs.getString("user_id");
				int first_Item_Id = rs.getInt("item_id");


				if(first_secret_upper_price > Integer.valueOf(bid_Amt)) {
					CustomLogger.log("Inside if");
					int temp_bid_price = first_bidding_price;

					while(temp_bid_price <= Integer.valueOf(bid_Amt)) {
						temp_bid_price+=first_Increment_Bid;
					}
					if(temp_bid_price > first_secret_upper_price) {
						temp_bid_price = first_secret_upper_price;
					}
					String update_Max_Bid1 = "Update bids set bidding_price = "+temp_bid_price+", bid_time = CURRENT_TIMESTAMP where bid_id = "+first_BidId+";";
					PreparedStatement ps2 = conn.prepareStatement(update_Max_Bid1);


					String update_Bids = "Update bids set bidding_price = secret_upper_price, bid_time = CURRENT_TIMESTAMP where item_id = "+item_id+"  and isAutoBid = 1 and NOT bid_id = "+first_BidId+";";
					PreparedStatement ps3 = conn.prepareStatement(update_Bids);
					ps3.executeUpdate();
					ps2.executeUpdate();

					String update_Items_Table = "Update itemClassifies set bid_id = "+first_BidId+" where item_id = "+item_id+";";
					PreparedStatement ps4 = conn.prepareStatement(update_Items_Table);
					ps4.executeUpdate();

				}else {
					CustomLogger.log("Inside else");
					String getBidIDQuery = "Select bid_id from bids where item_id = "+item_id+" and user_id = '"+user_id+"';";
					PreparedStatement ps5 = conn.prepareStatement(getBidIDQuery);
					ResultSet rs5 = ps5.executeQuery();
					rs5.next();
					int bid_id = rs5.getInt(1);

					String update_Items_Table = "Update itemClassifies set bid_id = "+bid_id+" where item_id = "+item_id+";";
					PreparedStatement ps4 = conn.prepareStatement(update_Items_Table);
					ps4.executeUpdate();
				}
			}
			else {
				CustomLogger.log("Inside else");
				String getBidIDQuery = "Select bid_id from bids where item_id = "+item_id+" and user_id = '"+user_id+"';";
				PreparedStatement ps5 = conn.prepareStatement(getBidIDQuery);
				ResultSet rs5 = ps5.executeQuery();
				rs5.next();
				int bid_id = rs5.getInt(1);

				String update_Items_Table = "Update itemClassifies set bid_id = "+bid_id+" where item_id = "+item_id+";";
				PreparedStatement ps4 = conn.prepareStatement(update_Items_Table);
				ps4.executeUpdate();
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
	}

	private static boolean checkBidPresent(Connection conn, String user_id, String item_id) {
		try {
			PreparedStatement ps = null;

			String query = "Select count(1) from bids where user_id = '"+user_id+"' and item_id = "+item_id+";";
			ps = conn.prepareStatement(query);
			ResultSet rs = ps.executeQuery();

			while(rs.next()) {
				if(rs.getInt(1) == 1) {
					return true;
				}
			}

		}
		catch(Exception e) {
			e.printStackTrace();
		}

		return false;
	}

	private static void executeBidInsert(Connection conn, String secretUpperLimit, String bid_Amt, String autoBidIncrement, String user_id, String item_id, int isAutoBid, boolean isAnonymous) {
		try { 
			if(checkBidPresent(conn, user_id, item_id)) {
				//update bid
				PreparedStatement ps = null;
				java.sql.Timestamp ts = new java.sql.Timestamp(System.currentTimeMillis());

				//String query = "INSERT INTO bids(secret_upper_price,bidding_price,bid_time,increment_bid,user_id,item_id, is_AutoBid) VALUES(?, ?, ?, ?, ?, ?, ?)"; 
				String query = "Update bids set secret_upper_price = ?, bidding_price = ?, bid_time = ?, increment_bid = ?, isAutoBid = ?, isAnonymous = ? where user_id = ? and item_id = ?;";
				ps = conn.prepareStatement(query);


				if(secretUpperLimit.isEmpty()) {
					ps.setNull(1, Types.NULL);
				}else {
					ps.setInt(1, Integer.parseInt(secretUpperLimit));
				}
				if(bid_Amt.isEmpty()) {
					ps.setNull(2, Types.NULL);
				}else {
					ps.setInt(2, Integer.parseInt(bid_Amt));
				}
				ps.setTimestamp(3, ts);
				if(autoBidIncrement.isEmpty()) {
					ps.setNull(4, Types.NULL);
				}else {
					ps.setInt(4, Integer.parseInt(autoBidIncrement));
				}

				ps.setInt(5, isAutoBid);
				if(isAnonymous) {
					ps.setInt(6, 1);
				}else {
					ps.setInt(6, 0);
				}
				ps.setString(7, user_id);
				ps.setInt(8, Integer.parseInt(item_id));

				ps.executeUpdate();

			}else {
				//insert bid
				java.sql.Timestamp ts = new java.sql.Timestamp(System.currentTimeMillis());
				PreparedStatement ps = null;

				String query = "INSERT INTO bids(secret_upper_price,bidding_price,bid_time,increment_bid,user_id,item_id, isAutoBid, isAnonymous) VALUES(?, ?, ?, ?, ?, ?, ?, ?)"; 

				ps = conn.prepareStatement(query);
				if(secretUpperLimit.isEmpty()) {
					ps.setNull(1, Types.NULL);
				}else {
					ps.setInt(1, Integer.parseInt(secretUpperLimit));
				}
				if(bid_Amt.isEmpty()) {
					ps.setNull(2, Types.NULL);
				}else {
					ps.setInt(2, Integer.parseInt(bid_Amt));
				}
				ps.setTimestamp(3, ts);
				if(autoBidIncrement.isEmpty()) {
					ps.setNull(4, Types.NULL);
				}else {
					ps.setInt(4, Integer.parseInt(autoBidIncrement));
				}

				ps.setString(5, user_id);
				ps.setInt(6, Integer.parseInt(item_id));
				ps.setInt(7, isAutoBid);
				if(isAnonymous) {
					ps.setInt(8, 1);
				}else {
					ps.setInt(8, 0);
				}
				ps.executeUpdate();
			}
			if(isAutoBid == 1) {
				autoIncrementFunctionality_AutoBid(conn, item_id);
			}else {
				autoIncrementFunctionality_ManualBid(conn, item_id, bid_Amt ,user_id);
			}



		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String payloadRequest = getBody(request);
		CustomLogger.log(payloadRequest);
		JSONParser parser = new JSONParser();  
		HttpSession session = request.getSession();
		ApplicationDB ap = new ApplicationDB();
		Connection conn = ap.getConnection();
		PreparedStatement ps = null;
		try {
			CustomLogger.log(payloadRequest);
			JSONObject payLoad_json = (JSONObject) parser.parse(payloadRequest);

			String item_id = (String)payLoad_json.get("item_id");
			String bid_Amt = (String)(payLoad_json.get("bid_Amt"));
			Boolean isAnonymous = (Boolean)payLoad_json.get("isAnonymous");
			Boolean isAutoBid = (Boolean)payLoad_json.get("isAutoBid");
			String secretUpperLimit = (String)(payLoad_json.get("SecretUpperLimit"));
			String autoBidIncrement = (String)(payLoad_json.get("AutoBidIncrement"));

			int isAutoBidInt = 0;
			if(isAutoBid) {
				isAutoBidInt = 1;
			}

			String user_id = (String)session.getAttribute("user");

			executeBidInsert(conn, secretUpperLimit, bid_Amt, autoBidIncrement, user_id, item_id, isAutoBidInt, isAnonymous);

			String alertString = "Bid Submitted Successfully";
			response.setHeader("response", alertString);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} 
		ap.closeConnection(conn);

	}
}
