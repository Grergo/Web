<%@page import="java.util.Map"%>
<%@page import="java.util.ArrayList"%>
<%@page import="SQL.MPutils"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>商品管理</title>
<script src="../js/jquery-1.11.2.min.js" type="text/javascript"></script>
<script src="../js/func.js" type="text/javascript"></script>
<link href="../css/page.css" rel="stylesheet" type="text/css" />
<style type="text/css">
* {
	box-sizing: border-box;
	-moz-box-sizing: border-box;
	-webkit-box-sizing: border-box;
}

body {
	background: #f0f0f0;
}

.content {
	width: 260px;
	position: relative;
	left: 10%;
	top: 60px
}

#demo-list a {
	overflow: hidden;
	text-overflow: ellipsis;
	-o-text-overflow: ellipsis;
	white-space: nowrap;
	width: 100%;
}
</style>
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
	<%@include file="nav.jsp"%>
	<div class="content">
		<div id="jquery-accordion-menu" class="jquery-accordion-menu blue"
			style="box-shadow: 5px 7px 7px #3595b8;">
			<ul id="demo-list">
				<li><a href="ProductManager.jsp?id=1"><h3>修改已上架商品</h3></a></li>
				<li><a href="ProductManager.jsp?id=2"><h3>上架商品</h3> </a></li>
			</ul>
		</div>
	</div>
	<%
		String ID = request.getParameter("id");
		if (ID != null) {
			switch (ID) {
			case "1":
				MPutils mPutils = new MPutils();
				ArrayList<Map<String, String>> Product_list = mPutils.getProduct();
				if (Product_list.isEmpty()) {
	%>
	<div class="content3">
		<h1>您暂未上架商品</h1>
	</div>
	<%
		} else {
	%>
	<div class="content3" style="display:flex;flex-wrap:wrap">
		<%
			int i = 1;
						for (Map<String, String> tem_Map : Product_list) {
							
		%>
		<div class="product">
			<img src=<%=tem_Map.get("prodimg")%>
				style="width: 100px; height: 100px">>
			<form action="../../PMServlet" method="Post" class="productform">
				<input type="text" name="prodname"
					value=<%=tem_Map.get("prodname")%>> <input type="text"
					name="prodprice" value=<%=tem_Map.get("prodprice")%>>
				<%
					if (tem_Map.get("prodtype").equals("化妆品")) {
				%>
				<select name="prodtype">
					<option value="化妆品" selected="selected">化妆品</option>
					<option value="手袋&包包">手袋&包包</option>
					<option value="手表&手饰">手表&手饰</option>
					<option value="礼物">礼物</option>
					<option value="电子杂志">电子杂志</option>
				</select>
				<%
					} else if (tem_Map.get("prodtype").equals("手袋&包包")) {
				%>
				<select name="prodtype">
					<option value="化妆品">化妆品</option>
					<option value="手袋&包包" selected="selected">手袋&包包</option>
					<option value="手表&手饰">手表&手饰</option>
					<option value="礼物">礼物</option>
					<option value="电子杂志">电子杂志</option>
				</select>
				<%
					} else if (tem_Map.get("prodtype").equals("手表&手饰")) {
				%>
				<select name="prodtype">
					<option value="化妆品">化妆品</option>
					<option value="手袋&包包">手袋&包包</option>
					<option value="手表&手饰" selected="selected">手表&手饰</option>
					<option value="礼物">礼物</option>
					<option value="电子杂志">电子杂志</option>
				</select>
				<%
					} else if (tem_Map.get("prodtype").equals("礼物")) {
				%>
				<select name="prodtype">
					<option value="化妆品">化妆品</option>
					<option value="手袋&包包">手袋&包包</option>
					<option value="手表&手饰">手表&手饰</option>
					<option value="礼物" selected="selected">礼物</option>
					<option value="电子杂志">电子杂志</option>
				</select>
				<%
					} else if (tem_Map.get("prodtype").equals("电子杂志")) {
				%>
				<select name="prodtype">
					<option value="化妆品">化妆品</option>
					<option value="手袋&包包">手袋&包包</option>
					<option value="手表&手饰">手表&手饰</option>
					<option value="礼物">礼物</option>
					<option value="电子杂志" selected="selected">电子杂志</option>
				</select>
				<%
					}
										if (tem_Map.get("isspecial").equals("是")) {
				%>
				<label> <span>是否特价：</span> <input id="isspecial"
					type="radio" name="isspecial" required="required" value="是" checked>是
					<input id="isspecial" type="radio" name="isspecial"
					required="required" value="不是">不是
				</label>
				<%
					} else if (tem_Map.get("isspecial").equals("不是")) {
				%>
				<label> <span>是否特价：</span> <input id="isspecial"
					type="radio" name="isspecial" required="required" value="是">是
					<input id="isspecial" type="radio" name="isspecial"
					required="required" value="不是" checked>不是
				</label>
				<%
					}
										if (tem_Map.get("isfashion").equals("是")) {
				%>
				<label> <span>是否时尚：</span> <input id="isfashion"
					type="radio" name="isfashion" required="required" value="是" checked>是
					<input id="isfashion" type="radio" name="isfashion"
					required="required" value="不是">不是
				</label>
				<%
					} else if (tem_Map.get("isfashion").equals("不是")) {
				%>
				<label> <span>是否时尚：</span> <input id="isfashion"
					type="radio" name="isfashion" required="required" value="是">是
					<input id="isfashion" type="radio" name="isfashion"
					required="required" value="不是" checked>不是
				</label>
				<%
					}
				%>更新产品信息 <label> <span>&nbsp;</span> <input type="button"
					class="button" id="submit" value="更新产品信息" onclick="updateSubmit()" />
				</label> <label> <span>&nbsp;</span> <input type="button"
					class="button" id="del" value="下架产品" onclick="delSubmit()" />
				</label>
			</form>
		</div>
	</div>
	<%
		
							
					}
				}
				//TODO 上架产品 以及样式修改 以及上边还有些label 没有添加
			}
		}
	%>
</body>
</html>