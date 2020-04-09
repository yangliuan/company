<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!--#include file="../Inc/config.asp"-->
<!--#include file="../Inc/function.asp"-->
<!--#include file="../fckeditor/fckeditor.asp"-->
<%
checkLogin("AdminLogin.asp")
dim rid
nameArray=Array("m_id","m_title","m_content","m_contact","m_ip","m_replace")
DBopen("../QY_DB/#qyz#.mdb")
select case request.QueryString("act")
   case "replaces"
   rid=safeRequest(trim(request.QueryString("rid")))
   editShow "select * from [qy_msg] where m_id="&rid,nameArray,valueArray,Ubound(nameArray)
   case "up"
   rid=safeRequest(trim(request.QueryString("rid")))
   for h=1 to Ubound(nameArray)
   valueArray(h)=request.Form(nameArray(h))
   next
   if valueArray(1)="" or valueArray(2)="" or valueArray(4)="" or valueArray(5)="" then
   alertInfo("输入内容不能为空")
   else
   updateRecord "select * from [qy_msg] where m_id="&rid,nameArray,valueArraY,Ubound(nameArray)
   end if
  checkErr "回复成功","messagelist.asp" 
end select

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>无标题文档</title>
<style type="text/css">
<!--
@import url("style/css/style.css");
-->
</style>
<script type="text/javascript" src="style/js/jquery132.js"></script>
<script type="text/javascript" src="style/js/jquery.tools.js"></script>
<script type="text/javascript" src="style/js/jNice.js"></script>
<script language="javascript" src="style/js/fileup.js"></script>
</head>

<body><form id="form1" name="form1" method="post" action="message.asp?act=up&rid=<%=request.QueryString("rid")%>">
<div id="maintxt">
<span class="m_top">留言回复</span>
<div id="preamble">
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td width="158">&nbsp;</td>
      <td width="4">&nbsp;</td>
      <td width="488" height="15">&nbsp;</td>
    </tr>
    <tr class="color">
      <td height="25" class="ttable">留言标题：</td>
      <td bgcolor="#FFFFFF">&nbsp;</td>
      <td height="30"><input name="m_title" type="text" id="m_title" size="40" value="<%=valueArray(1)%>" /></td>
    </tr>
    <tr>
      <td class="ttable">联系方式：</td>
      <td bgcolor="#FFFFFF">&nbsp;</td>
      <td height="30"><input name="m_contant" type="text" id="m_contant" size="40" value="<%=valueArray(3)%>" /></td>
    </tr>
    <tr class="color">
      <td class="ttable">IP地址：</td>
      <td bgcolor="#FFFFFF">&nbsp;</td>
      <td height="30"><input name="m_ip" type="text" id="m_ip" size="40" value="<%=valueArray(4)%>" /></td>
    </tr>
    <tr>
      <td class="ttable">留言内容：</td>
      <td bgcolor="#FFFFFF">&nbsp;</td>
      <td height="100"><textarea name="m_content" cols="55" rows="5" class="txt" id="m_content"><%=valueArray(2)%></textarea></td>
    </tr>
    <tr class="color">
      <td class="ttable">管理员回复：</td>
      <td bgcolor="#FFFFFF">&nbsp;</td>
      <td height="100"><textarea name="m_replace" cols="55" rows="5" class="txt" id="m_replace"><%=valueArray(5)%></textarea></td>
    </tr>
  </table>
</div>
<!--End of preamble-->
<span class="m_bottom">
<input name="button" type="submit" class="Aniu" id="button" value="回复" />
<input name="button2" type="reset" class="Aniu" id="button2" value="重置" />
</span></div>
<!--End of maintxt-->
</form>
<%DBclose()%></body>
</html>
