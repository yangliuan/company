<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!--#include file="../Inc/config.asp"-->
<!--#include file="../Inc/function.asp"-->
<!--#include file="../fckeditor/fckeditor.asp"-->
<%
checkLogin("AdminLogin.asp")
dim title,buttonTxt,formAction,nid
nameArray=Array("n_id","n_cid","n_title","n_src","n_author","n_keyword","ArtPic","n_top","n_content")
if request.QueryString("act")<>"Edit" then
title="添加新闻"
buttonTxt="添加"
formAction="news.asp?act=add"
else
title="修改新闻"
buttonTxt="更改"
formAction="news.asp?act=up&nid="&request.QueryString("nid")
end if
if request.QueryString("act")<>"" and request.QueryString("act")<>"Edit" then
for h=1 to Ubound(nameArray)
valueArray(h)=request.Form(nameArray(h))
next
if valueArray(7)="y" then valueArray(7)=true else valueArray(7)=false  end if
if valueArray(1)="0" then alertInfo("请选择新闻分类") end if
if valueArray(2)="" or valueArray(3)="" or valueArray(4)="" or  valueArray(8)="" then alertInfo("输入内容不能为空") end if
end if
DBopen("../QY_DB/#qyz#.mdb")
select case request.QueryString("act")
   case "add"
   addRecord "select * from [qy_news]",nameArray,valueArray,Ubound(nameArray)
   checkErr "添加新闻","newslist.asp"
   case "Edit"
   nid=safeRequest(trim(request.QueryString("nid")))   
   editShow "select * from [qy_news] where n_id="&nid,nameArray,valueArray,Ubound(nameArray)
   case "up"
   nid=safeRequest(trim(request.QueryString("nid")))
   deleteFile "select * from [qy_news] where n_id="&nid,"ArtPic",valueArray(6)'如果更换图片则删除原先的图片
   updateRecord "select * from [qy_news] where n_id="&nid,nameArray,valueArray,Ubound(nameArray)
   checkErr "更改新闻","newslist.asp"
end select
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

<body><form id="form1" name="form1" method="post" action="<%=formAction%>">
<div id="maintxt">
<span class="m_top"><%=title%>
<select name="n_cid" class="select" id="n_cid">
  <option value="0">请选择新闻分类</option>
  <%
  rs.open "select * from [qy_class] where c_type=1",conn,1,1
  while not rs.eof 
  %>
  <option value="<%=rs("c_id")%>" <%if valueArray(1)=rs("c_id") then response.Write("selected") end if%>><%=rs("c_name")%></option>
  <%
  rs.movenext
  wend
  rs.close
  %>
</select>
</span>
<div id="addContent">
  <table width="99%" height="534" border="0" cellpadding="0" cellspacing="0">
    <tr>
      <td height="15" colspan="3">&nbsp;</td>
    </tr>
    <tr class="color">
      <td width="140" height="25" class="ttable">新闻标题：</td>
      <td width="4" height="25" bgcolor="#FFFFFF">&nbsp;</td>
      <td width="512" height="30"><input name="n_title" type="text" id="n_title" size="40" value="<%=valueArray(2)%>" />
      </td>
    </tr>
    <tr>
      <td width="140" height="25" class="ttable">新闻来源：</td>
      <td width="4" height="25" bgcolor="#FFFFFF">&nbsp;</td>
      <td width="512" height="30"><input name="n_src" type="text" id="n_src" size="40" value="<%=valueArray(3)%>"/>
      </td>
    </tr>
    <tr class="color">
      <td width="140" height="25" class="ttable">新闻作者：</td>
      <td width="4" height="25" bgcolor="#FFFFFF">&nbsp;</td>
      <td width="512" height="30"><input name="n_author" type="text" id="n_author" size="40" value="<%=valueArray(4)%>" />
      </td>
    </tr>
    <tr>
      <td width="140" height="25" class="ttable">新闻关键词：</td>
      <td width="4" height="25" bgcolor="#FFFFFF">&nbsp;</td>
      <td width="512" height="30"><input name="n_keyword" type="text" id="n_keyword" size="40" value="<%=valueArray(5)%>"/>
      </td>
    </tr>
    <tr class="color">
      <td height="25" class="ttable">新闻图片：</td>
      <td width="4" height="25" bgcolor="#FFFFFF">&nbsp;</td>
      <td height="30"><input name="ArtPic" type="text" class="txt"  id="pic" size="40" value="<%=valueArray(6)%>" />
        <a href="javascript:void(0);"  name="pic" class="thickboxs" id="pic" style="text-decoration:none;" rel="#hiddenModalContent">上传图片</a></td>
    </tr>
    <tr>
      <td width="140" height="25" class="ttable">新闻选项：</td>
      <td width="4" height="25" bgcolor="#FFFFFF">&nbsp;</td>
      <td width="512" height="30"><input type="checkbox" name="n_top" id="n_top" value="y" <%if valueArray(7)=true then response.Write("checked")%> />
        置顶</td>
    </tr>
    <tr class="color">
      <td height="400" class="ttable">新闻内容：</td>
      <td height="30" bgcolor="#FFFFFF">&nbsp;</td>
      <td height="30"><% 
         Dim oFCKeditor
         Set oFCKeditor = New FCKeditor
         oFCKeditor.BasePath = "../FCKeditor/"  ' 设置编辑器的路径，我站点根目录下的一个目录
         oFCKeditor.ToolbarSet = "Default"  ' 工具条名称
         oFCKeditor.Width = "100%"   ' 编辑器宽度
         oFCKeditor.Height = "400"  '  编辑器高
		 oFCKeditor.Value  =valueArray(8) ' 这个是给编辑器初始值
         oFCKeditor.Create "n_content" ' 以后编辑器里的内容都是由这个content取得，命名由你定。相当于表单文本框的名称。
		 %></td>
    </tr>
  </table>
  <p>&nbsp;</p>
</div>
<!--End of preamble-->
<span class="m_bottom">
<input name="button" type="submit" class="Aniu" id="button" value="<%=buttonTxt%>" />
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
