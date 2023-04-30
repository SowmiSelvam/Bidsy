package main.java.com.BidsyJava;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class SetAlert extends HttpServlet {

	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		ApplicationDB apDB = new ApplicationDB();
		PrintWriter out = response.getWriter();
		try {
			HttpSession session = request.getSession();
			String uname = (String) session.getAttribute("user");
			CustomLogger.log(uname);
			String maxPrice = request.getParameter("price");
			String displaySize = request.getParameter("displaySize");
			String[] ramList = request.getParameterValues("ram");
			String[] osList = request.getParameterValues("operatingSystem");
			String[] procList = request.getParameterValues("processor");
			String[] hddList = request.getParameterValues("hdd");
			String[] graphicsList = request.getParameterValues("graphics");

			String maxPriceCond = "";
			if(maxPrice != null && !maxPrice.isEmpty()) {
				maxPriceCond = " and starting_price < "+maxPrice + " ";
			}
			String dispSizeCond = "";
			if(displaySize != null && !displaySize.isEmpty()) {
				dispSizeCond = "and display_size < " + displaySize + " ";
			}
			StringBuilder ramCond = new StringBuilder("");
			int i = 0;
			for(String temp: ramList) {
				if(temp.equalsIgnoreCase("Select all")) {
					ramCond = new StringBuilder("");
					break;
				}else {
					if(i == 0) {
						ramCond.append(" and ram in (\\'"+temp+"\\'");
					}else {
						ramCond.append(",  \\'"+temp+"\\'");
					}
					i++;
				}
			}
			if(ramCond.length() != 0) {
				ramCond.append(") ");
			}

			StringBuilder osCond = new StringBuilder("");
			i = 0;
			for(String temp: osList) {
				if(temp.equalsIgnoreCase("Select all")) {
					osCond = new StringBuilder("");
					break;
				}else {
					if(i == 0) {
						osCond.append(" and operating_system in (\\'"+temp+"\\'");
					}else {
						osCond.append(", \\'"+temp+"\\'");
					}
					i++;
				}
			}
			if(osCond.length() != 0) {
				osCond.append(") ");
			}

			StringBuilder procCond = new StringBuilder("");
			i = 0;
			for(String temp: procList) {
				if(temp.equalsIgnoreCase("Select all")) {
					procCond = new StringBuilder("");
					break;
				}else {
					if(i == 0) {
						procCond.append(" and processor in (\\'"+temp+"\\'");
					}else {
						procCond.append(", \\'"+temp+"\\'");
					}
					i++;
				}
			}
			if(procCond.length() != 0) {
				procCond.append(") ");
			}

			StringBuilder hddCond = new StringBuilder("");
			i = 0;
			for(String temp: hddList) {
				if(temp.equalsIgnoreCase("Select all")) {
					hddCond = new StringBuilder("");
					break;
				}else {
					if(i == 0) {
						hddCond.append(" and hdd in ("+temp);
					}else {
						hddCond.append(", "+temp);
					}
					i++;
				}
			}
			if(hddCond.length() != 0) {
				hddCond.append(") ");
			}

			StringBuilder graphicsCond = new StringBuilder("");
			i = 0;
			for(String temp: graphicsList) {
				if(temp.equalsIgnoreCase("Select all")) {
					graphicsCond = new StringBuilder("");
					break;
				}else {
					if(i == 0) {
						graphicsCond.append(" and graphics in (\\'"+temp+"\\'");
					}else {
						graphicsCond.append(", \\'"+temp+"\\'");
					}
					i++;
				}
			}
			if(graphicsCond.length() != 0) {
				graphicsCond.append(") ");
			}

			String alertQuery = "select title, itemDescription, item_id, starting_price, start_auction_time,"
					+ "end_auction_time, bid_id  from itemClassifies where end_auction_time > current_timestamp() "
					+ maxPriceCond + ramCond.toString() + dispSizeCond + osCond.toString() + procCond.toString() + hddCond.toString() + graphicsCond.toString() + ";";
			
			CustomLogger.log(alertQuery);

			Connection conn = apDB.getConnection();
			String checkQuery = "Select count(1) from bids_alerts where user_id ='"+uname+"';";
			PreparedStatement ps1 = conn.prepareStatement(checkQuery);
			String insertQuery = "";
			ResultSet rs = ps1.executeQuery();
			rs.next();
			int x = rs.getInt(1);
			if (x>0){
				insertQuery = "Update bids_alerts set alerts = '"+alertQuery+"' where user_id='"+uname+"';";
			}
			else {
				insertQuery = "Insert into bids_alerts values('"+uname+"', '"+alertQuery+"');";
			}
			CustomLogger.log(insertQuery);
			PreparedStatement ps = conn.prepareStatement(insertQuery);
			ps.executeUpdate();
			apDB.closeConnection(conn);
			String msg="Alert Set Successfully";
			CustomLogger.log(msg);

			
			out.println("<script type=\"text/javascript\">");
			out.println("alert('"+msg+"');");
			out.println("location='setAlerts.jsp';");
			out.println("</script>");

		}
		catch(Exception e) {
			e.printStackTrace();
		}
	}

}
