<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<h2>Welcome on Process page </h2>

<%
String[] p_checkarr1=null;
String[] p_namearr=null;
String[] p_pricearr=null;
String[] p_quant=null ;
	try{
		
		
			String[] p_checkarr= request.getParameterValues("p_check");
			System.out.println(p_checkarr);
			if(p_checkarr != null){
				
				p_checkarr1=p_checkarr;
				System.out.println(p_checkarr1);
				
				p_namearr = request.getParameterValues("p_name");
				System.out.println(p_namearr);
				
				p_pricearr = request.getParameterValues("p_price");
				System.out.println(p_pricearr);
				
				p_quant = request.getParameterValues("p_quant");
				System.out.println(p_quant);
			}
		
	int lenght=p_checkarr1.length;
	System.out.println(lenght);

%>
<form action="Calculate" method="post">
	<table>
	<tr>
	<th>Product Name</th>
	<th>Price</th>
	<th>Quantity</th>
	<th>Total</th>
	</tr>
	<%
	for(int i=0;i<lenght;i++)
	{
	%>	
	<tr>
	<td>	
	<input type="text" value="<%=p_namearr[i]%>"name="product">
	</td>
	<td>
	<input type="text" value="<%=p_pricearr[i]%>"name="price">
	</td>
	<td>
	<input type="text" value="<%=p_quant[i]%>" name="quantity">
	</td>
	<td>
	<input type="text" value="<%=Integer.parseInt(p_pricearr[i])*Integer.parseInt(p_quant[i]) %>" name="total">
	</td>
	</tr>
	<%} %>	
	<tr>
	<td>
	<input type="submit" value="Place Order">
	</td>
	</tr>	
	</table>
</form>

<%	
}
catch(Exception e)
{

}
%>
</body>
</html>
