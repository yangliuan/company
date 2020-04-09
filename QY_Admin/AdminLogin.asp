<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!--#include file="../Inc/config.asp"-->
<!--#include file="../Inc/function.asp"-->
<!--#include file="../Inc/md5.asp"-->
<%
if request.QueryString("act")="LoginOut" then
   session("adminName")=""
   session("checkLogin")=""
end if
if request.QueryString("act") = "login" then
	dim username,userpass,getcode
	username = trim(request.Form("username"))
	userpass = trim(request.Form("userpass"))
	getcode = trim(request.Form("getcode"))
	if getcode <> Session("GetCode") then
		Session("GetCode") = ""
		response.Write("验证码错误!")
		response.End()
	end if
	if username = "" or  userpass = "" then
		response.Write("请添写完整!")
		response.End()
	end if
	
   DBopen("../QY_DB/#qyz#.mdb")
   rs.open "select * from system where s_adminuser='"&username&"' and s_adminpassword='"&EnPas(md5(userpass))&"'",conn,1,1
     if rs.eof and rs.bof then
        response.Write("用户名或密码错误!")
		response.End()
     else
	    session("adminName")=username
        session("checkLogin")=true
	    response.Write("0")
	 end if
	 DBclose
	 response.End()
end if

%>
<!DOCTYPE html PUBLIC "-//W3C//DD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>后台管理系统登录</title>
<link href="style/css/style.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="style/js/jquery132.js"></script>
<style type="text/css">
<!--
#ipt {
	height: 100px;
	width: auto;
	margin: 0px;
	padding: 0px;
}
#login  p {
	height: 25px;
	display: block;
	padding: 0px;
	margin-left: 150px;
	width: 300px;
	margin-top: 0px;
	margin-bottom: 3px;
	text-align: left;
	vertical-align: middle;
	font-family: "微软雅黑";
	font-size: 14px;
	font-weight: bold;
	color: #FFFFFF;
	line-height: 25px;
}
div.error {
	background-color:#FFFFFF;
	width:210px;
	color:#000000;
	height:20px;
	line-height:20px;
	margin-bottom:0px;
	display:none;
	margin-left: 205px;
	font-family: "微软雅黑";
	font-size: 14px;
	font-weight: bold;
	margin-top: 0px;
}
#codeimg {
	padding: 0px;
	line-height: 25px;
	margin: 0px;
	height: 24px;
}
-->
</style>
</head>

<body id="lg">
<div id="login">
<script language="javascript" type="text/javascript">
function cklogin(){
	$('.error').html('&nbsp;&nbsp;正在登陆...!');
	$('.error').show(300);	
	if ($('#UserName').val()==''){
		$('#UserName').focus();
		$('.error').html('&nbsp;&nbsp;用户名不能为空!');
		return;
	}
	if ($('#UserPass').val()==''){
		$('#UserPass').focus();
		$('.error').html('&nbsp;&nbsp;密码不能为空!');
		return;
	}
	if ($('#GetCode').val()==''){
		$('#GetCode').focus();
		$('.error').html('&nbsp;&nbsp;验证码不能为空!');
		return;
	}
	$.ajax({type:'POST',
		   url:'AdminLogin.asp?act=login',
		   data:'username='+escape($('#UserName').val())+'&userpass='+escape($('#UserPass').val())+'&getcode='+escape($('#GetCode').val()),
		   success:function(msg){
			   if(msg=='0'){window.location='default.asp';}
			   else{$('.error').html('&nbsp;&nbsp;'+msg);$('.error').show();}
			   if(msg=='验证码错误!'){$('#codeimg').attr('src','../Inc/getcode.asp?'+Math.random());}
		   }});
	//$('#codeimg').attr('src','../include/getcode.asp?'+Math.random());
}
function KeyDown()
{
    if (event.keyCode == 13)
    {
        event.returnValue=false;
        event.cancel = true;
        cklogin();
    }
}
</script>
<form>
  <table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
    <tr>
      <td height="55" background="style/images/L_top.gif"></td>
    </tr>
    <tr>
      <td height="223" bgcolor="#FFFFFF"><table width="551" height="232" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr>
          <td height="66" background="style/images/L_top2.gif"></td>
        </tr>
        <tr>
          <td height="150" bgcolor="#4D9CD8">
          <div id="ipt">
          <p><label>用户名：</label><input name="UserName" type="text" id="UserName" size="30" />
          </p>
          <p><label>密　码：</label><input name="UserPass" type="password" id="UserPass" size="30" />
          </p>
          <p><label>验证码：</label><input name="GetCode" type="text" id="GetCode" onkeydown="KeyDown()" size="20" /> 
            <img src="../Inc/getcode.asp?" name="codeimg" border="0" id="codeimg" onclick="this.src+=Math.random();" align="absmiddle" />            </p>
          </div>
          <div class="error">&nbsp;&nbsp;</div>          </td>
        </tr>
        <tr>
          <td height="16" background="style/images/L_bottom.gif"></td>
        </tr>
      </table></td>
    </tr>
    <tr>
      <td height="33" bgcolor="#FFFFFF">
         <div align="center"><a href="javascript:void(0);" onclick="cklogin();"><img src="style/images/L_button.gif" border="0" /></a></div></td>
    </tr>
    <tr>
      <td height="2" background="style/images/L_bottom2.gif"></td>
    </tr>
  </table>
</form> 
</div>
</body>
</html>
