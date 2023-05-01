package main.java.com.BidsyJava;

import java.sql.Connection;
import java.sql.PreparedStatement;

public class DeclareWinner {
	public static void declareWinner() {
		ApplicationDB ap = new ApplicationDB();
		Connection conn = ap.getConnection();
		try {
			String query1 = "update itemClassifies, bids, sells set itemClassifies.winning_bid_id = itemClassifies.bid_id where itemClassifies.bid_id = bids.bid_id and "
					+ "itemClassifies.item_id = sells.item_id and bids.bidding_price > sells.secret_min_price and itemClassifies.end_auction_time < NOW();";
			
			CustomLogger.log(query1);
			PreparedStatement ps = conn.prepareStatement(query1);
			ps.executeUpdate();
			
			String query2 = "update itemClassifies set is_auction_over = 1 where end_auction_time < NOW();";
			CustomLogger.log(query2);
			PreparedStatement ps1 = conn.prepareStatement(query2);
			ps1.executeUpdate();
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		finally {
			ap.closeConnection(conn);
		}
		
	}
}
