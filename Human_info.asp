<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!--#include file="Inc/config.asp"-->
<!--#include file="Inc/function.asp"-->
<!--#include file="Inc/topWeb.asp"-->
<%
dim jid,job_info,job_want
if request.QueryString("act")="show" then
jid=safeRequest(request.QueryString("jid"))
DBopen("QY_DB/#qyz#.mdb")
rs.open "select * from qy_job where j_id="&jid,conn,1,1
job_info=rs("j_info")
job_want=rs("j_want")
DBclose()
else
alertInfo("参数错误")
end if
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>无标题文档</title>
<style type="text/css">
<!--
#job_info {
	height: auto;
	width: 400px;
	margin-right: auto;
	margin-left: auto;
	border: 8px solid #999999;
	font-family: "微软雅黑";
	font-size: 12px;
	color: #666666;
}
#job_info h1 {
	display: block;
	text-align: center;
	font-family: "微软雅黑";
	font-size: 18px;
	font-weight: bold;
	color: #333333;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 10px;
	margin-left: 0px;
	border-bottom-width: 1px;
	border-bottom-style: dashed;
	border-bottom-color: #666666;
}
#job_info h2 {
	font-family: "微软雅黑";
	font-size: 14px;
	font-weight: bold;
	color: #666666;
	height: 25px;
	width: 100%;
	display: block;
	margin: 0px;
	padding: 0px;
}
#job_info p {
	padding: 5px;
	font-family: "微软雅黑";
	font-size: 12px;
	color: #666666;
	margin: 0px;
}
-->
</style>
</head>

<body>
<div id="job_info">
<h1>详细信息</h1>
<h2>职位介绍：</h2>
<p><%=job_info%></p>
<h2>任职资格:</h2>
<%=job_want%>
</div>
</body>
</html>
