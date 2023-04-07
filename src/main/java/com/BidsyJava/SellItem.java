package main.java.com.BidsyJava;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import main.java.com.BidsyJava.ApplicationDB;

/**
 * Servlet implementation class SellItemServlet
 */
@WebServlet("/SellItem")
public class SellItem extends HttpServlet {
    private static final long serialVersionUID = 1L;
    /**
     * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // get form parameters
        String title = request.getParameter("title");
        String startingPrice = request.getParameter("startingPrice");
        String itemDescription = request.getParameter("itemDescription");
        String email = request.getParameter("email");
        String startAuctionTime = request.getParameter("startAuctionTime");
        String endAuctionTime = request.getParameter("endAuctionTime");
//      String categoryIndex = request.getParameter("categoryIndex");
        String subCategory = request.getParameter("subCategory");
        String secretMinPrice = request.getParameter("secretMinPrice");
        String userId = request.getParameter("userId");

        // initialize database connection
        ApplicationDB ap = new ApplicationDB();
        Connection conn = ap.getConnection();
        PreparedStatement ps = null;

        // insert new item into itemClassifies table
        try {
        	String query = "INSERT INTO itemClassifies (title, starting_price, itemDescription, email, start_auction_time, end_auction_time, sub_category_index, secret_min_price) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
            ps = conn.prepareStatement(query);
            ps.setString(1, title);
            ps.setDouble(2, Double.parseDouble(startingPrice));
            ps.setString(3, itemDescription);
            ps.setString(4, email);
            ps.setString(5, startAuctionTime);
            ps.setString(6, endAuctionTime);
            ps.setInt(7, Integer.parseInt(subCategory));
            ps.setDouble(8, Double.parseDouble(secretMinPrice));
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (ps != null) {
                    ps.close();
                }
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        // insert new entry into sells table
        try {
            String query = "INSERT INTO sells (user_id, item_id, secret_min_price) VALUES (?, LAST_INSERT_ID(), ?)";
            ps = conn.prepareStatement(query);
            ps.setString(1, userId);
            ps.setDouble(2, Double.parseDouble(secretMinPrice));
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (ps != null) {
                    ps.close();
                }
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        // redirect to user dashboard
        response.sendRedirect(request.getContextPath() + "/user_landing.jsp");
    }

}
