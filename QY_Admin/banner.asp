<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!--#include file="../Inc/config.asp"-->
<!--#include file="../Inc/function.asp"-->
<!--#include file="../fckeditor/fckeditor.asp"-->
<%
checkLogin("AdminLogin.asp")
dim title,buttonTxt,formAction,bnid
nameArray=Array("b_id","b_title","ArtPic","b_url")
if request.QueryString("act")<>"Edit" then
title="添加广告"
buttonTxt="添加"
formAction="banner.asp?act=add"
else
title="编辑广告"
buttonTxt="更改"
formAction="banner.asp?act=up&bnid="&request.QueryString("bnid")
end if
'取值
if request.QueryString("act")<>"" and request.QueryString("act")<>"Edit" then
for h=1 to Ubound(nameArray)
valueArray(h)=request.Form(nameArray(h))
next
'取值条件
if valueArray(2)="" then alertInfo("请上传广告图片") end if
if valueArray(1)="" or valueArray(3)="" then alertInfo("输入内容不能为空") end if
end if
DBopen("../QY_DB/#qyz#.mdb")
select case request.QueryString("act")
   case "add"
   addRecord "select * from [qy_banner]",nameArray,valueArray,Ubound(nameArray)
   checkErr "添加广告","bannerlist.asp"
   case "Edit"
   bnid=safeRequest(trim(request.QueryString("bnid")))   
   editShow "select * from [qy_banner] where b_id="&bnid,nameArray,valueArray,Ubound(nameArray)
   case "up"
   bnid=safeRequest(trim(request.QueryString("bnid")))
   deleteFile "select * from [qy_banner] where b_id="&bnid,"ArtPic",valueArray(2)'如果更换图片则删除原先的图片
   updateRecord "select * from [qy_banner] where b_id="&bnid,nameArray,valueArray,Ubound(nameArray)
   checkErr "更改广告","bannerlist.asp"
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
<span class="m_top"><%=title%></span>
<div id="preamble">
  <table width="100%" height="105" border="0" cellpadding="0" cellspacing="0">
    <tr>
      <td height="15" colspan="3">&nbsp;</td>
      </tr>
    <tr class="color">
      <td width="140" height="25" class="ttable">广告标题：</td>
      <td width="4" height="25" bgcolor="#FFFFFF">&nbsp;</td>
      <td width="512" height="30">
        <input name="b_title" type="text" id="b_title" size="40" value="<%=valueArray(1)%>" />      </td>
    </tr>
    <tr>
      <td height="25" class="ttable">广告图片：</td>
      <td width="4" height="25" bgcolor="#FFFFFF">&nbsp;</td>
      <td height="30"><input name="ArtPic" type="text" class="txt"  id="pic" size="40" value="<%=valueArray(2)%>" />
        <a href="javascript:void(0);"  name="pic" class="thickboxs" id="pic" style="text-decoration:none;" rel="#hiddenModalContent">上传图片</a></td>
    </tr>
    <tr class="color">
      <td height="25" class="ttable">广告网址：</td>
      <td height="25" bgcolor="#FFFFFF">&nbsp;</td>
      <td height="30"><input name="b_url" type="text" id="b_url" size="40" value="<%=valueArray(3)%>" /></td>
    </tr>
  </table>
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
<%Dbclose()%></body>
</html>
