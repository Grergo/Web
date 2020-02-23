<%--
	Created by Eclipse.
  	@author geroge
 --%>
<%@page import="java.io.File"%>
<%@page import="java.io.OutputStream"%>
<%@page import="java.io.InputStream"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="pers.wwk.Web.SQL.JDBCUtil"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	String id=null;
	try{
	id=request.getParameter("id");
	}catch(Exception e){
		System.out.print(e.getLocalizedMessage());
	}
	JDBCUtil jdbcUtil=new JDBCUtil();
	Connection connection=jdbcUtil.getConnection();
	
	String sql="select prodimg from Web_Product where prodid=?";
	PreparedStatement preparedStatement=connection.prepareStatement(sql);
	preparedStatement.setString(1, id);
	ResultSet rs=preparedStatement.executeQuery();
	rs.next();
	OutputStream sout = response.getOutputStream();
	InputStream in=rs.getBinaryStream(1);
	byte b[] = new byte[1024];
	int num;
	while(( num=in.read(b))!=-1){
		sout.write(b, 0, num);
	}
	sout.flush();
	sout.close();
	out.clear();
	out = pageContext.pushBody();
	jdbcUtil.close(connection, preparedStatement,rs);
%>
</body>
</html>