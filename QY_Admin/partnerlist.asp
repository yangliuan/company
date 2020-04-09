<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!--#include file="../Inc/config.asp"-->
<!--#include file="../Inc/function.asp"-->
<%
checkLogin("AdminLogin.asp")
dim pnid,sql,i
sql="select * from qy_partners"
DBopen("../QY_DB/#qyz#.mdb")
if request.QueryString("act")<>"del" and request.QueryString("act")<>"" then
pnid=request.Form("pnid")
 if pnid="" then
   alertInfo("未选中要处理的项目")	
 end if
end if
select case request.QueryString("act")
   case "del"
   pnid=safeRequest(trim(request.QueryString("pnid")))
   deleteFile "select * from [qy_partners] where p_id="&pnid,"ArtPic",""'删除图片
   conn.execute "delete from [qy_partners] where p_id="&pnid
   checkErr "删除","partnerlist.asp"
   case "dels"
   deleteFile "select * from [qy_partners] where p_id in("&pnid&")","ArtPic",""'批量删除图片
   conn.execute "delete from [qy_partners] where p_id in("&pnid&")"
   checkErr "批量删除","partnerlist.asp"
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
<span class="m_top">合作伙伴列表　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　
<input name="button" type="submit" class="Aniu2" id="button" value="批量删除" onclick="changeAction('partnerlist.asp?act=dels')"  />
</span>
<div id="list">
  <table width="100%" border="0" cellpadding="0" cellspacing="0" class="ttable">
    <tr class="color">
      <td height="25"><input type="checkbox" name="ck" id="ck" onclick="ChkAllClick('pnid','ck')" title="全选/取消" /></td>
      <td height="25">合作伙伴</td>
      <td width="4" bgcolor="#FFFFFF"></td>
      <td width="33%">图片</td>
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
      <td width="4%" height="80"><input type="checkbox" name="pnid" id="checkbox" value="<%=rs("p_id")%>" /></td>
      <td width="36%" height="80"><%=rs("p_name")%></td>
      <td height="80" bgcolor="#FFFFFF"></td>
      <td height="80"><img width="161" height="63" src="<%=rs("ArtPic")%>"/></td>
      <td height="80" bgcolor="#FFFFFF"></td>
      <td height="80"><a href="partner.asp?act=Edit&pnid=<%=rs("p_id")%>">编辑</a>　　<a href="partnerlist.asp?act=del&pnid=<%=rs("p_id")%>">删除</a></td>
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
