package com.app;


import java.io.IOException;
import java.sql.*;
//import org.apache.commons.dbcp.*;
import org.apache.commons.dbcp2.BasicDataSource;

import java.io.PrintWriter;
import java.net.URI;
import java.sql.Array;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

//@WebServlet("/CalculateTotal")
public class Calculate extends HttpServlet {

	private BasicDataSource connectionPool;
	private Connection con;

	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) 
	{
		
		try {
			//URI dbUri = new URI("nkdmdpnfdiynyf:a748becd9db76e8e16e0793e2c5d9b600b24d34af4ffaf8ab00a6342bdc4b72e@ec2-54-225-227-125.compute-1.amazonaws.com:5432/d5ofqitkovbj5j");
			  /*String dbUrl = "jdbc:postgresql://ec2-107-20-183-142.compute-1.amazonaws.com:5432/df1l77pvbl26og";
			  connectionPool = new BasicDataSource();
			    connectionPool.setUsername("yqhgpmoowluscl");
			    connectionPool.setPassword("27c5847bec6debb8ceabe1a8e2ecc52e164587b675a0cf0f43ed93457e7b81e4");
			    System.out.println("done 1");
			  
			  connectionPool.setDriverClassName("org.postgresql.Driver");
			  connectionPool.setUrl(dbUrl);
			  System.out.println("done");
			  connectionPool.setInitialSize(3);
			  */
			String[] totalamount = request.getParameterValues("total");
			String[] products = request.getParameterValues("product");
			String[] quantites = request.getParameterValues("quantity");
			  
			  URI dbUri = new URI(System.getenv("DATABASE_URL"));
			  String dbUrl = "jdbc:postgresql://" + dbUri.getHost() + dbUri.getPath();
			  connectionPool = new BasicDataSource();

			  if (dbUri.getUserInfo() != null) {
			    connectionPool.setUsername(dbUri.getUserInfo().split(":")[0]);
			    connectionPool.setPassword(dbUri.getUserInfo().split(":")[1]);
			  }
			  connectionPool.setDriverClassName("org.postgresql.Driver");
			  connectionPool.setUrl(dbUrl);
			  connectionPool.setInitialSize(1);
			  System.out.println("1");
			  Connection connection = connectionPool.getConnection();
			  System.out.println("2");
			  System.out.println("In try");
				

				String insertTableSQL = "INSERT INTO product.`product_entry` (product_name,quantity,total_cost) VALUES(?,?,?)";
				PreparedStatement preparedStatement = con.prepareStatement(insertTableSQL);
				
				for (int i=0; i<products.length; i++)
				{
					System.out.println(products[i] + " " + quantites[i]);
					
					preparedStatement.setString(2, products[i]);
					preparedStatement.setInt(3, Integer.parseInt(quantites[i]));
					preparedStatement.setInt(4,Integer.parseInt(totalamount[i]));
					preparedStatement.addBatch();
				}
				int[] aa=preparedStatement.executeBatch();
				if(aa.length>0)
				{
					response.setContentType("text/html");
					PrintWriter out = response.getWriter();
					out.print("<h3><font color='green'>ThisOrder Is placed Successfully</font></h3><br> <a href='index.jsp'>Click here to Go Back</a>");
				}
				else
				{
					System.out.println("no");
				}
				
			
			
		} catch (Exception e) {
			System.out.println(e);
			e.printStackTrace();
		}

	}


}