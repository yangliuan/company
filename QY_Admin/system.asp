<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!--#include file="../Inc/config.asp"-->
<!--#include file="../Inc/function.asp"-->
<%
checkLogin("AdminLogin.asp")
 DBopen("../QY_DB/#qyz#.mdb")
dim web_name,web_host,keyword,descriptions,slogan,web_beian,web_copyright,web_email,web_tel
 if request.QueryString("act")="up" then
 web_name=safeInstr(trim(request.Form("web_name")))
 web_host=safeInstr(trim(request.Form("web_host")))
 keyword=safeInstr(trim(request.Form("keyword")))
 descriptions=safeInstr(trim(request.Form("description")))
 slogan=safeInstr(trim(request.Form("slogan")))
 web_beian=safeInstr(trim(request.Form("web_beian")))
 web_copyright=safeInstr(trim(request.Form("copyright")))
 web_email=safeInstr(trim(request.Form("email")))
 web_tel=safeInstr(trim(request.Form("tel")))
    if web_name<>"" and keyword<>""  and web_beian<>"" and web_copyright<>"" then
       rs.open "select * from [system] where s_id=1",conn,1,3
       rs("s_web_name")=web_name
       rs("s_web_host")=web_host
       rs("s_keyword")=keyword
       rs("s_description")=descriptions
	   rs("s_company_slogan")=slogan
       rs("s_web_beian")=web_beian
       rs("s_web_copyright")=web_copyright
	   rs("s_web_email")=web_email
	   rs("s_web_tel")=web_tel
       rs.update
       checkErr "更改设置","system.asp"  
       rs.close
	 else
       alertInfo("内容不能为空")
     end if
 end if
 
  rs.open "select * from [system] where s_id=1",conn,1,1
      web_name=rs("s_web_name")
      web_host=rs("s_web_host")
      keyword=rs("s_keyword")
      descriptions=rs("s_description")
	  slogan=rs("s_company_slogan")
      web_beian=rs("s_web_beian")
      web_copyright=rs("s_web_copyright")
	  web_email=rs("s_web_email")
	  web_tel=rs("s_web_tel")
  rs.close
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>系统设置</title>
<style type="text/css">
<!--
@import url("style/css/style.css");
-->
</style>
</head>
<body>

<form id="form1" name="form1" method="post" action="?act=up">
<div id="maintxt">
<span class="m_top">系统设置</span>
<div id="preamble">
 
    <table width='100%' height="255" border="0" cellpadding="1" cellspacing="0" bordercolorlight="#c0c0c0" bordercolordark="#FFFFFF">
      <tr>
        <td height="15" colspan="3" align="center" bgcolor="#ffffff" class="red_3">&nbsp;</td>
      </tr>
      <tr class="color">
        <td width="164" height="23">&nbsp;网站名称：</td>
        <td width="3" bgcolor="#FFFFFF"></td>
        <td width="483" height="30"><input name="web_name" type="text" id="web_name" size="40" value="<%=web_name%>" /></td>
      </tr>
      <tr class="color2">
        <td height="23">&nbsp;网站域名：</td>
        <td width="3" height="23" bgcolor="#FFFFFF"></td>
        <td height="30"><input name="web_host" type="text" id="web_host" size="40" value="<%=web_host%>" /></td>
      </tr>
      <tr class="color">
        <td height="23">&nbsp;关键词：</td>
        <td width="3" height="23" bgcolor="#FFFFFF"></td>
        <td height="30"><input name="keyword" type="text" id="keyword" size="40" value="<%=keyword%>" />        
          //有助于被搜索引擎收录，提高排名</td>
      </tr>
      <tr class="color2">
        <td height="23">&nbsp;网站描述：</td>
        <td width="3" height="23" bgcolor="#FFFFFF"></td>
        <td height="30"><input name="description" type="text" id="descriptions" size="40" value="<%=descriptions%>" />
//有助于被搜索引擎收录，提高排名</td>
      </tr>
      <tr class="color">
        <td height="23">&nbsp;网站（企业）标语：</td>
        <td width="3" height="23" bgcolor="#FFFFFF"></td>
        <td height="30"><input name="slogan" type="text" id="descriptions" size="40" value="<%=slogan%>" /></td>
      </tr>
      <tr>
        <td height="23">&nbsp;网站备案号：</td>
        <td width="3" height="23" bgcolor="#FFFFFF"></td>
        <td height="30"><input name="web_beian" type="text" id="web_beian" size="40" value="<%=web_beian%>" /></td>
      </tr>
      <tr class="color">
        <td height="23">&nbsp;版权信息：</td>
        <td width="3" height="23" bgcolor="#FFFFFF"></td>
        <td height="30"><input name="copyright" type="text" id="copyright" size="40" value="<%=web_copyright%>" /></td>
      </tr>
      <tr>
        <td height="23">&nbsp;Emali:</td>
        <td height="23" bgcolor="#FFFFFF"></td>
        <td height="30"><input name="email" type="text" id="email" size="40" value="<%=web_email%>" /></td>
      </tr>
      <tr class="color">
        <td height="23">&nbsp;telephone:(联系电话)</td>
        <td height="23" bgcolor="#FFFFFF"></td>
        <td height="30"><input name="tel" type="text" id="tel" size="40" value="<%=web_tel%>" /></td>
      </tr>
    </table>
    
  </div>

  <!--End of preamble-->
  <span class="m_bottom">
  <input name="button" type="submit" class="Aniu" id="button" value="更改" />
  <input name="button2" type="reset" class="Aniu" id="button2" value="重置" />
  </span></div>
<!--End of maintxt-->
</form>
<%
DBclose()
%>
</body>
</html>