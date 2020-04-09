<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!--#include file="../Inc/config.asp"-->
<!--#include file="../Inc/function.asp"-->
<%checkLogin("AdminLogin.asp")%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>企业后台管理系统</title>
<style type="text/css">
<!--
@import url("style/css/style.css");
-->
</style>
<script src="style/js/SpryCollapsiblePanel.js" type="text/javascript"></script>
<link href="style/css/SpryCollapsiblePanel.css" rel="stylesheet" type="text/css" />
</head>

<body id="df">
<div id="layout">
<div id="left">
<span class="l_top"></span>
<div id="info">
<ol>
<dt>管理员信息</dt>
<dl>
  &nbsp;&nbsp;&nbsp;&nbsp;User_ID:<%=session("adminName")%>
</dl>
<dl>
  &nbsp;&nbsp;&nbsp;&nbsp;
</dl>
</ol>
</div>
<!--End of info-->
<div id="menu"> 
<span class="tit">管理面板</span>
<div id="mb">
  <div id="CollapsiblePanel1" class="CollapsiblePanel">
    <div class="CollapsiblePanelTab" tabindex="0">系统管理</div>
    <div class="CollapsiblePanelContent">
      <div class="nav"> <a href="sysinfo.asp" target="rightiframe">系统信息</a> <a href="system.asp" target="rightiframe">系统设置</a> <a href="adminuser.asp" target="rightiframe">管理员用户设置</a> </div>
    </div>
  </div>
  <div id="CollapsiblePanel2" class="CollapsiblePanel">
    <div class="CollapsiblePanelTab" tabindex="0">企业信息</div>
    <div class="CollapsiblePanelContent">
      <div class="nav"> <a href="qyinfo.asp?ActID=1" target="rightiframe">企业简介</a><a href="qyinfo.asp?ActID=2" target="rightiframe">企业文化</a><a href="qyinfo.asp?ActID=3" target="rightiframe">荣誉资质</a><a href="qyinfo.asp?ActID=4" target="rightiframe">董事长致辞</a> <a href="qyinfo.asp?ActID=5" target="rightiframe">联系我们</a> <a href="messagelist.asp" target="rightiframe">留言管理</a></div>
    </div>
  </div>
  <div id="CollapsiblePanel3" class="CollapsiblePanel">
    <div class="CollapsiblePanelTab" tabindex="0">新闻管理</div>
    <div class="CollapsiblePanelContent">
      <div class="nav"> <a href="classAdd.asp?CID=1" target="rightiframe">新闻分类管理</a> <a href="newslist.asp" target="rightiframe">新闻列表</a> <a href="news.asp" target="rightiframe">添加新闻</a> </div>
    </div>
  </div>
  <div id="CollapsiblePanel4" class="CollapsiblePanel">
    <div class="CollapsiblePanelTab" tabindex="0">产品管理</div>
    <div class="CollapsiblePanelContent">
      <div class="nav"> <a href="classAdd.asp?CID=2" target="rightiframe">产品分类管理</a> <a href="prolist.asp" target="rightiframe">产品列表</a> <a href="product.asp" target="rightiframe">添加产品</a> </div>
    </div>
  </div>
  <div id="CollapsiblePanel7" class="CollapsiblePanel">
    <div class="CollapsiblePanelTab" tabindex="0">广告管理</div>
    <div class="CollapsiblePanelContent">
      <div class="nav"><a href="bannerlist.asp" target="rightiframe">广告列表</a> <a href="banner.asp" target="rightiframe">添加广告</a> </div>
    </div>
  </div>
  <div id="CollapsiblePanel5" class="CollapsiblePanel">
    <div class="CollapsiblePanelTab" tabindex="0">人力资源</div>
    <div class="CollapsiblePanelContent">
      <div class="nav"> <a href="qyinfo.asp?ActID=6" target="rightiframe">用人理念</a><a href="qyinfo.asp?ActID=7" target="rightiframe">福利待遇</a> <a href="joblist.asp" target="rightiframe">招聘信息列表</a> <a href="job.asp" target="rightiframe">添加招聘信息</a> </div>
    </div>
  </div>
  <div id="CollapsiblePanel6" class="CollapsiblePanel">
    <div class="CollapsiblePanelTab" tabindex="0">合作伙伴</div>
    <div class="CollapsiblePanelContent">
      <div class="nav"> <a href="partnerlist.asp" target="rightiframe">合作伙伴列表</a> <a href="partner.asp" target="rightiframe">添加合作伙伴</a> </div>
    </div>
  </div>
</div>
<!--End of mb-->
</div>
<!--End of menu-->
<span class="l_bottom"></span></div>
<!--End of left-->
<div id="right">
<span class="r_top"></span>
<div id="top">
<div id="bt"></div>
<div id="anniu"><a href="AdminLogin.asp?act=LoginOut" class="tc" onclick="javascript:return confirm('你确认要退出吗？')">安全退出</a><a href="../Index.asp" class="in" target="_blank">网站首页</a> </div>
<div id="clock">服务器时间：
  <SCRIPT language=javascript author=luxiaoqing><!--
function initArray(){for(i=0;i<initArray.arguments.length;i++)
this[i]=initArray.arguments[i];}var isnMonths=new initArray("1月","2月","3月","4月","5月","6月","7月","8月","9月","10月","11月","12月");var isnDays=new initArray("星期日","星期一","星期二","星期三","星期四","星期五","星期六","星期日");today=new Date();hrs=today.getHours();min=today.getMinutes();sec=today.getSeconds();clckh=""+((hrs>12)?hrs-12:hrs);
clckm=((min<10)?"0":"")+min;clcks=((sec<10)?"0":"")+sec;clck=(hrs>=12)?"下午":"上午";var stnr="";var ns="0123456789";var a="";
//-->
</SCRIPT>   
<SCRIPT language=javascript>
function getFullYear(d){
yr=d.getYear();if(yr<1000)
yr+=1900;return yr;}
document.write(""+getFullYear(today)+"年"+isnMonths[today.getMonth()]+""
+today.getDate()+"日"+isnDays[today.getDay()]+"；"+hrs+":"+clckm+":"+clcks+""); 
 </SCRIPT></div>
</div>
<!--End of top-->
<div id="main">
<iframe name="rightiframe" width="100%" height="600" src="main.asp" frameborder="0" scrolling="no"></iframe>
</div>
<!--End of main-->
<span class="r_bottom"></span></div>
<!--End of right-->
</div>

<script type="text/javascript">
<!--
var CollapsiblePanel1 = new Spry.Widget.CollapsiblePanel("CollapsiblePanel1", {contentIsOpen:false});
var CollapsiblePanel2 = new Spry.Widget.CollapsiblePanel("CollapsiblePanel2", {contentIsOpen:false});
var CollapsiblePanel3 = new Spry.Widget.CollapsiblePanel("CollapsiblePanel3", {contentIsOpen:false});
var CollapsiblePanel4 = new Spry.Widget.CollapsiblePanel("CollapsiblePanel4", {contentIsOpen:false});
var CollapsiblePanel5 = new Spry.Widget.CollapsiblePanel("CollapsiblePanel5", {contentIsOpen:false});
var CollapsiblePanel6 = new Spry.Widget.CollapsiblePanel("CollapsiblePanel6", {contentIsOpen:false});
var CollapsiblePanel7 = new Spry.Widget.CollapsiblePanel("CollapsiblePanel7", {contentIsOpen:false});
//-->
</script>
</body>
</html>
