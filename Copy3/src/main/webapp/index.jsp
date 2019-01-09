<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="java.sql.*"%>
<%@ page import ="org.apache.commons.dbcp2.BasicDataSource"%>
<%@ page import ="java.net.URI"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>

</head>
<body>
<h2>Hello</h2>

</body>
<form action="process.jsp" method="post">

<table border="2">
<tr>
<td>  </td>
<td>ID</td>
<td>NAME</td>
<td>Price</td>
<td>Quantity</td>
</tr>

<%
final BasicDataSource connectionPool;
	try
	{
		String query="select * from product.product_details";
		
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
		Statement stmt=connection.createStatement();
		ResultSet rs=stmt.executeQuery(query);
	while(rs.next())
{

%>
	   <tr>
	   <td><input type="checkbox" name="p_check"/></td>
	   <td><input type="text" name="p_id" value="<%out.print(rs.getString("product_id"));%>" /></td>
	   <td><input type="text" name="p_name" value="<%out.print(rs.getString("product_name"));%>" /></td>
	   <td><input type="text" name="p_price" value="<%out.print(rs.getInt("price"));%>" /></td>
	   <td><input type="text" name="p_quant" /></td>
	   </tr>
       
        <%
}
	
%>

 </table>
    <input type="submit" value="Proceed" name="process"/>
    <%
    
    }
catch(Exception e)
{
    e.printStackTrace();
    }

%>

</form>
</html>