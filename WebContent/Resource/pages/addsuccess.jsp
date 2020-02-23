<%--
	Created by Eclipse.
  	@author geroge
 --%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>添加购物车成功</title>
<link rel="stylesheet" href="../css/reg.css">
<link rel="stylesheet" href="../css/footer.css">
</head>
<body>
	<%@include file="nav.jsp"%>
	<%
		ArrayList<Map<String, String>> prodlist = null;
		if (session.getAttribute("prodlist") == null) {
			prodlist = new ArrayList<Map<String, String>>();
		} else {
			prodlist = (ArrayList<Map<String, String>>) session.getAttribute("prodlist");
		}
		Map<String, String> tem_map = new HashMap<String, String>();
		tem_map.put("prodname", request.getParameter("prodname"));
		tem_map.put("prodid", request.getParameter("prodid"));
		tem_map.put("prodprice", request.getParameter("prodprice"));
		tem_map.put("count", request.getParameter("count"));
		prodlist.add(tem_map);
		session.setAttribute("prodlist", prodlist);
	%>
	<div class="basic-grey" style="background: #FFFFFF;">
		<h1>
			<img src="../images/shopping_cart.png" style="width: 100px;">成功加入购物车
			<span style="margin-top: 20px; margin-left: 60px; font-size: 16px;">商品已成功加入购物车！<a
				href="shopping_cart.jsp">点击此跳转到购物车</a></span>
		</h1>
	</div>
	<%@include file="footer2.jsp"%>
</body>
</html>