<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!--#include file="../Inc/config.asp"-->
<!--#include file="../Inc/function.asp"-->
<%checkLogin("AdminLogin.asp")%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>系统信息</title>
<style type="text/css">
<!--
@import url("style/css/style.css");
-->
</style>
</head>

<body>
<div id="maintxt">
<span class="m_top">服务器系统信息</span>
<div id="preamble">
<table width='100%' height="351" border=0 cellpadding=1 cellspacing=0 bordercolorlight=#c0c0c0 bordercolordark=#FFFFFF>
  <tr><td height="15" colspan=3 align=center bgcolor=#ffffff class=red_3>&nbsp;</td>
  </tr>
  <tr class="color"><td width="164" height="23">&nbsp;服务器名：</td>
    <td width="3" bgcolor="#FFFFFF"></td>
    <td width="483" height="23">&nbsp;
<%=Request.ServerVariables("SERVER_NAME")%></td></tr>
  <tr class="color2"><td height="23">&nbsp;服务器IP：</td>
    <td width="3" height="23" bgcolor="#FFFFFF"></td>
    <td height="23">&nbsp;
<%=Request.ServerVariables("LOCAL_ADDR")%></td></tr>
  <tr class="color"><td height="23">&nbsp;服务器端口：</td>
    <td width="3" height="23" bgcolor="#FFFFFF"></td>
    <td height="23">&nbsp;
<%=Request.ServerVariables("SERVER_PORT")%></td></tr>
  <tr class="color2"><td height="23">&nbsp;服务器时间：</td>
    <td width="3" height="23" bgcolor="#FFFFFF"></td>
    <td height="23">&nbsp;
<%=now%></td></tr>
  <tr class="color"><td height="23">&nbsp;IIS版本：</td>
    <td width="3" height="23" bgcolor="#FFFFFF"></td>
    <td height="23">&nbsp;
<%=Request.ServerVariables("SERVER_SOFTWARE")%></td></tr>
  <tr class="color2"><td height="23">&nbsp;服务器操作系统：</td>
    <td width="3" height="23" bgcolor="#FFFFFF"></td>
    <td height="23">&nbsp;
<%=Request.ServerVariables("OS")%></td></tr>
  <tr class="color"><td height="23">&nbsp;脚本超时时间：</td>
    <td width="3" height="23" bgcolor="#FFFFFF"></td>
    <td height="23">&nbsp;
<%=Server.ScriptTimeout%> 秒</td></tr>
  <tr class="color2"><td height="23">&nbsp;站点物理路径：</td>
    <td width="3" height="23" bgcolor="#FFFFFF"></td>
    <td height="23">&nbsp;
<%=request.ServerVariables("APPL_PHYSICAL_PATH")%></td></tr>
  <tr class="color"><td height="23">&nbsp;服务器CPU数量：</td>
    <td width="3" height="23" bgcolor="#FFFFFF"></td>
    <td height="23">&nbsp;
<%=Request.ServerVariables("NUMBER_OF_PROCESSORS")%> 个</td></tr>
  <tr class="color2"><td height="23">&nbsp;服务器解译引擎：</td>
    <td width="3" height="23" bgcolor="#FFFFFF"></td>
    <td height="23">&nbsp;
<%=ScriptEngine & "/"& ScriptEngineMajorVersion &"."&ScriptEngineMinorVersion&"."& ScriptEngineBuildVersion %></td></tr>
  <tr class="color">
    <td height="23">&nbsp;客户端浏览器版本：</td>
    <td width="3" height="23" bgcolor="#FFFFFF"></td>
    <td height="23">&nbsp;
<%
		    Dim Agent,Browser,version,tmpstr
		    Agent=Request.ServerVariables("HTTP_USER_AGENT")
		    Agent=Split(Agent,";")
		    If InStr(Agent(1),"MSIE")>0 Then
				Browser="MS Internet Explorer "
				version=Trim(Left(Replace(Agent(1),"MSIE",""),6))
			ElseIf InStr(Agent(4),"Netscape")>0 Then 
				Browser="Netscape "
				tmpstr=Split(Agent(4),"/")
				version=tmpstr(UBound(tmpstr))
			ElseIf InStr(Agent(4),"rv:")>0 Then
				Browser="Mozilla "
				tmpstr=Split(Agent(4),":")
				version=tmpstr(UBound(tmpstr))
				If InStr(version,")") > 0 Then 
					tmpstr=Split(version,")")
					version=tmpstr(0)
				End If
			End If
			response.Write(""&Browser&"  "&version&"")
		  %>
（需要IE6.0以上，推荐使用IE7.0以上）</td>
  </tr>
  <tr class="color2"><td height="23">&nbsp;数据库(ADO)支持：</td>
    <td width="3" height="23" bgcolor="#FFFFFF"></td>
    <td height="23">&nbsp;
<%On Error Resume Next
  Server.CreateObject("adodb.connection")
  if err=0 then 
   response.write("支持√")
  else
  response.write("不支持×")
  end if	 
  err=0%></td>
  </tr>
  <tr class="color"><td height="23">&nbsp;FSO文本读写：</td>
    <td width="3" height="23" bgcolor="#FFFFFF"></td>
    <td height="23">&nbsp;
  <%               
   On Error Resume Next
  Server.CreateObject(ESCMS_FSO)
  if err=0 then 
   response.write("支持√")
  else
  response.write("不支持×")
  end if	 
  err=0%></td></tr>
  <tr class="color2"><td height="23">&nbsp;Stream文件流：</td>
    <td width="3" height="23" bgcolor="#FFFFFF"></td>
    <td height="23">&nbsp;
<%Server.CreateObject("Adodb.Stream")
					if err=0 then 
					  response.write("支持√")
					else
					  response.write("不支持×")
					end if	 
					err=0%></td></tr>
  </table>

</div>
<!--End of preamble-->
<span class="m_bottom">Copyright@青春染指流年 QQ:746529918</span>
</div>
<!--End of maintxt-->
</body>
</html>
