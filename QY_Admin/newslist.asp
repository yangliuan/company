<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!--#include file="../Inc/config.asp"-->
<!--#include file="../Inc/function.asp"-->
<%
checkLogin("AdminLogin.asp")
dim stype,sql,i,nid
if request.QueryString("stype")="" then
stype=0
else
stype=safeRequest(int(trim(request.QueryString("stype"))))
end if
if stype=0 then
session("stype")=0
sql="select * from [qy_news] order by n_time desc"
else
session("stype")=""
session("stype")=stype
sql="select * from [qy_news] where n_cid="&stype&" order by n_time desc"
end if
DBopen("../QY_DB/#qyz#.mdb")
if request.QueryString("act")<>"del" and request.QueryString("act")<>"" then
nid=request.Form("nid")
 if nid="" then
   alertInfo("未选中要处理的项目")	
 end if
end if
select case request.QueryString("act")
   case "del"
   nid=safeRequest(trim(request.QueryString("nid")))
   deleteFile "select * from [qy_news] where n_id="&nid,"ArtPic",""'删除图片
   conn.execute "delete from [qy_news] where n_id="&nid
   checkErr "删除","newslist.asp"
   case "dels"
   deleteFile "select * from [qy_news] where n_id in("&nid&")","ArtPic",""'批量删除图片
   conn.execute "delete from [qy_news] where n_id in("&nid&")"
   checkErr "批量删除","newslist.asp"
   case "top"
   conn.execute "update [qy_news] set n_top=true where n_id in("&nid&")"
   checkErr "批量置顶","newslist.asp"
   case "untop"
   conn.execute "update [qy_news] set n_top=false where n_id in("&nid&")"
   checkErr"取消置顶","newslist.asp"
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
<span class="m_top">新闻列表
<select name="select" class="select"  onchange="javascript:location='newslist.asp?stype='+this.value">
  <option value="0" <%if session("stype")=0 then response.Write("selected") end if%>>所有分类</option>
  <%
  rs.open "select * from [qy_class] where c_type=1",conn,1,1
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
<input name="button" type="submit" class="Aniu2" id="button" value="批量删除" onclick="changeAction('newslist.asp?act=dels')" />
<input name="button2" type="button" class="Aniu2" id="button2" value="批量置顶" onclick="changeAction('newslist.asp?act=top')" />
<input name="button3" type="button" class="Aniu2" id="button3" value="取消置顶" onclick="changeAction('newslist.asp?act=untop')" />
</span>
<div id="list">
  <table width="100%" border="0" cellpadding="0" cellspacing="0" class="ttable">
    <tr class="color">
      <td height="25"><input type="checkbox" name="ck" id="ck"  onclick="ChkAllClick('nid','ck')" title="全选/取消" /></td>
      <td height="25">新闻标题</td>
      <td width="4" bgcolor="#FFFFFF"></td>
      <td width="98">时间</td>
      <td width="4" bgcolor="#FFFFFF"></td>
      <td width="171">操作</td>
    </tr>
    <%
	page 20,sql
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
      <td width="22" height="25"><input type="checkbox" name="nid" id="checkbox" value="<%=rs("n_id")%>" /></td>
      <td width="357" height="25"><div align="left"><%=getSubString(rs("n_title"),13)%><%if rs("n_top")=true then response.Write("<strong style='color:red'>[顶]</strong>") end if%></div></td>
      <td bgcolor="#FFFFFF"></td>
      <td><%=Format_Time(rs("n_time"),2)%></td>
      <td bgcolor="#FFFFFF"></td>
      <td><a href="#">查看</a>　 <a href="news.asp?act=Edit&nid=<%=rs("n_id")%>">编辑</a>　 <a href="newslist.asp?act=del&nid=<%=rs("n_id")%>" onclick="javascript:return confirm('你确定要删除此项吗？')">删除</a></td>
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