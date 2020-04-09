<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!--#include file="../Inc/config.asp"-->
<!--#include file="../Inc/function.asp"-->
<%
checkLogin("AdminLogin.asp")
dim jid,sql,i
sql="select * from qy_job"
DBopen("../QY_DB/#qyz#.mdb")
if request.QueryString("act")<>"del" and request.QueryString("act")<>"" then
jid=request.Form("jid")
 if jid="" then
   alertInfo("未选中要处理的项目")	
 end if
end if
select case request.QueryString("act")
   case "del"
   jid=safeRequest(trim(request.QueryString("jid")))
   conn.execute "delete from [qy_job] where j_id="&jid
   checkErr "删除","joblist.asp"
   case "dels"
   conn.execute "delete from [qy_job] where j_id in("&jid&")"
   checkErr "批量删除","joblist.asp"
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
<script type="text/javascript" src="style/js/jquery132.js"></script>
<script type="text/javascript" src="style/js/jquery.tools.js"></script>
<script type="text/javascript" src="style/js/jNice.js"></script>
<script language="javascript" src="style/js/fileup.js"></script>
<script language="javascript" src="style/js/js_fucntion.js"></script>

</head>

<body><form id="form1" name="form1" method="post" action="">
<div id="maintxt">
<span class="m_top">招聘信息列表 　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　
<input name="button" type="submit" class="Aniu2" id="button" value="批量删除" onclick="changeAction('joblist.asp?act=dels')" />
</span>
<div id="list">
  <table width="100%" border="0" cellpadding="0" cellspacing="0" class="ttable">
    <tr class="color">
      <td height="25">            <input type="checkbox" name="ck" id="checkbox2" title="全选/取消" onclick="ChkAllClick('jid','ck')" />      </td>
      <td height="25">招聘职位</td>
      <td width="2" bgcolor="#FFFFFF"></td>
      <td width="45">人数</td>
      <td width="2" bgcolor="#FFFFFF"></td>
      <td width="195">职位介绍/任职资格</td>
      <td width="2" bgcolor="#FFFFFF"></td>
      <td width="92">时间</td>
      <td width="2" bgcolor="#FFFFFF"></td>
      <td width="142">操作</td>
    </tr>
    <%
	page 5,sql
	if rs.eof and rs.bof then
	response.Write("<tr><td colspan='10'>没有记录</td></tr>")
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
      <td width="32" height="25"><input type="checkbox" name="jid" id="checkbox" value="<%=rs("j_id")%>" /></td>
      <td width="142" height="25"><%=rs("j_zw")%></td>
      <td bgcolor="#FFFFFF"></td>
      <td><%=rs("j_number")%></td>
      <td bgcolor="#FFFFFF"></td>
      <td><a href="javascript:void(0);" name="pic" target="_blank" class="thickboxs" id="pic" style="text-decoration:none;" rel="#xiInfo<%=i%>">详细信息</a>       </td>
      <td bgcolor="#FFFFFF"></td>
      <td><%=Format_Time(rs("j_time"),6)%></td>
      <td bgcolor="#FFFFFF"></td>
      <td><a href="job.asp?act=Edit&jid=<%=rs("j_id")%>">编辑</a>　　<a href="joblist.asp?act=del&jid=<%=rs("j_id")%>">删除</a></td>
    </tr>
     <div id="xiInfo<%=i%>" style="display:none;" class="xiInfo">
      <h2>职位介绍：</h2>
      <%=rs("j_info")%>
      <h2>任职资格：</h2>
      <%=rs("j_want")%>
      <br/>
      <span>按ESC键返回招聘信息列表</span>
      </div>
    <%
	rs.movenext
	next
	%>
  </table>
</div>
<!--End of preamble-->
<span class="m_bottom">
<%writePage(Url_address("page"))%></span>
</div></form>
<!--End of maintxt-->

  <%DBclose()%>
 </body>
</html>