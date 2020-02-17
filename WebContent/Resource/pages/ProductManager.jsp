<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>商品管理</title>
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
</body>
</html>