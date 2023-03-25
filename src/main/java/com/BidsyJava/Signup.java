package main.java.com.BidsyJava; 

import javax.servlet.http.*;
import java.sql.*;
import javax.servlet.ServletException;
import java.io.*;

public class Signup extends HttpServlet {
	
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		PrintWriter out = response.getWriter();

		Connection conn=null;
		ApplicationDB apDB = new ApplicationDB();

		try{
			String fname = (String)request.getParameter("first_name");
			String lname = (String)request.getParameter("last_name");
			String address = (String)request.getParameter("address");
			String user_id = (String)request.getParameter("first_name");
			String email = (String)request.getParameter("email");
			String pass = (String)request.getParameter("psw");
			String bank_acc_no = (String)request.getParameter("bank_acc_no");
			String routing_no = (String)request.getParameter("routing_no");
			String telephone_no = (String)request.getParameter("telephone_no");
			CustomLogger.log("Uname: "+user_id);
			CustomLogger.log("pass: "+pass);
			

			conn = apDB.getConnection();
			CustomLogger.log("Connection Complete: "+conn);
			
			if (conn!=null){
				try{

					PreparedStatement ps= conn.prepareStatement("insert into bidsy_user(first_name,last_name,address,user_id,email,telephone_no,password,bank_acc_no,routing_no,is_user) values(?,?,?,?,?,?,?,?,?,1)");

					ps.setString(1,fname);
					ps.setString(2,lname);
					ps.setString(3,address);
					ps.setString(4,user_id);
					ps.setString(5,email);
					ps.setString(6,telephone_no);
					ps.setString(7,pass);
					ps.setString(8,bank_acc_no);
					ps.setString(9,routing_no);
					
					int x = ps.executeUpdate();
					out.print("in");
					if(x>0){
						HttpSession log = request.getSession();
						CustomLogger.log("User inserted"+user_id);
						log.setAttribute("user", user_id);
						response.sendRedirect("login.jsp");
					}


					else{
		
						String msg="Account exists.";
						CustomLogger.log(msg);
					}
				}catch(Exception e){
					String msg="Account exists with some issues.";
					CustomLogger.log(msg);
				}
			}
		}catch(Exception e){
			e.printStackTrace();
		}}}