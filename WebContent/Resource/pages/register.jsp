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
<title>注册会员</title>
<link rel="stylesheet" href="../css/reg.css">
<link rel="stylesheet" href="../css/footer.css">
<script src="../js/func.js" type="text/javascript"></script>
</head>
<body>
	<%@include file="nav.jsp"%>
	
	<div class="basic-grey">
		
        <form action="../../regmember" method="post" name="form" onsubmit="return validateForm()">
            <h1>会员注册
                <span>欢迎注册成为会员</span>
            </h1>
    
   			 <label>
                <span>Your User Name :</span>
                <input id="user_name" type="text" name="username" placeholder="Your User Name" required="required"/>
            </label>
            <label>
                <span>Your Phone Number :</span>
                <input id="Phone" type="text" name="phone" placeholder="Your Phone Number" required="required"/>
            </label>
    
            <label>
                <span>Your Email :</span>
                <input id="email" type="email" name="email" placeholder="Valid Email Address" required="required"/>
            </label>
            <label>
                <span>Password :</span>
                <input id="password" type="password" name="password" placeholder="Your Password" required="required"/>
            </label>
            <label>
                <span>Confirm Password:</span>
                <input id="Confirm" type="password" name="Confirm" placeholder="Confirm Your Password" required="required"/>
            </label>
    
            <label>
                <span>&nbsp;</span>
                <input type="submit" class="button" id="submit" value="Send" />
                <input type="reset" class="button" id="reset" value="Reset" />
            </label>
            <% String codeString=request.getParameter("code");
			if (codeString!=null){
				if(codeString.equals("f_UN_ID")){
					out.println("<label><h3 style=\"color:red;\">该用户已注册</h3></label>");
				}else if(codeString.equals("f_UN_Name")){
					out.println("<label><h3 style=\"color:red;\">该用户名已被使用</h3></label>");
				}
			}
		
		%>
        </form>
    </div>
    <%@include file="footer2.jsp" %>
</body>
</html>