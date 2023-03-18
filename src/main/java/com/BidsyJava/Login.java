package main.java.com.BidsyJava;

import javax.servlet.http.*;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.SessionCookieConfig;

import java.io.*;
import main.java.com.BidsyJava.ApplicationDB;

public class Login extends HttpServlet {

	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		PrintWriter out = response.getWriter();

		Connection conn = null;
		ApplicationDB apDB = new ApplicationDB();

		try {
			String uname = (String) request.getParameter("uname");
			String pass = (String) request.getParameter("psw");
			Class.forName("com.mysql.jdbc.Driver");
			conn = apDB.getConnection();

			if (conn != null) {
				try {

					PreparedStatement ps = conn
							.prepareStatement("select first_name, last_name, user_id, is_user from bidsy_user where user_id = ? and password = ?");

					ps.setString(1, uname);
					ps.setString(2, pass);
					ResultSet rs = ps.executeQuery();
					
					if(rs.next()) {
						HttpSession session = request.getSession();
						session.setAttribute("user", uname);
						
						//check the type of user
						String first_name = rs.getString("first_name");
						String last_name = rs.getString("last_name");
						String user_id = rs.getString("user_id");
						String is_user = rs.getString("is_user");
						
						if(is_user.equalsIgnoreCase("True")) {
							//set web page attributes
							
							//set JSP User
							response.sendRedirect("");
						}else {
							PreparedStatement ps2 = conn
									.prepareStatement("select is_admin from bidsy_employee where user_id = ?");
							ps2.setString(1, uname);
							ResultSet rs2 = ps2.executeQuery();
							
							if(rs2.next()) {
								String is_admin = rs.getString("is_admin");
								
								if(is_admin.equalsIgnoreCase("True")) {
									//set web page attributes
									
									//set JSP admin
									response.sendRedirect("");
								}else {
									//set web page attributes
									
									//set JSP employee
									response.sendRedirect("");
								}
							}

						}
						//redirect based on type of user
					}

				} catch (Exception e) {
					out.print(e);
					e.printStackTrace();
				}
				apDB.closeConnection(conn);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}

	}
}
