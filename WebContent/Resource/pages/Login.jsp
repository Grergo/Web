<%--
	Created by Eclipse.
  	@author geroge
 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>用户登录</title>
<link rel="stylesheet" href="../css/reg.css">
<link rel="stylesheet" href="../css/footer.css">
</head>
<body>
	<%@include file="nav.jsp"%>
	<div class="basic-grey">
	 <form action="../../Login" method="post" name="login">
	 <h1>会员登录
                <span>登录账号，开始购物</span>
     </h1>
     		 <label>
                <span>Your Phone or Email :</span>
                <input id="user_name" type="text" name="username" placeholder="Your Phone or Email" required="required"/>
            </label>
            <label>
                <span>Your Password :</span>
                <input id="password" type="password" name="password" placeholder="Your Password" required="required"/>
            </label>
            <label>
                <span>&nbsp;</span>
                <input type="submit" class="button" id="submit" value="Login" />
                <input type="reset" class="button" id="reset" value="Reset" />
            </label>
            <% String codeString=request.getParameter("code");
			if (codeString!=null){
				if(codeString.equals("faild")){
					out.println("<label><h3 style=\"color:red;\">用户名或密码错误</h3></label>");
				}
			}
		
		%>
	 </form>
	</div>
	<%@include file="footer2.jsp" %>
</body>
</html>