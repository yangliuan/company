<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!--#include file="../Inc/config.asp"-->
<!--#include file="../Inc/function.asp"-->
<!--#include file="../Inc/md5.asp"-->
<%
checkLogin("AdminLogin.asp")
dim formAction,buttonTxt
if request.QueryString("act")<>"Edit" then
formAction="adminuser.asp?act=add"
buttonTxt="添加"
else
formAction="?act=up&sysID="&request.QueryString("sysID")
buttonTxt="更改"
end if

DBopen("../QY_DB/#qyz#.mdb")
dim ID,PWD,sysID,username,password
ID=safeInstr(trim(request.Form("ID")))
PWD=safeInstr(trim(request.Form("PWD")))

select case request.QueryString("act")
  case "add"
  if ID<>"" and PWD<>"" then
  rs.open "select * from system",conn,1,3
  rs.addnew
  rs("s_adminuser")=ID
  rs("s_adminpassword")=EnPas(md5(PWD))
  rs("s_pwyz")=PWD
  rs.update
  rs.close
  checkErr"添加管理员","adminuser.asp"
  else
  alertInfo("用户名密码不能为空")
  end if
  
  case "Edit"
  sysID=safeRequest(trim(request.QueryString("sysID")))
  rs.open "select * from [system] where s_id="&sysID,conn,1,1
  username=rs("s_adminuser")
  password=rs("s_pwyz")
  rs.close
  
  case "up"
  sysID=safeRequest(trim(request.QueryString("sysID")))
  if ID<>"" and PWD<>"" then
  rs.open "select * from [system] where s_id="&sysID,conn,1,3
  rs("s_adminuser")=ID
  rs("s_adminpassword")=EnPas(md5(PWD))
  rs("s_pwyz")=PWD
  rs.update
  rs.close
  checkErr"修改","adminuser.asp"
  else
  alertInfo("用户名密码不能为空")
  end if
  
  case "del"
  sysID=safeRequest(trim(request.QueryString("sysID")))
  conn.execute "delete from [system] where s_id="&sysID
  checkErr"删除","adminuser.asp"
  
end select 
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>管理员用户设置</title>
<style type="text/css">
<!--
@import url("style/css/style.css");
-->
</style>
</head>
<body>

<form id="form1" name="form1" method="post" action="<%=formAction%>">
<div id="maintxt">
<span class="m_top">管理员用户设置</span>
<div id="preamble">
  <table width="100%" border="0" cellspacing="0" cellpadding="0" >
    <tr>
      <td height="15" colspan="5">&nbsp;</td>
      </tr>
    <tr class="color">
      <td width="220" height="25"><div align="center">用户名</div></td>
      <td width="4" bgcolor="#FFFFFF">&nbsp;</td>
      <td width="225"><div align="center">密码</div></td>
      <td width="4" bgcolor="#FFFFFF">&nbsp;</td>
      <td width="203"><div align="center">操作</div></td>
    </tr>
    <%
	rs.open "select * from [system] where isnull(s_adminuser)=false and isnull(s_adminpassword)=false and isnull(s_pwyz)=false",conn,1,1
	if rs.eof and rs.bof then
	response.Write("<tr><td colspan='5' align='center'>没有记录</td></tr>")
	end if
    c1="#ffffff"
    c2="#D5DFE9"
    cr=c2
	while not rs.eof
	%>
    <tr bgcolor="<%call changeCL(c1,c2)%>">
      <td height="25"><div align="center"><%=rs("s_adminuser")%></div></td>
      <td bgcolor="#FFFFFF">&nbsp;</td>
      <td><div align="center"><%=rs("s_pwyz")%></div></td>
      <td bgcolor="#FFFFFF">&nbsp;</td>
      <td><div align="center"><a href="adminuser.asp?act=Edit&sysID=<%=rs("s_id")%>">编辑</a>　　<a href="adminuser.asp?act=del&sysID=<%=rs("s_id")%>" onclick="javascript:return confirm("你确定要删除此项吗？")">删除</a></div></td>
    </tr>
    <%
	rs.movenext
	wend
	rs.close
    
	%>
    <tr>
    <td height="25" colspan="5"></td>
    </tr>
    <tr class="color">
      <td height="30" class="ttable">&nbsp;用户名：</td>
      <td bgcolor="#FFFFFF">&nbsp;</td>
      <td colspan="3"><input name="ID" type="text" id="ID" value="<%=username%>" size="40" maxlength="50"/></td>
      </tr>
    <tr>
      <td height="30" class="ttable">&nbsp;密码：</td>
      <td>&nbsp;</td>
      <td colspan="3"><input name="PWD" type="password" id="PWD" value="<%=password%>" size="40" maxlength="50" /></td>
    </tr>
  </table>
  <div id="userinfo">
  <ol>
  <dt></dt>
  <dt>管理员用户注册说明：</dt>
  <dl>1.用户名和密码可以由字母，数字，字符组成，最大长度不得超过50字符。</dl>
  <dl>2.不得使用"'",";","&","=","%","<",">","^","and","or","not","insert","select","update","delete"等非法字符。</dl>
  </ol>
  </div>
</div>
<!--End of preamble--><span class="m_bottom">
<input name="button" type="submit" class="Aniu" id="button" value="<%=buttonTxt%>" />
<input name="button2" type="reset" class="Aniu" id="button2" value="重置" />
</span></div>
<!--End of maintxt-->
</form>
<%DBclose()%>
</body>
</html>
