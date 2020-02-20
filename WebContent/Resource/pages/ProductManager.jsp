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
	<link href="../css/reg.css" rel="stylesheet" type="text/css" />
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
		<div id="jquery-accordion-menu" class="jquery-accordion-menu blue" style="box-shadow: 5px 7px 7px #3595b8;">
			<ul id="demo-list">
				<li><a href="ProductManager.jsp?id=1">
						<h3>修改已上架商品</h3>
					</a>
				</li>
				<li><a href="ProductManager.jsp?id=2">
						<h3>上架商品</h3>
					</a>
				</li>
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
	<div class="content3" style="display: flex; flex-wrap: wrap">
		<%
			int i = 1;
						for (Map<String, String> tem_Map : Product_list) {
		%>
		<div class="product">
			<div class="imgbox">
				<img src="getimg.jsp?id=<%=tem_Map.get("prodimg")%>" style="width: 200px; height: 200px">
			</div>
			<form action="../../PMServlet" method="Post" class="productform">
				<label style="margin-top: 10px;"><span>产品名称：</span> <input type="text" name="prodname"
						value=<%=tem_Map.get("prodname")%>>
				</label> <label><span>产品ID：</span> <input type="text" name="prodid" value=<%=tem_Map.get("prodid")%>
						readonly>
				</label> <label><span>产品价格：</span> <input type="text" name="prodprice"
						value=<%=tem_Map.get("prodprice")%>> </label>
				<%
					if (tem_Map.get("prodtype").equals("化妆品")) {
				%>
				<label><span>产品类型：</span> <select name="prodtype">
						<option value="化妆品" selected="selected">化妆品</option>
						<option value="手袋&包包">手袋&包包</option>
						<option value="手表&手饰">手表&手饰</option>
						<option value="礼物">礼物</option>
						<option value="电子杂志">电子杂志</option>
					</select> </label>
				<%
					} else if (tem_Map.get("prodtype").equals("手袋&包包")) {
				%>
				<label><span>产品类型：</span> <select name="prodtype">
						<option value="化妆品">化妆品</option>
						<option value="手袋&包包" selected="selected">手袋&包包</option>
						<option value="手表&手饰">手表&手饰</option>
						<option value="礼物">礼物</option>
						<option value="电子杂志">电子杂志</option>
					</select> </label>
				<%
					} else if (tem_Map.get("prodtype").equals("手表&手饰")) {
				%>
				<label><span>产品类型：</span> <select name="prodtype">
						<option value="化妆品">化妆品</option>
						<option value="手袋&包包">手袋&包包</option>
						<option value="手表&手饰" selected="selected">手表&手饰</option>
						<option value="礼物">礼物</option>
						<option value="电子杂志">电子杂志</option>
					</select> </label>
				<%
					} else if (tem_Map.get("prodtype").equals("礼物")) {
				%>
				<label><span>产品类型：</span> <select name="prodtype">
						<option value="化妆品">化妆品</option>
						<option value="手袋&包包">手袋&包包</option>
						<option value="手表&手饰">手表&手饰</option>
						<option value="礼物" selected="selected">礼物</option>
						<option value="电子杂志">电子杂志</option>
					</select> </label>
				<%
					} else if (tem_Map.get("prodtype").equals("电子杂志")) {
				%>
				<label><span>产品类型：</span> <select name="prodtype">
						<option value="化妆品">化妆品</option>
						<option value="手袋&包包">手袋&包包</option>
						<option value="手表&手饰">手表&手饰</option>
						<option value="礼物">礼物</option>
						<option value="电子杂志" selected="selected">电子杂志</option>
					</select> </label>
				<%
					}
									if (tem_Map.get("isspecial").equals("是")) {
				%>
				<label> <span>是否特价：</span> <input id="isspecial" type="radio" name="isspecial" required="required"
						value="是" checked>
					<font style="color: #f5f6fa">是</font> <input id="isspecial" type="radio" name="isspecial"
						required="required" value="不是">
					<font style="color: #f5f6fa">不是</font>
				</label>
				<%
					} else if (tem_Map.get("isspecial").equals("不是")) {
				%>
				<label> <span>是否特价：</span> <input id="isspecial" type="radio" name="isspecial" required="required"
						value="是">
					<font style="color: #f5f6fa">是</font> <input id="isspecial" type="radio" name="isspecial"
						required="required" value="不是" checked>
					<font style="color: #f5f6fa">不是</font>
				</label>
				<%
					}
									if (tem_Map.get("isfashion").equals("是")) {
				%>
				<label> <span>是否时尚：</span> <input id="isfashion" type="radio" name="isfashion" required="required"
						value="是" checked>
					<font style="color:#f5f6fa">是</font>
					<input id="isfashion" type="radio" name="isfashion" required="required" value="不是">
					<font style="color:#f5f6fa">不是</font>
				</label>
				<%
					} else if (tem_Map.get("isfashion").equals("不是")) {
				%>
				<label> <span>是否时尚：</span> <input id="isfashion" type="radio" name="isfashion" required="required"
						value="是">
					<font style="color:#f5f6fa">是</font>
					<input id="isfashion" type="radio" name="isfashion" required="required" value="不是" checked>
					<font style="color:#f5f6fa">不是</font>
				</label>

				<%
					}
				%>
				<label> <input type="button" class="button" id="change" value="更新产品信息" onclick="updateSubmit(this)" />
					<input type="button" class="button" id="del" value="下架产品" onclick="delSubmit(this)" />
				</label>

			</form>
		</div>

		<%
			}
					}
		%>
	</div>
	<%
		break;
			case "2":
				MPutils mPutils2 = new MPutils();
	%>
	<div class="content2">
		<form action="../../PMServlet" method="Post" class="productform" enctype="multipart/form-data">

			<div class="imgbox">
				<img src="" alt="" id="selectImg" style="width: 200px; height: 200px;">
			</div>

			<label style="height: 48px; margin-top: 10px"> <span>选择商品图片：</span>
				<input type="file" id="uploadImg" onchange="UploadImg(this)" name="prodimg" required>
			</label> <label><span>商品名称：</span> <input type="text" name="prodname" required placeholder="商品名称"> </label>
			<label><span>商品价格：</span>
				<input type="text" name="prodprice" required placeholder="商品价格">
			</label> <label><span>商品类型：</span> <select name="prodtype">
					<option value="化妆品">化妆品</option>
					<option value="手袋&包包">手袋&包包</option>
					<option value="手表&手饰">手表&手饰</option>
					<option value="礼物">礼物</option>
					<option value="电子杂志" selected="selected">电子杂志</option>
				</select> </label> <label><span>是否折扣：</span> <input type="radio" name="isspecial" value="是">是 <input
					type="radio" name="isspecial" value="是">不是 </label> <label><span>是否时尚：</span>
				<input type="radio" name="isfashion" value="是">是 <input type="radio" name="isfashion" value="是">不是
			</label> <label>
				<span>&nbsp;</span> <input type="submit" class="button" id="submit" value="上架商品" />
			</label>

		</form>
	</div>
	<%
		}
		}
	%>
</body>

</html>