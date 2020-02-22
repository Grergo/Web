
<%@page import="java.util.ArrayList"%>
<%@page import="javax.websocket.SessionException"%>
<%@page import="SQL.memberUtils"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>会员中心</title>
<link href="../css/page.css" rel="stylesheet" type="text/css" />
<link href="../css/reg.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="../css/footer.css">
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
<script src="../js/jquery-1.11.2.min.js" type="text/javascript"></script>
<script src="../js/jquery-accordion-menu.js" type="text/javascript"></script>
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

				<li><a href="memberCenter.jsp?id=1"><h3>个人信息</h3></a></li>
				<li><a href="memberCenter.jsp?id=2"><h3>订单信息</h3> </a></li>
				<li><a href="memberCenter.jsp?id=3"><h3>修改默认地址</h3></a></li>
				<li><a href="memberCenter.jsp?id=4"><h3>重置密码</h3></a></li>
				<li><a href="memberCenter.jsp?id=5"><h3>系统消息</h3> </a></li>
				<li><a href="memberCenter.jsp?id=6"><h3>联系我们</h3> </a></li>
			</ul>
		</div>
	</div>

	<%
		String ID = request.getParameter("id");
		memberUtils memberUtils=new memberUtils();
		String loginid = null;
		try {
			loginid = session.getAttribute("LOGINED").toString();
		} catch (NullPointerException e) {
			System.out.print(e.getLocalizedMessage());
		}
		if (ID != null) {
			switch (ID) {
			case "1":
				Map<String, String> personMap = memberUtils.Select_Person_info(loginid);
	%>
	<div class="content2">
		<form action="../../Member_DO" method="post">
			<h1>
				个人信息 <span>这是你的个人信息</span>
			</h1>
			<label> <span>你的名字:</span> <input id="username" type="text"
				name="username" required="required"
				value=<%=personMap.get("custname")%>>
			</label> <label> <span>你的电话 :</span> <input id="Phone" type="text"
				name="phone" readonly="readonly" value=<%=personMap.get("tel")%>>
			</label> <label> <span>你的邮箱 :</span> <input id="email" type="email"
				name="email" readonly="readonly" required="required"
				value=<%=personMap.get("email")%>>
			</label> <label> <span>你的积分 :</span> <input id="integral" type="text"
				name="integral" readonly="readonly" required="required"
				value=<%=personMap.get("integral")%>>
			</label>
			<%
				if (personMap.get("gender") != null) {
							if (personMap.get("gender").equals("")) {
			%>
			<label> <span>性别 :</span> <input id="gender" type="radio"
				name="gender" required="required" value="男">男 <input
				id="gender" type="radio" name="gender" required="required" value="女">女
			</label>
			<%
				} else if (personMap.get("gender").equals("女")) {
			%>
			<label> <span>性别 :</span> <input id="gender" type="radio"
				name="gender" required="required" value="男">男 <input
				id="gender" type="radio" name="gender" required="required" value="女"
				checked>女
			</label>
			<%
				} else if (personMap.get("gender").equals("男")) {
			%>
			<label> <span>性别 :</span> <input id="gender" type="radio"
				name="gender" required="required" value="男" checked>男 <input
				id="gender" type="radio" name="gender" required="required" value="女">女
			</label>
			<%
				}
						}
			%>
			<label> <span>&nbsp;</span> <input type="submit"
				class="button" id="submit" value="更新您的信息" />
			</label>
		</form>
	</div>
	<%
		break;
			case "2":
				ArrayList<Map<String, String>> order_list = memberUtils.Select_order_info(loginid);
	%>
	<div class="content3">
		<table class="order_info">
			<thead>
				<th>订单号</th>
				<th>创建时间</th>
				<th>收件人</th>
				<th>订单价格</th>
				<th>收货地址</th>
				<th>联系方式</th>
				<th>状态</th>
			</thead>
			<tbody>
				<%
					if (order_list.isEmpty()) {
								out.print("<tr><td colspan='7' align='center'>您暂无订单,<a href='#'>去购物吧!</a></td></tr>");
							} else {
								for (Map<String, String> map_tem : order_list) {
				%>
				<tr>
					<td><%=map_tem.get("order_num")%></td>
					<td><%=map_tem.get("order_time")%></td>
					<td><%=map_tem.get("consignee")%></td>
					<td><%=map_tem.get("order_price")%></td>
					<td><%=map_tem.get("order_address")%></td>
					<td><%=map_tem.get("phone")%></td>
					<td><%=map_tem.get("status")%></td>
				</tr>
				<%
					}
							}
				%>
			</tbody>
		</table>
	</div>

	<%
		break;
			case "3":
				Map<String, String> addressMap = memberUtils.Select_address(loginid);
	%>
	<div class="content2">
		<form action="../../Member_DO" method="post">
			<h1>
				地址修改 <span>这是你的默认地址</span>
			</h1>
			<label> <span>你的默认地址:</span> <input id="address" type="text"
				name="address" required="required"
				value=<%=addressMap.get("address")%>>
			</label> <label> <span>&nbsp;</span> <input type="submit"
				class="button" id="submit" value="更新您的信息" />
			</label>
		</form>
	</div>
	<%
		break;
			case "4":
	%>
	<script src="../js/func.js" type="text/javascript"></script>
	<div class="content2">
		<form action="../../Member_DO" method="post" name="form"
			onsubmit="return validateForm()">
			<h1>
				密码修改 <span>修改你的密码</span>
			</h1>
			<label> <span>新密码:</span> <input id="password"
				type="password" name="password" required="required">
			</label> <label> <span>重复密码:</span> <input id="Confirm"
				type="password" name="Confirm" required="required">
			</label> <label> <span>&nbsp;</span> <input type="submit"
				class="button" id="submit" value="修改密码" />
			</label>
		</form>
	</div>
	<%
		break;
			case "5":
				ArrayList<Map<String, String>> mess_list = memberUtils.Select_notice();
	%>
	<div class='content3'>
		<table class="notice">
			<thead>
				<th class='num'>消息编号</th>
				<th class='message'>消息提醒</th>
			</thead>
			<tbody>
				<%
					if (mess_list.isEmpty()) {
								out.print("<tr><td colspan='2' align='center'>您暂无消息!</td></tr>");
							} else {
								for (Map<String, String> map_tem : mess_list) {
				%>
				<tr>
					<td class='num' align='center'><%=map_tem.get("num")%></td>
					<td class='message'><%=map_tem.get("message")%></td>
				</tr>
				<%
					}
							}
				%>
			</tbody>
		</table>
	</div>
	<%
		break;
			case "6":
	%>
	<div class='content2'>
		<form action="#" method="post">
			<label> <span>标题:</span> <input id="title" type="text"
				name="title" required="required">
			</label> <label> <span>您的反馈内容:</span> <textarea></textarea>
			</label> <label> <span>&nbsp;</span> <input type="submit"
				class="button" id="submit" value="提交反馈" />
			</label>
		</form>
	</div>
	<%
		}
		}
	%>
	<%@include file="footer2.jsp" %>
</body>
</html>