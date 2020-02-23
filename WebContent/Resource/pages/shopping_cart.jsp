<%--
	Created by Eclipse.
  	@author geroge
 --%>
 <%@page import="java.util.HashMap"%>
<%@page import="pers.wwk.web.Service.MPutils"%>
<%@page import="pers.wwk.web.Service.memberUtils"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>购物车</title>
<link rel="stylesheet" href="../css/footer.css">
<link rel="stylesheet" href="../css/ad.css">
<script src="../js/jquery-1.11.2.min.js"></script>
<script src="../js/func.js"></script>
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
			session.setAttribute("Reference", "shopping_cart.jsp");
			response.sendRedirect("Login.jsp");
		}
	%>
	<%@include file="nav.jsp"%>
	<div class="process">
		<ul>
			<li id="1" class="selected">我的购物车</li>
			<li id="2">填写订单信息</li>
			<li id="3">订单提交成功</li>
		</ul>
	</div>
	<%
		String id = request.getParameter("id");
		if (id == null) {
			id = "1";
		}
		switch (id) {
		case "1":
	%>
	<form action="shopping_cart.jsp?id=2" method="post" class="shopping_prod_form">
		<table class="prod_info">
			<thead>
				<th>商品</th>
				<th>商品名称</th>
				<th>单价</th>
				<th>数量</th>
				<th>金额</th>
				<th>操作</th>
			</thead>
			<%
				ArrayList<Map<String, String>> prodlist = (ArrayList<Map<String, String>>) session
							.getAttribute("prodlist");
			double Tprice=0;
			int totalcount=0;
					if (prodlist == null) {
			%>
			<tr>
			<td colspan='6' align='center'>暂无商品</td>
			</tr>
			<%
				} else if (prodlist.size() == 0) {
			%>
			<tr>
			<td colspan='6' align='center'>暂无商品</td>
			</tr>

			<%
				} else {

					for(Map<String,String>tem:prodlist){	
						totalcount+=Integer.parseInt(tem.get("count"));
						Tprice+=Double.parseDouble(tem.get("prodprice"))*Integer.parseInt(tem.get("count"));
			%>	
				<tr>
					<td><img src="getimg.jsp?id=<%=tem.get("prodid")%>" style="width:100px;height:100px"></td>
					<td><%=tem.get("prodname")%></td>
					<td id="price">￥<%=tem.get("prodprice")%></td>
					<td><input name="count" required id="prodcount" type="number"min="0" max="99" onchange="figure(this)" value=<%=tem.get("count")%>></td>
					<td id="totalprice">￥<%=Double.parseDouble(tem.get("prodprice"))*Integer.parseInt(tem.get("count"))%></td>
					<td><input name="prodid" value="<%=tem.get("prodid")%>" hidden><input name="price" value="<%=tem.get("prodprice")%>" hidden><a href = "javascript:void(0);" onclick ="del_product(this)">删除</a></td>
				</tr>
			<%
					}
				}
			%>
			<tr>
				<td colspan='6' align='right' style="background:#636e72;color:#dff9fb">商品总计：<span id="totalcount"><%=totalcount%></span>件&nbsp;&nbsp;&nbsp;&nbsp;价格总计：￥<span id="totalprices"><%=Tprice%></span></td>
			</tr>
		</table>
		<input type="submit" value="去结算">
	</form>
		<%
			break;
		case "2":
			String loginid=session.getAttribute("LOGINED").toString();
			memberUtils memberUtils=new memberUtils();
			Map<String,String>addressMap=memberUtils.Select_address(loginid);
			session.removeAttribute("prodlist");
			ArrayList<Map<String,String>>Prod_list=new ArrayList<Map<String,String>>();
			for(String i:request.getParameterValues("prodid")){
				Map<String,String>prod=new HashMap<String,String>();
				prod.put("prodid",i);
				Prod_list.add(prod);
			}
			for(int i=0;i<Prod_list.size();i++){
				Prod_list.get(i).put("price", request.getParameterValues("price")[i]);
			}
			for(int i=0;i<Prod_list.size();i++){
				Prod_list.get(i).put("count", request.getParameterValues("count")[i]);
			}
			System.out.print(request.getParameter("totalprices"));
			session.setAttribute("order_products", Prod_list);
			%>
				<script> changeclass(2);</script>
				<div class="order_address">
					<form action="shopping_cart.jsp?id=3" method="post" class="order_address_form">
						<h1>收货人信息
                		<span>请填写收货人信息</span>
            			</h1>
            		 <label>
                		<span>收货人 :</span>
                		<input id="name" type="text" name="name" placeholder="收货人" required="required"/>
            		</label>
            		 <label>
                		<span>收货地址 :</span>
                		<input id="address" type="text" name="address" placeholder="收货地址" value="<%=addressMap.get("address") %>"required="required"/>
            		</label>
            		<label>
                		<span>邮政编码 :</span>
                		<input id="zipcode" type="text" name="zipcode" placeholder="邮政编码" required="required"/>
            		</label>
            		<label>
                		<span>联系电话 :</span>
                		<input id="phone" type="phone" name="phone" placeholder="联系电话" required="required"/>
            		</label>
            			<input type="submit" value="提交订单">
					</form>
				</div>
			<%
			break;
		case "3":
			MPutils mPutils=new MPutils();
			memberUtils memberUtils2= new memberUtils();
			String custname=memberUtils2.Select_Person_info(session.getAttribute("LOGINED").toString()).get("custname");
			String cosignee= request.getParameter("name");
			String address=request.getParameter("address");
			String zipcode=request.getParameter("zipcode");
			String phone=request.getParameter("phone");
			ArrayList<Map<String,String>>prod_list=(ArrayList<Map<String,String>>)session.getAttribute("order_products");
			double totalprice=0;
			for(Map<String,String>tem:prod_list){
				totalprice+=Double.parseDouble(tem.get("price"))*Integer.parseInt(tem.get("count"));
			}
			String orderno=mPutils.update_order_info(custname, cosignee, totalprice, address, zipcode, phone, session.getAttribute("LOGINED").toString());
			for(Map<String,String>tem:prod_list){
				mPutils.update_order_detail(orderno, tem.get("prodid"), tem.get("count"), tem.get("price"));
			}
			%>
				<script> changeclass(3);</script>
				<div class="success" style="background: #FFFFFF;">
					<h1>
						<img src="../images/success.png" style="width: 100px;">订单成功提交 <span style="margin-top: 20px;margin-left: 60px;font-size: 16px;">您的订单我们已收到！<a href="cosmetics.jsp">点击此继续购物</a></span>
					</h1>
				</div>
			<%
			}
		%>
		<%@include file="footer2.jsp"%>
		
</body>
</html>