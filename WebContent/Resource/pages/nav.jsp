<%--
	Created by Eclipse.
  	@author geroge
 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>

<style>
	*{padding:0;list-style-type:none;}
	
	body{
  background: #ebebeb;
}
.nav {
    width: 960px;
    height: 50px;
    font: bold 0/50px Arial;
    text-align: center;
    border-radius: 8px;
    margin-left: auto;
    margin-right: auto;
    margin-top: 5px;
}
	.nav a{display: inline-block;
		-webkit-transition: all 0.2s ease-in;
		-moz-transition: all 0.2s ease-in;
  -o-transition: all 0.2s ease-in;
  -ms-transition: all 0.2s ease-in;
  transition: all 0.2s ease-in;
	}
	.nav a:hover{
		-webkit-transform:rotate(10deg);
		-moz-transform:rotate(10deg);
  -o-transform:rotate(10deg);
  -ms-transform:rotate(10deg);
  transform:rotate(10deg);
	}
		.blue{
  background: #36b7e5;
  box-shadow: 0 7px 0 #3595b8;
}.nav li{
  position:relative;
  display:inline-block;
  padding:0 30px;
  font-size: 13px;
		text-shadow:1px 2px 4px rgba(0,0,0,.5);
  list-style: none outside none;
	}

	.nav li::before,
.nav li::after{
  content:"";
  position:absolute;
  top:14px;
  height: 25px;
  width: 1px;
 }
	.nav li::after{
  right: 0;
		background: -moz-linear-gradient(top, rgba(255,255,255,0), rgba(255,255,255,.2) 50%, rgba(255,255,255,0));
		background: -webkit-linear-gradient(top, rgba(255,255,255,0), rgba(255,255,255,.2) 50%, rgba(255,255,255,0));
		background: -o-linear-gradient(top, rgba(255,255,255,0), rgba(255,255,255,.2) 50%, rgba(255,255,255,0));
  background: -ms-linear-gradient(top, rgba(255,255,255,0), rgba(255,255,255,.2) 50%, rgba(255,255,255,0));
  background: linear-gradient(top, rgba(255,255,255,0), rgba(255,255,255,.2) 50%, rgba(255,255,255,0));
	}
	.blue li::before{
  left: 0;
		background: -moz-linear-gradient(top, #34b0dc, #237a99 50%, #34b0dc);
		background: -webkit-linear-gradient(top, #34b0dc, #237a99 50%, #34b0dc);
		background: -o-linear-gradient(top, #34b0dc, #237a99 50%, #34b0dc);
  background: -ms-linear-gradient(top, #34b0dc, #237a99 50%, #34b0dc);
  background: linear-gradient(top, #34b0dc, #237a99 50%, #34b0dc);
	}
		.nav li:first-child::before{
  background: none;
}
	.nav li:last-child::after{
  background: none;
}

	.nav a,
.nav a:hover{
  color:#fff;
  text-decoration: none;
 }
</style>
<ul class="nav blue">
      <li><a href="cosmetics.jsp">化妆品</a></li>
      <li><a href="Bags.jsp">手袋&包包</a></li>
      <li><a href="jewelry.jsp">手表&手饰</a></li>
      <li><a href="fashion.jsp">时尚</a></li>
      <li><a href="gift.jsp">礼物</a></li>
      <li><a href="e-magazine.jsp">电子杂志</a></li>
      <li><a href="#">最新活动</a></li>
</ul>
