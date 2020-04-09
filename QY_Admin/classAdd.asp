<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!--#include file="../Inc/config.asp"-->
<!--#include file="../Inc/function.asp"-->
<!--#include file="../Inc/md5.asp"-->
<%
checkLogin("AdminLogin.asp")
dim CID,formAction,title,sql,classname,flmc,id
CID=safeRequest(trim(request.QueryString("CID")))
if CID<>1 and CID<>2 then 
 response.Write("<script>alert('参数错误');window.location.href='default.asp'</script>")
 response.End()   
end if
if CID=1 then

title="新闻分类管理"
sql="select * from [qy_class] where c_type=1"
if request.QueryString("act")<>"edit" then
formAction="classAdd.asp?CID=1&act=add"
else
formAction="classAdd.asp?CID=1&act=up&id="&request.QueryString("id")
end if

else

title="产品分类管理"
sql="select * from [qy_class] where c_type=2"
if request.QueryString("act")<>"edit" then
formAction="classAdd.asp?CID=2&act=add"
else
formAction="classAdd.asp?CID=2&act=up&id="&request.QueryString("id")
end if

end if 
classname=safeInstr(trim(request.form("classname")))
DBopen("../QY_DB/#qyz#.mdb")
select case request.QueryString("act")
   case "add"
    if classname="" then
      alertInfo("分类名称不能为空")
	else
       if CID=1 then
       rs.open "select * from [qy_class]",conn,1,3
	   rs.addnew
	   rs("c_type")=1
	   rs("c_name")=classname
	   rs.update
	   rs.close
	   else
       rs.open "select * from [qy_class]",conn,1,3
	   rs.addnew
	   rs("c_type")=2
	   rs("c_name")=classname
	   rs.update
	   rs.close
       end if
	  checkErr "添加分类","classAdd.asp?CID="&CID 
   end if
   case "edit"
   id=safeRequest(trim(request.QueryString("id")))
   rs.open"select * from [qy_class] where c_id="&id,conn,1,1
   flmc=rs("c_name")
   rs.close
   case "up"
   id=safeRequest(trim(request.QueryString("id")))
   if classname="" then
      alertInfo("分类名称不能为空")
   else
   rs.open"select * from [qy_class] where c_id="&id,conn,1,3
   rs("c_name")=classname
   rs.update
   rs.close
   end if
   checkErr "更改分类","classAdd.asp?CID="&CID 
   case "del"
   id=safeRequest(trim(request.QueryString("id")))
   conn.execute "delete from [qy_class] where c_id="&id
   checkErr "删除分类","classAdd.asp?CID="&CID
end select
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title></title>
<style type="text/css">
<!--
@import url("style/css/style.css");
-->
</style>
</head>
<body>

<form id="form1" name="form1" method="post" action="<%=formAction%>">
<div id="maintxt">
<span class="m_top"><%=title%></span>
<div id="preamble">
  <table width="100%" border="0" cellspacing="0" cellpadding="0" >
    <tr>
      <td height="15" colspan="5">&nbsp;</td>
      </tr>
    <tr class="color">
      <td height="25" colspan="3"><div align="center">分类名称</div></td>
      <td width="4" bgcolor="#FFFFFF"></td>
      <td width="234"><div align="center">操作</div></td>
    </tr>
    <%
	rs.open sql,conn,1,1
	if rs.eof and rs.bof then
	response.Write("<tr><td colspan='5' align='center'>没有记录</td></tr>")
	end if
    c1="#ffffff"
    c2="#D5DFE9"
    cr=c2
	while not rs.eof
	%>
    <tr bgcolor="<%call changeCL(c1,c2)%>">
      <td height="25" colspan="3"><div align="center"><%=rs("c_name")%></div></td>
      <td bgcolor="#FFFFFF"></td>
      <td><div align="center"><a href="classAdd.asp?act=edit&id=<%=rs("c_id")%>&CID=<%=request.QueryString("CID")%>">编辑</a>　　<a href="classAdd.asp?act=del&id=<%=rs("c_id")%>&CID=<%=request.QueryString("CID")%>" onclick="javascript:return confirm("你确定要删除此项吗？")">删除</a></div></td>
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
      <td width="220" height="30" class="ttable">&nbsp;分类名称：</td>
      <td width="4" bgcolor="#FFFFFF">&nbsp;</td>
      <td colspan="3"><input name="classname" type="text" id="classname" size="40" value="<%=flmc%>"/></td>
      </tr>
  </table>
  </div>
<!--End of preamble--><span class="m_bottom">
<input name="button" type="submit" class="Aniu" id="button" value="提交" />
<input name="button2" type="reset" class="Aniu" id="button2" value="重置" />
</span></div>
<!--End of maintxt-->
</form>
<%DBclose()%>
</body>
</html>
