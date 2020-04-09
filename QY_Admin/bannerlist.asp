<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!--#include file="../Inc/config.asp"-->
<!--#include file="../Inc/function.asp"-->
<%
checkLogin("AdminLogin.asp")
dim bnid,sql,i
sql="select * from qy_banner"
DBopen("../QY_DB/#qyz#.mdb")
if request.QueryString("act")<>"del" and request.QueryString("act")<>"" then
bnid=request.Form("bnid")
 if bnid="" then
   alertInfo("未选中要处理的项目")	
 end if
end if
select case request.QueryString("act")
   case "c_show"
   conn.execute"update [qy_banner] set b_show=true where b_id in("&bnid&")"
   checkErr "首页显示","bannerlist.asp"
   case "c_unshow"
   conn.execute"update [qy_banner] set b_show=false where b_id in("&bnid&")"
   checkErr "取消显示","bannerlist.asp"
   case "del"
   bnid=safeRequest(trim(request.QueryString("bnid")))
   deleteFile "select * from [qy_banner] where b_id="&bnid,"ArtPic",""'删除图片
   conn.execute "delete from [qy_banner] where b_id="&bnid
   checkErr "删除","bannerlist.asp"
   case "dels"
   deleteFile "select * from [qy_banner] where b_id in("&bnid&")","ArtPic",""'批量删除图片
   conn.execute "delete from [qy_banner] where b_id in("&bnid&")"
   checkErr "批量删除","bannerlist.asp"
end select%>
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
<span class="m_top">广告列表 　 　　　　　　　　　　　　　　　　　　　　　　　　　
<input name="button2" type="submit" class="Aniu2" id="button2" value="首页显示" onclick="changeAction('bannerlist.asp?act=c_show')"  />
<input name="button2" type="submit" class="Aniu2" id="button2" value="取消显示" onclick="changeAction('bannerlist.asp?act=c_unshow')"  />
 <input name="button" type="submit" class="Aniu2" id="button" value="批量删除" onclick="changeAction('bannerlist.asp?act=dels')"  />
</span>
<div id="list">
  <table width="100%" border="0" cellpadding="0" cellspacing="0" class="ttable">
    <tr class="color">
      <td height="25"><input type="checkbox" name="ck" id="ck" onclick="ChkAllClick('bnid','ck')" title="全选/取消" /></td>
      <td height="25">广告标题</td>
      <td width="4" bgcolor="#FFFFFF"></td>
      <td width="222">图片</td>
      <td width="4" bgcolor="#FFFFFF"></td>
      <td width="70">首页显示</td>
      <td width="4" bgcolor="#FFFFFF"></td>
      <td width="174">操作</td>
     
    </tr>
   <%
	page 5,sql
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
      <td width="25" height="80"><input type="checkbox" name="bnid" id="checkbox" value="<%=rs("b_id")%>" /></td>
      <td width="155" height="80"><%=rs("b_title")%></td>
      <td height="4" bgcolor="#FFFFFF"></td>
      <td height="80"><img width="161" height="63" src="<%=rs("ArtPic")%>"/></td>
      <td width="4" bgcolor="#FFFFFF"></td>
      <td><%if rs("b_show")=true then response.Write("<strong style='color:red'>[已显示]</strong>") else response.Write("<strong style='color:red'>[未显示]</strong>") end if%></td>
      <td height="4" bgcolor="#FFFFFF"></td>
      <td height="80"><a href="banner.asp?act=Edit&bnid=<%=rs("b_id")%>">编辑</a>　　<a href="bannerlist.asp?act=del&bnid=<%=rs("b_id")%>">删除</a></td>
      </tr>
    <%
	rs.movenext
	next
	%>
  </table>
</div>
<!--End of preamble-->
<span class="m_bottom"><%writePage(Url_address("page"))%></span>
</div></form>
<!--End of maintxt-->
<%DBclose()%></body>
</html>
