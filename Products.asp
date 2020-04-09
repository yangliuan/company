<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!--#include file="Inc/config.asp"-->
<!--#include file="Inc/function.asp"-->
<!--#include file="Inc/topWeb.asp"-->
<%
showSystem()
dim stype,i,qid,n_title,sql
if request.QueryString("stype")="" then
stype=0
else
stype=safeRequest(int(trim(request.QueryString("stype"))))
end if
if stype=0 then
session("stype")=0
n_title="所有产品"
sql="select * from qy_pro order by p_time desc"
else
session("stype")=""
session("stype")=stype
sql="select * from qy_pro where p_cid="&stype&" order by p_time desc"
end if
DBopen("QY_DB/#qyz#.mdb")
rs.open "select * from qy_class where c_id="&session("stype"),conn,1,1
if not rs.eof and not rs.bof then
n_title=rs("c_name")
end if
rs.close
DBclose()
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="keywords" content="<%=keywords%>" />
<meta name="description" content="<%=descriptions%>" />
<title><%=web_title%></title>
<link href="css/css_list.css" rel="stylesheet" type="text/css" />
<script language="javascript" src="QY_Admin/style/js/public.js"></script>
<script src="QY_Admin/style/js/SpryCollapsiblePanel.js" type="text/javascript"></script>
<link rel="stylesheet" href="lightbox/css/lightbox.css" type="text/css" media="screen" />

<style>
.current {
	background-color: #3798DF;
	font-family: "微软雅黑";
	font-size: 14px;
	line-height: 20px;
	font-weight: bold;
	display: block;
	height: 20px;
	width: auto;
	padding-right: 8px;
	padding-left: 8px;
	text-align: center;
}
</style>
</head>

<body>
<div id="layout">
<div id="top">
<div id="logo"></div><!--end logo-->
<div id="top_menu">
<div id="top_menu_boder">
<a href="#"><span></span>English&nbsp;&nbsp;</a>
<a href="#"><span></span>加盟我们&nbsp;</a>
<a href="#"><span></span>其它子公司</a></div>
</div>
<!--end top_menu-->
<div id="top_nav">
 <a href="About_us.asp?act=qywh"><img src="image/tnav_1.png"  class="tnav_1" /></a>
 <a href="About_us.asp?act=ryzz"><img src="image/tnav_2.png"  class="tnav_2" /></a>
 <a href="Products.asp"><img src="image/tnav_3.png"  class="tnav_3" /></a>
 <a href="Human_resources.asp?act=zpxx"><img src="image/tnav_4.png"  class="tnav_4" /></a>
 <a href="Service.asp?act=contact"><img src="image/tnav_5.png"  class="tnav_5" /></a>
 <div id="baoyu"><%=getSubString(slogan,26)%></div>
 </div>
<!--end top_nav-->

<ul id="nav">
<li><a href="Index.asp">首页</a><span></span></li>
<li><a href="About_us.asp">关于我们</a>
<!--[if lte IE 6]><a href="#nogo"><table><tr><td><![endif]-->
<dl>
<dd><a href="About_us.asp?act=qyjj">企业简介</a></dd>
<dd><a href="About_us.asp?act=qywh">企业文化</a></dd>
<dd><a href="About_us.asp?act=ryzz">荣誉资质</a></dd>
<dd><a href="About_us.asp?act=dszzc">董事长致辞</a></dd>
<dd><a href="About_us.asp?act=hzhb">合作伙伴</a></dd>
</dl>	
<!--[if lte IE 6]></td></tr></table></a><![endif]-->
<span></span>
</li>
<li><a href="News.asp">新闻中心</a><span></span></li>
<li><a href="Products.asp">产品展示</a><span></span></li>
<li><a href="Human_resources.asp">人力资源</a>
<!--[if lte IE 6]><a href="#nogo"><table><tr><td><![endif]-->
<dl>
<dd><a href="Human_resources.asp?act=yrln">用人理念</a></dd>
<dd><a href="Human_resources.asp?act=fldy">福利待遇</a></dd>
<dd><a href="Human_resources.asp?act=zpxx">招聘信息</a></dd>
</dl>	
<!--[if lte IE 6]></td></tr></table></a><![endif]-->
<span></span>
</li>
<li><a href="Service.asp">客服中心</a>
<!--[if lte IE 6]><a href="#nogo"><table><tr><td><![endif]-->
<dl>
<dd><a href="Service.asp?act=message">给我们留言</a></dd>
<dd><a href="Service.asp?act=contact">联系我们</a></dd>
</dl>	
<!--[if lte IE 6]></td></tr></table></a><![endif]-->
</li>
</ul>
<!--end nav-->
</div>
<!--end top-->

<div id="bottom">

<div id="left">

<div id="banner">
<span class="b_top"></span><span class="b_left"></span><span class="b_right"></span><span class="b_bottom"></span><span class="b_tit"></span>

<script language="javascript">fnToggle();</script>
<div id=oTransContainer style="filter: progid:DXImageTransform.Microsoft.Wipe(GradientSize=1.0,wipeStyle=0, motion='forward'); width: 211px; height: 146px">
<%bannerShow()%>
</div>
<!--end oTransContainer-->
</div>
<!--end banner-->
<div id="fgx"></div>
<!--end fgx-->
<div id="hzhb">
  <div id="CollapsiblePanel1" class="CollapsiblePanel">
    <div class="CollapsiblePanelTab" tabindex="0">合作伙伴</div>
    <div class="CollapsiblePanelContent"><%partnersShow()%></div>
  </div>
</div>
<!--end hzhb-->

<span class="email"><%=getSubString(web_email,8)%></span>
<span class="tel"><%=getSubString(web_tel,8)%></span></div>
<!--end left-->
<div id="main">
<div id="two_class_top">
<h1>&nbsp;&nbsp;产品展示<span id="title">首页>产品展示><%=n_title%>
</span></h1>
<div class="class_nav">
&nbsp;按分类查看：<select name="select" class="select"  onchange="javascript:location='Products.asp?stype='+this.value">
  <option value="0" <%if session("stype")=0 then response.Write("selected") end if%>>所有产品</option>
  <%
  DBopen("QY_DB/#qyz#.mdb")
  rs.open "select * from [qy_class] where c_type=2",conn,1,1
  while not rs.eof
  %>
  <option value="<%=rs("c_id")%>" <%if session("stype")=rs("c_id") then response.Write("selected") end if %>><%=rs("c_name")%></option>
  <%
  rs.movenext
  wend
  DBclose()
  %>
  </select>
</div>
</div>
<!--end two_class_top-->
<div id="centent">
<script src="lightbox/js/prototype.js" type="text/javascript"></script>
<script src="lightbox/js/scriptaculous.js?load=effects" type="text/javascript"></script>
<script src="lightbox/js/lightbox.js" type="text/javascript"></script>
<%showPro()%>
<span id="fenye"><%call writePage(Url_address("page"))%></span></div>
<!--end centent-->
</div>
<!--end main-->
<div id="footer">
<ul>
<li class="footer_bd"><a href="About_us.asp">关于我们</a> | <a href="#">法律公告</a> | <a href="#">隐私保护</a> | <a href="#">网站地图</a> | <a href="Service.asp?act=contact">联系我们</a></li>
<li><%=copyright%></li>
</ul>

</div>
<!--end footer-->
</div>
<!--end bottom-->
</div>
<!--end layout-->
<script type="text/javascript">
<!--
var CollapsiblePanel1 = new Spry.Widget.CollapsiblePanel("CollapsiblePanel1", {contentIsOpen:false});
//-->
</script>
<%DBclose()%>
</body>
</html>
