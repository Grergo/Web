<%--
	Created by Eclipse.
  	@author geroge
 --%>
<%@page import="pers.wwk.web.Service.ShowUtils"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.ArrayList"%>
<%@page import="pers.wwk.web.Service.memberUtils"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>手表&手饰</title>
<link rel="stylesheet" href="../css/ad.css">
<link rel="stylesheet" href="../css/footer.css">
</head>
<body>
	<div class="Main">
	<img src="../images/logo.png" class="logo">
	<div class="top_bar">
		<a href="Login.jsp">登录</a>  |  <a href="register.jsp">注册</a>  |  <a href="memberCenter.jsp?id=1">会员中心</a>  |  <a href="shopping_cart.jsp">购物车</a>
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
			<div class="products">
				<h3 id="product_title">新品上市</h3>
				<hr>
				<div class="product_news">
				<%
					ShowUtils showUtils=new ShowUtils();
									ArrayList<Map<String,String>> news=showUtils.Select_news("手表&手饰");
									if(news.size()!=0){
									for(Map<String,String>tem:news){
				%>
					
						<div class="product">
						<div id="prodimgbox">
							<a href="proddetail.jsp?id=<%=tem.get("prodid")%>"><img src="getimg.jsp?id=<%=tem.get("prodid")%>"style="width:100px;height:100px"></a>
						</div>
						<span id="prodname"><a href="proddetail.jsp?id=<%=tem.get("prodid")%>"><%=tem.get("prodname")%></a></span> 
						<span id="prodprice">¥ <%=tem.get("prodprice")%></span>
					</div>
				
						<%
					}
					} else{
						%>
							<span id="notice">暂无新品上市</span>
						<%
					}
					
				%>
				</div>
				<h3 id="product_title">特价商品</h3>
				<hr>
				<div class="product_special">
					<% 
					ArrayList<Map<String,String>>special=showUtils.Select_assigned_product("手表&手饰", "是");
					if(special.size()!=0){
					for(Map<String,String>tem:special){
						%>

						<div class="product">
						<div id="prodimgbox">
							<a href="proddetail.jsp?id=<%=tem.get("prodid")%>"><img src="getimg.jsp?id=<%=tem.get("prodid")%>"style="width:100px;height:100px"></a>
						</div>
						<span id="prodname"><a href="proddetail.jsp?id=<%=tem.get("prodid")%>"><%=tem.get("prodname")%></a></span> 
						<span id="prodprice">¥ <%=tem.get("prodprice")%></span>
					</div>

						<%
					}
					} else{
						%>
							<span id="notice">暂无特价商品上市</span>
						<%
					}
					
				%>
				</div>
				<h3 id="product_title">全部商品</h3>
				<hr>
				<div class="product_all">
					<% 
					ArrayList<Map<String,String>>allprod=showUtils.Select_assigned_product("手表&手饰", null);
					if(allprod.size()!=0){
					for(Map<String,String>tem:allprod){
						%>

						<div class="product">
						<div id="prodimgbox">
							<a href="proddetail.jsp?id=<%=tem.get("prodid")%>"><img src="getimg.jsp?id=<%=tem.get("prodid")%>"style="width:100px;height:100px"></a>
						</div>
						<span id="prodname"><a href="proddetail.jsp?id=<%=tem.get("prodid")%>"><%=tem.get("prodname")%></a></span> 
						<span id="prodprice">¥ <%=tem.get("prodprice")%></span>
					</div>
				
						<%
					}
					} else{
						%>
							<span id="notice">暂无商品上市</span>
						<%
					}
					
				%>
			</div>
			</div>
		</div>
	</div>
	</div>
	<%@include file="footer.jsp" %>
</body>
</html>