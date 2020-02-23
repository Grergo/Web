<%@page import="SQL.ShowUtils"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.ArrayList"%>
<%@page import="SQL.memberUtils"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>购物车</title>
<link rel="stylesheet" href="../css/ad.css">
<link rel="stylesheet" href="../css/footer.css">
</head>
<body>
	<% 
			Cookie cookie = null;
			Cookie cookies[] = request.getCookies();
			boolean flag = true;
			if (cookies != null) {
				for (int i = 0; i < cookies.length; i++) {
					if (cookies[i].getName().equals("LoginID")) {
						flag = false;
						cookie = cookies[i];
						break;
					}
				}
			}
			if (flag) {
				response.sendRedirect("Login.jsp");
			}
			%>
			<% 
				String prodid=request.getParameter("id");
				ShowUtils showUtils=new ShowUtils();
				Map<String,String> prodmap=showUtils.get_Product_info(prodid);
				session.setAttribute("Reference", "proddetail.jsp?id="+prodid);
			%>
	<div class="Main">
	<img src="../images/logo.png" class="logo">
	<div class="top_bar">
		<a href="Login.jsp">登录</a>  |  <a href="register.jsp">注册</a>  |  <a href="memberCenter.jsp?id=1">会员中心</a>  |  <a href="shopping_cart.jsp">购物车
	</div>
	<%@include file="nav.jsp"%>
	<div class="topad">
		<%@include file="topad.jsp"%>
		<div style="display: flex; flex-wrap: wrap; width: 950px;background: #f1f2f6;margin-bottom: 50px;border-radius: 5px;">
			<div class="poptip">
				<div class="top_title">
					<h3>网站公告</h3>
					<span><a href='memberCenter.jsp?id=5'>more >></a></span>
					<hr>
				</div>
				<%
					memberUtils memberUtils = new memberUtils();
					ArrayList<Map<String, String>> notice_List = memberUtils.Select_notice();
					for (Map<String, String> tem : notice_List) {
				%>
				<div class="content">
					<p>
						<span class="flag">公告</span> <span class="text"><a
							href="memberCenter.jsp?id=5"><%=tem.get("message")%></a></span>
					</p>
				</div>
				<%
					}
				%>
			</div>
			<div id="prodinfo_imgbox">
				<img src="getimg.jsp?id=<%=prodmap.get("prodimg")%>" style="width:290px;height:350px">
			</div>
		
			<div id="prodinfo_form">
				<form action="addsuccess.jsp" method="post" id="prodform">
				<span id="prodna"><%=prodmap.get("prodname") %></span>
				<span id="putawaytime">上架时间: <p><%=prodmap.get("putawaytime") %></p></span>
				<span id="id">商品号:<p>(<%=prodid.substring(0, 16) %>)</p></span>
				<span id="prodpri">¥<%=prodmap.get("prodprice") %></span>
				<span id="pj">用户评价: <p id="grade">★★★★★</p></span>
				<hr>
				<label>数量:<input type="number" name="count" id="count" required value="1"  min="0" 
 max="99"></label>
				<input name="prodname" value="<%=prodmap.get("prodname") %>" hidden>
				<input name="prodid" value="<%=prodid %>" hidden>
				<input name="prodprice" value="<%=prodmap.get("prodprice") %>" hidden>
				<span style="text-align: right;margin-right: 20px;"><input type="submit" value="放入购物车"></span>
				</form>
			</div>
	</div>
	</div>
	</div>
	<%@include file="footer.jsp" %>
</body>
</html>