<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!--#include file="../Inc/config.asp"-->
<!--#include file="../Inc/function.asp"-->
<!--#include file="../fckeditor/fckeditor.asp"-->
<%
checkLogin("AdminLogin.asp")
dim AID,tit,content,pic,sql,acturl
AID=safeRequest(trim(request.QueryString("ActID")))
if AID<=0 then
  response.Write("<script>alert('参数错误');window.location.href='default.asp'</script>")
  response.End()   
end if
sql="select * from [qy_info] where q_id="&AID
acturl="qyinfo.asp?act=up&ActID="&AID
DBopen("../QY_DB/#qyz#.mdb")
 if request.QueryString("act")="" then
       rs.open sql,conn,1,1
       tit=rs("q_title")
       content=rs("q_content")
       pic=rs("q_pic")
    else
	 if request.QueryString("act")="up" then
       tit=trim(request.Form("tit"))
       pic=trim(request.Form("ArtPic"))
       content=trim(request.Form("content"))
	   if tit<>"" and content<>"" then
         rs.open "select * from qy_info where q_id="&AID,conn,1,3
         rs("q_title")=tit
         rs("q_pic")=pic
         rs("q_content")=content
         rs.update
         rs.close
		 checkErr "更改信息","qyinfo.asp?ActID="&AID
		else
		alertInfo("标题或内容不能为空")
	   end if
	 end if
 end if

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

<body><form id="form1" name="form1" method="post" action="<%=acturl%>">
<div id="maintxt">
<span class="m_top"><%=tit%></span>
<div id="preamble">
  <table width="100%" height="534" border="0" cellpadding="0" cellspacing="0">
    <tr>
      <td height="15" colspan="3">&nbsp;</td>
      </tr>
    <tr class="color">
      <td width="140" height="25" class="ttable">标题：</td>
      <td width="4" height="25" bgcolor="#FFFFFF">&nbsp;</td>
      <td width="512" height="30">
        <input name="tit" type="text" id="tit" size="40" value="<%=tit%>" readonly="readonly" />
      
      </td>
    </tr>
    <tr>
      <td height="25" class="ttable">图片：</td>
      <td width="4" height="25" bgcolor="#FFFFFF">&nbsp;</td>
      <td height="30"><input name="ArtPic" type="text" id="ArtPic" size="40" value="<%=pic%>" />
      <a href="javascript:void(0);"  name="pic" class="thickboxs" rel="#hiddenModalContent" style="text-decoration:none;">上传图片</a></td>
    </tr>
    <tr class="color">
      <td height="400" class="ttable">内容：</td>
      <td height="30" bgcolor="#FFFFFF">&nbsp;</td>
      <td height="30">    
	   <% 
         Dim oFCKeditor
         Set oFCKeditor = New FCKeditor
         oFCKeditor.BasePath = "../FCKeditor/"  ' 设置编辑器的路径，我站点根目录下的一个目录
         oFCKeditor.ToolbarSet = "Default"  ' 工具条名称
         oFCKeditor.Width = "100%"   ' 编辑器宽度
         oFCKeditor.Height = "430"  '  编辑器高
		 oFCKeditor.Value  =content  ' 这个是给编辑器初始值
         oFCKeditor.Create "content" ' 以后编辑器里的内容都是由这个content取得，命名由你定。相当于表单文本框的名称。
		 %></td>
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
<div id="hiddenModalContent" style="display:none;">
	<h1>上传文件:</h1>
    <hr />
    <form id="frmUpload" target="UploadWindow" enctype="multipart/form-data" action="" method="post">
    <p><input type="file" name="NewFile" id="files" ><br /></p>
    <p>
    <button type="button" value="" onClick="SendFile();"><span><span>上 传</span></span><div></div></button>
    <button type="button" value="" class="close"><span><span>取 消</span></span><div></div></button>
    </p>
    </form>
</div>
<iframe name="UploadWindow" width="0" style="display:none;" ></iframe>
<iframe frameborder="0" name="act" style="display:none;"></iframe>
<%DBclose()%></body>
</html>
