<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!--#include file="../Inc/config.asp"-->
<!--#include file="../Inc/function.asp"-->
<%
checkLogin("AdminLogin.asp")
dim i,sql,msgid,did
select case request.QueryString("stype")
   case ""
   sql="select * from [qy_msg] order by m_time desc"
   case "all"   
   sql="select * from [qy_msg] order by m_time desc"
   case "check"
   sql="select * from [qy_msg] where m_check=true order by m_time desc"
   case "uncheck"
   sql="select * from [qy_msg] where m_check=false order by m_time desc"
   case "replace"
   sql="select * from [qy_msg] where isnull(m_replace)=false order by m_time desc"
   case "unreplace"
   sql="select * from [qy_msg] where isnull(m_replace)=true order by m_time desc"
end select
if request.QueryString("act")<>"del" and request.QueryString("act")<>"" then
msgid=request.Form("msgid")
 if msgid="" then
   alertInfo("未选中要处理的项目")	
 end if
end if
DBopen("../QY_DB/#qyz#.mdb")
select case request.QueryString("act")
   case "del"
   did=safeRequest(trim(request.QueryString("did")))
   conn.execute"delete from [qy_msg] where m_id="&did
   checkErr "删除","messagelist.asp"
   case "dels"
   conn.execute"delete from [qy_msg] where m_id in("&msgid&")"
   checkErr "批量删除","messagelist.asp"
   case "checks"
   conn.execute"update [qy_msg] set m_check=true where m_id in("&msgid&")"
   checkErr "批量审核","messagelist.asp"
   case "unchecks"
   conn.execute"update [qy_msg] set m_check=false where m_id in("&msgid&")"
   checkErr "取消审核","messagelist.asp"
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

<body>
<form action="" method="post" name="form1" id="form1">

<div id="maintxt">
<span class="m_top">留言列表<select name="select" class="select" id="select" onchange="javascript:location='messagelist.asp?stype='+this.value">
  <option value="all" <%if request.QueryString("stype")="all" then response.Write("selected") end if%>>所有分类</option>
  <option value="check" <%if request.QueryString("stype")="check" then response.Write("selected") end if%>>已审核留言</option>
  <option value="uncheck" <%if request.QueryString("stype")="uncheck" then response.Write("selected") end if%>>未审核留言</option>
  <option value="replace" <%if request.QueryString("stype")="replace" then response.Write("selected") end if%>>已回复留言</option>
  <option value="unreplace" <%if request.QueryString("stype")="unreplace" then response.Write("selected") end if%>>未回复留言</option>
  </select>
按分类查看 　　　　
  　　　
<input name="button1" type="submit" class="Aniu2" id="button3" value="批量删除" onclick="changeAction('messagelist.asp?act=dels')" />
<input name="button2" type="button" class="Aniu2" id="button" value="批量审核" onclick="changeAction('messagelist.asp?act=checks')"/>
<input name="button3" type="button" class="Aniu2" id="button2" value="取消审核" onclick="changeAction('messagelist.asp?act=unchecks')" />
</span>
<div id="list">
  <table width="100%" border="0" cellpadding="0" cellspacing="0" class="ttable">
    <tr class="color">
      <td height="25"><input type="checkbox" name="ck" id="ck" onclick="ChkAllClick('msgid','ck')" title="全选/取消"/></td>
      <td height="25">留言标题</td>
      <td width="4" height="25" bgcolor="#FFFFFF">&nbsp;</td>
      <td width="79">IP</td>
      <td width="4" bgcolor="#FFFFFF"></td>
      <td width="82">时间</td>
      <td width="3" bgcolor="#FFFFFF"></td>
      <td width="125">操作</td>
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
      <td width="26" height="25"><input type="checkbox" name="msgid"  value="<%=rs("m_id")%>" /></td>
      <td width="333" height="25"><div align="left"><%=getSubString(rs("m_content"),9)%>
	  <%if rs("m_check")=true then response.Write("<strong style='color:red'>[已审核]</strong>") else response.Write("<strong style='color:red'>[未审核]</strong>") end if%>
      <%if isnull(rs("m_replace"))=false then response.Write("<strong style='color:red'>[已回复]</strong>") else response.Write("<strong style='color:red'>[未回复]</strong>") end if%></div></td>
      <td width="4" bgcolor="#FFFFFF">&nbsp;</td>
      <td><%=rs("m_ip")%></td>
      <td bgcolor="#FFFFFF"></td>
      <td><%=Format_Time(rs("m_time"),6)%></td>
      <td bgcolor="#FFFFFF"></td>
      <td><a href="message.asp?act=replaces&rid=<%=rs("m_id")%>">回复</a>　　<a href="messagelist.asp?act=del&did=<%=rs("m_id")%>" onclick="javascript:return confirm('你确定要删除此项吗？')">删除</a></td>
    </tr>
    <%
	rs.movenext
	next
	%>
  </table>
</div>
<!--End of preamble-->
<span class="m_bottom">
<%writePage(Url_address("page"))%>
</span></div>
<!--End of maintxt-->
</form>
<%DBclose()%></body>
</html>