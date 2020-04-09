<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!--#include file="../Inc/config.asp"-->
<!--#include file="../Inc/function.asp"-->
<!--#include file="../fckeditor/fckeditor.asp"-->
<%
checkLogin("AdminLogin.asp")
dim title,buttonTxt,formAction,jid
nameArray=Array("j_id","j_zw","j_number","j_info","j_want","j_daiyu","j_location")
if request.QueryString("act")<>"Edit" then
title="添加招聘信息"
buttonTxt="添加"
formAction="job.asp?act=add"
else
title="编辑招聘信息"
buttonTxt="更改"
formAction="job.asp?act=up&jid="&request.QueryString("jid")
end if
'取值
if request.QueryString("act")<>"" and request.QueryString("act")<>"Edit" then
for h=1 to Ubound(nameArray)
valueArray(h)=request.Form(nameArray(h))
next
'取值条件
if valueArray(1)="" or valueArray(2)="" or valueArray(3)="" or valueArray(4)="" or valueArray(5)="" or valueArray(6)=""  then alertInfo("输入内容不能为空") end if
end if
DBopen("../QY_DB/#qyz#.mdb")
select case request.QueryString("act")
   case "add"
   addRecord "select * from [qy_job]",nameArray,valueArray,Ubound(nameArray)
   checkErr "添加招聘信息","joblist.asp"
   case "Edit"
   jid=safeRequest(trim(request.QueryString("jid")))   
   editShow "select * from [qy_job] where j_id="&jid,nameArray,valueArray,Ubound(nameArray)
   case "up"
   jid=safeRequest(trim(request.QueryString("jid")))
   updateRecord "select * from [qy_job] where j_id="&jid,nameArray,valueArray,Ubound(nameArray)
   checkErr "更改招聘信息","joblist.asp"
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

<body><form id="form1" name="form1" method="post" action="<%=formAction%>">
<div id="maintxt">
<span class="m_top"><%=title%></span>
<div id="preamble">
  <table width="100%" height="135" border="0" cellpadding="0" cellspacing="0">
    <tr>
      <td height="15" colspan="3">&nbsp;</td>
      </tr>
    <tr class="color">
      <td width="140" height="25" class="ttable">招聘职位：</td>
      <td width="4" height="25" bgcolor="#FFFFFF">&nbsp;</td>
      <td width="512" height="30">
        <input name="j_zw" type="text" id="j_zw" size="40" value="<%=valueArray(1)%>" />      </td>
    </tr>
    <tr>
      <td height="25" class="ttable">招聘人数：</td>
      <td width="4" height="25" bgcolor="#FFFFFF">&nbsp;</td>
      <td height="30"><input name="j_number" type="text" id="j_number" size="40" value="<%=valueArray(2)%>" /></td>
    </tr>
    <tr class="color">
      <td height="25" class="ttable">职位介绍：</td>
      <td height="25" bgcolor="#FFFFFF">&nbsp;</td>
      <td height="30"><input name="j_info" type="text" id="j_info" size="40" value="<%=valueArray(3)%>"/></td>
    </tr>
   <tr>
      <td height="25" class="ttable">月　　薪：</td>
      <td height="25" bgcolor="#FFFFFF">&nbsp;</td>
      <td height="30"><input name="j_daiyu" type="text" id="j_daiyu" size="40" value="<%=valueArray(5)%>" /></td>
    </tr>
    <tr class="color">
      <td height="25" class="ttable">工作地点：</td>
      <td height="25" bgcolor="#FFFFFF">&nbsp;</td>
      <td height="30"><input name="j_location" type="text" id="j_location" size="40" value="<%=valueArray(6)%>"/></td>
    </tr>
    <tr>
      <td height="25" class="ttable">任职资格：</td>
      <td height="25" bgcolor="#FFFFFF">&nbsp;</td>
      <td height="30"><% 
         Dim oFCKeditor
         Set oFCKeditor = New FCKeditor
         oFCKeditor.BasePath = "../FCKeditor/"  ' 设置编辑器的路径，我站点根目录下的一个目录
         oFCKeditor.ToolbarSet = "Default"  ' 工具条名称
         oFCKeditor.Width = "100%"   ' 编辑器宽度
         oFCKeditor.Height = "430"  '  编辑器高
		 oFCKeditor.Value  =valueArray(4)  ' 这个是给编辑器初始值
         oFCKeditor.Create "j_want" ' 以后编辑器里的内容都是由这个content取得，命名由你定。相当于表单文本框的名称。
		 %></td>
    </tr>
   </table>
</div>
<!--End of preamble-->
<span class="m_bottom">
<input name="button" type="submit" class="Aniu" id="button" value="<%=buttonTxt%>" />
<input name="button2" type="reset" class="Aniu" id="button2" value="重置" />
</span></div>
<!--End of maintxt-->
</form>
<%DBclose()%></body>
</html>
