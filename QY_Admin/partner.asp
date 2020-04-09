<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!--#include file="../Inc/config.asp"-->
<!--#include file="../Inc/function.asp"-->
<!--#include file="../fckeditor/fckeditor.asp"-->
<%
checkLogin("AdminLogin.asp")
dim title,buttonTxt,formAction,pnid
nameArray=Array("p_id","p_name","ArtPic","p_url")
if request.QueryString("act")<>"Edit" then
title="添加合作伙伴"
buttonTxt="添加"
formAction="partner.asp?act=add"
else
title="编辑合作伙伴"
buttonTxt="更改"
formAction="partner.asp?act=up&pnid="&request.QueryString("pnid")
end if
'取值
if request.QueryString("act")<>"" and request.QueryString("act")<>"Edit" then
for h=1 to Ubound(nameArray)
valueArray(h)=request.Form(nameArray(h))
next
'取值条件
if valueArray(2)="" then alertInfo("请上传产品图片") end if
if valueArray(1)="" or valueArray(3)="" then alertInfo("输入内容不能为空") end if
end if
DBopen("../QY_DB/#qyz#.mdb")
select case request.QueryString("act")
   case "add"
   addRecord "select * from [qy_partners]",nameArray,valueArray,Ubound(nameArray)
   checkErr "添加合作伙伴","partnerlist.asp"
   case "Edit"
   pnid=safeRequest(trim(request.QueryString("pnid")))   
   editShow "select * from [qy_partners] where p_id="&pnid,nameArray,valueArray,Ubound(nameArray)
   case "up"
   pnid=safeRequest(trim(request.QueryString("pnid")))
   deleteFile "select * from [qy_partners] where p_id="&pnid,"ArtPic",valueArray(2)'如果更换图片则删除原先的图片
   updateRecord "select * from [qy_partners] where p_id="&pnid,nameArray,valueArray,Ubound(nameArray)
   checkErr "更改合作伙伴","partnerlist.asp"
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
      <td width="140" height="25" class="ttable">合作企业名称：</td>
      <td width="4" height="25" bgcolor="#FFFFFF">&nbsp;</td>
      <td width="512" height="30">
        <input name="p_name" type="text" id="p_name" size="40" value="<%=valueArray(1)%>" />      </td>
    </tr>
    <tr>
      <td height="25" class="ttable">标志图片：</td>
      <td width="4" height="25" bgcolor="#FFFFFF">&nbsp;</td>
      <td height="30"><input name="ArtPic" type="text" class="txt"  id="pic" size="40" value="<%=valueArray(2)%>" />
        <a href="javascript:void(0);"  name="pic" class="thickboxs" id="pic" style="text-decoration:none;" rel="#hiddenModalContent">上传图片</a></td>
    </tr>
    <tr class="color">
      <td height="25" class="ttable">合作企业网址：</td>
      <td height="25" bgcolor="#FFFFFF">&nbsp;</td>
      <td height="30"><input name="p_url" type="text" id="p_url" size="40" value="<%=valueArray(3)%>" /></td>
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
