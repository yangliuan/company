<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!--#include file="../Inc/config.asp"-->
<!--#include file="../Inc/function.asp"-->
<%
checkLogin("AdminLogin.asp")
dim stype,sql,i,pid
if request.QueryString("stype")="" then
stype=0
else
stype=safeRequest(int(trim(request.QueryString("stype"))))
end if
if stype=0 then
session("stype")=0
sql="select * from [qy_pro] order by p_time desc"
else
session("stype")=""
session("stype")=stype
sql="select * from [qy_pro] where p_cid="&stype&" order by p_time desc"
end if
DBopen("../QY_DB/#qyz#.mdb")
if request.QueryString("act")<>"del" and request.QueryString("act")<>"" then
pid=request.Form("pid")
 if pid="" then
   alertInfo("未选中要处理的项目")	
 end if
end if
select case request.QueryString("act")
   case "del"
   pid=safeRequest(trim(request.QueryString("pid")))
   deleteFile "select * from [qy_pro] where p_id="&pid,"ArtPic",""'删除图片
   conn.execute "delete from [qy_pro] where p_id="&pid
   checkErr "删除","prolist.asp"
   case "dels"
   deleteFile "select * from [qy_pro] where p_id in("&pid&")","ArtPic",""'批量删除图片
   conn.execute "delete from [qy_pro] where p_id in("&pid&")"
   checkErr "批量删除","prolist.asp"
end select

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>后台管理系统</title>
<style type="text/css">
<!--
@import url("style/css/style.css");
-->
</style>
<script language="javascript" src="style/js/js_fucntion.js"></script>
</head>

<body><form id="form1" name="form1" method="post" action="">
<div id="maintxt">
<span class="m_top">产品列表
<select name="select" class="select"  onchange="javascript:location='prolist.asp?stype='+this.value">
  <option value="0" <%if session("stype")=0 then response.Write("selected") end if%>>所有分类</option>
  <%
  rs.open "select * from [qy_class] where c_type=2",conn,1,1
  while not rs.eof
  %>
  <option value="<%=rs("c_id")%>" <%if session("stype")=rs("c_id") then response.Write("selected") end if%>><%=rs("c_name")%></option>
  <%
  rs.movenext
  wend
  rs.close
  %>
  </select>
按分类查看　　　　　　　　　　　　　　　　　     
<input name="button" type="submit" class="Aniu2" id="button" value="批量删除" onclick="changeAction('prolist.asp?act=dels')" /></span>
<div id="list">
  <table width="100%" border="0" cellpadding="0" cellspacing="0" class="ttable">
    <tr class="color">
      <td height="25"><input type="checkbox" name="ck" id="ck" onclick="ChkAllClick('pid','ck')"  title="全选/取消"/></td>
      <td height="25">产品名称</td>
      <td width="4" bgcolor="#FFFFFF"></td>
      <td width="33%">产品图片</td>
      <td width="4" bgcolor="#FFFFFF"></td>
      <td width="26%">操作</td>
    </tr>
    <%
	page 6,sql
	if rs.eof and rs.bof then
	response.Write("<tr><td colspan='6'>没有记录</td></tr>")
	end if
	c1="#ffffff"
    c2="#D5DFE9"
    cr=c2
	for i=1 to rs.pagesize
	if rs.eof then 
	exit for
	end if
	%>
    <tr bgcolor="<%call changeCL(c1,c2)%>">
      <td width="4%" height="80"><input type="checkbox" name="pid" id="checkbox" value="<%=rs("p_id")%>" /></td>
      <td width="36%" height="80"><%=rs("p_name")%></td>
      <td height="80" bgcolor="#FFFFFF"></td>
      <td height="80"><img src="..<%=rs("ArtPic")%>" width="161" height="63" /></td>
      <td height="80" bgcolor="#FFFFFF"></td>
      <td height="80"><a href="product.asp?act=Edit&pid=<%=rs("p_id")%>">编辑</a>　　<a href="prolist.asp?act=del&pid=<%=rs("p_id")%>" onclick="javascript:return confirm('你确定要删除此项吗？')">删除</a></td>
    </tr>
    <%
	rs.movenext
	next
	%>
  </table>
</div>
<!--End of preamble-->
<span class="m_bottom"><%writePage(Url_address("page"))%></span>
</div> 
</form>
<!--End of maintxt-->
<%DBclose()%></body>
</html>
