<%
'=========================================================================================================================================================
'=========================================================================================================================================================
'前台自定义函数,擅自更改会影响页面显示
'=========================================================================================================================================================
'=========================================================================================================================================================




'========================================================================================
'显示系统信息
'========================================================================================
dim keywords,web_title,descriptions,slogan,copyright,web_email,web_tel
function showSystem()'
DBopen("QY_DB/#qyz#.mdb")
rs.open "select * from system where s_id=1",conn,1,1
keywords=rs("s_keyword")
descriptions=rs("s_description")
slogan=rs("s_company_slogan")
web_title=rs("s_web_name")
copyright=rs("s_web_copyright")
web_email=rs("s_web_email")
web_tel=rs("s_web_tel")
Dbclose()
end function




'========================================================================================
'banner显示函数
'========================================================================================
function bannerShow()
dim pi,style
DBopen("QY_DB/#qyz#.mdb")
rs.open "select top 5 * from qy_banner where b_show=true",conn,1,1
if rs.bof and rs.eof then
response.Write("<img src='image/no_banner.jpg' width='211' height='146'/>")
end if
pi=1
while not rs.eof
if pi=1 then
style=""
else
style="display:none;"
end if
response.Write("<a href='"&rs("b_url")&"' target='_blank'/><img class=pic id=oDIV"&pi&" src='"&rs("ArtPic")&"' width='211' height='146' style='"&style&"' /></a>")
pi=pi+1
rs.movenext
wend 
DBclose()
end function




'========================================================================================
'左边栏显示合作伙伴
'========================================================================================
function partnersShow()
DBopen("QY_DB/#qyz#.mdb")
rs.open "select * from qy_partners",conn,1,1
if rs.bof and rs.eof then
response.Write("<a href='#'>没有记录</a>")
end if 
while not rs.eof 
response.Write("<a href='"&rs("p_url")&"'  target='_blank'/>"&rs("p_name")&"</a>")
rs.movenext
wend
DBclose()
end function







'========================================================================================
'首页产品展示
'========================================================================================
function ProductsShow()
  DBopen("QY_DB/#qyz#.mdb")
  rs.open "select top 6 * from qy_pro order by p_time desc",conn,1,1
  if rs.bof and rs.eof then
  response.Write("<li><img alt='数据库中没有添加产品数据' src='image/no_products.jpg' width='652' height='137'></li>")
  end if
  while not rs.eof
  response.Write("<li><a href='#'><img src='"&rs("ArtPic")&"' alt='"&rs("p_content")&"' width='652' height='137' /></a></li>")
  rs.movenext
  wend
  DBclose()
end function 
'========================================================================================
'首页新闻分类（tab选项卡）
'========================================================================================
function Inews_class()
     dim i
	 DBopen("QY_DB/#qyz#.mdb")
	 rs.open "select top 2 * from qy_class where c_type=1",conn,1,1
	 if rs.eof and rs.bof then
	 response.Write("<li class='TabbedPanelsTab' tabindex='0'>无新闻分类，请到后台添加</li>")
	 end if
	 i=0
	 while not rs.eof 
	 response.Write("<li class='TabbedPanelsTab' tabindex='0' onmouseover='TabbedPanels1.showPanel("&i&")'>"&rs("c_name")&"</li>")
	 rs.movenext
	 i=i+1
	 wend 
	 DBclose()
end function



'========================================================================================
'首页新闻列表（对应选项卡的新闻分类）
'========================================================================================
function Inews_list()
	 DBopen("QY_DB/#qyz#.mdb")
	 dim eRs
	 rs.open "select top 2 * from qy_class where c_type=1",conn,1,1
	 if rs.eof and rs.bof then
	 response.Write("<div class='TabbedPanelsContent'><div/>")
	 end if
	 do while not rs.eof
	 set eRs=server.CreateObject("Adodb.recordset")
	 eRs.open"select top 5 * from qy_news where n_cid="&rs("c_id"),conn,1,1
	 response.Write("<div class='TabbedPanelsContent'><ol>")
	 if eRs.bof and eRs.eof then
	 response.Write("<dl><strong>|NEWS|</strong>没有添加新闻</dl>")
	 end if
	 while not eRs.eof
	 response.Write("<dl><strong>|NEWS|</strong><a href='NewsRead.asp?act=read&n_id="&eRs("n_id")&"' target='_blank'/>"&getSubString(eRs("n_title"),12)&"</a></dl>")
     eRs.movenext
	 wend
	 response.Write(" </ol></div>")
     eRs.close
	 set eRs=nothing
	 rs.movenext
	 loop
	 DBclose()
end function

'========================================================================================
'about页面显示信息
'========================================================================================
sub showAbout_info()
DBopen("QY_DB/#qyz#.mdb")
rs.open sql,conn,1,1
if rs.bof and rs.eof then
response.Write("没有添加记录")
else
if act<>"hzhb" then
response.Write(rs("q_content"))
else
response.Write("<ul>")
picNo=0
while not rs.eof 
response.Write("<li><a href='"&rs("p_url")&"' target='_blank'><img  src='"&rs("ArtPic")&"' width='200' height='100' alt='"&rs("p_name")&"' /></a></li>")
rs.movenext
wend
end if
end if
DBclose()
response.Write("</ul>")
end sub



'========================================================================================
'留言提交
'========================================================================================
sub SendMessage()
if request.QueryString("send")="message" then
if request.Form("message")="" then
alertInfo "请填写留言内容"
else
content=trim(request.Form("message"))
content = replace(content,"script","_script_")
content = replace(content,"iframe","_iframe_")
DBopen("QY_DB/#qyz#.mdb")
rs.open "select * from qy_msg",conn,1,3
rs.addnew
rs("m_content")=content
rs("m_ip")=UserIp()
rs.update
DBclose()
checkErr "留言提交","Service.asp"
end if
end if
end sub

'========================================================================================
'Service页信息显示
'========================================================================================
sub ShowService_Info()
DBopen("QY_DB/#qyz#.mdb")
rs.open sql,conn,1,1
if act<>"message" then
response.Write(rs("q_content"))
end if
if act="message" then
response.Write("<table width='617' border='0' align='center' cellpadding='0' cellspacing='0'><tr><td colspan='2'>")
response.Write("<form id='form1' name='form1' method='post' action='Service.asp?send=message'>")
response.Write("<textarea name='message' cols='70' rows='8' class='message' id='message'></textarea>")
response.Write("<br /><input name='button' type='submit' class='send' id='button' value='发表留言' /></form></td></tr>")
if rs.eof and rs.bof then
response.Write("<tr height='auto'><td colspan='2'>暂时没有留言</td></tr>")
end if
while not rs.eof 
m_time=FormatTime(rs("m_time"),"yyyy-mm-dd hh:nn")
response.Write("<tr bgcolor='#E4E4E4'>")
response.Write("<td width='152' height='25'>来自"&rs("m_ip")&"的网友</td>")
response.Write("<td width='475' height='25'>at "&m_time&" 发表</td></tr>")
response.Write("<tr><td colspan='2' class='tdfont'><div align='left'>"&rs("m_content")&"</div></td></tr>")
rs.movenext
wend
response.Write("</table>")
end if
DBclose()
end sub  




'========================================================================================
'Human页信息显示
'========================================================================================
sub ShowHuman_info()
DBopen("QY_DB/#qyz#.mdb")
rs.open sql,conn,1,1
if rs.bof and rs.eof then
response.Write("没有添加记录")
response.End()
end if
if act<>"zpxx" then
response.Write(rs("q_content"))
else
response.Write("<table width='100%' border='0' cellspacing='2' cellpadding='0'>")
response.Write("<tr height='20' bgcolor='#EEEEEE'>")
response.Write("<td>招聘职位</td>")
response.Write("<td>招聘人数</td>")
response.Write("<td>工作地点</td>")
response.Write("<td>月薪</td>")
response.Write("<td>发布时间</td>")
response.Write("<td>任职资格</td></tr>")
c1="#FFFFFF"
c2="#EEEEEE"
while not rs.eof 
response.Write("<tr height='20' bgcolor='")
call changeCl(c1,c2)
response.Write("' onmouseover='")
response.Write("this.style.backgroundColor=""#bfbdbd""'")
response.Write("onmouseout='this.style.backgroundColor=""""'>")
response.Write("<td>"&rs("j_zw")&"</td>")
response.Write("<td>"&rs("j_number")&"</td>")
response.Write("<td>"&rs("j_location")&"</td>")
response.Write("<td>"&rs("j_daiyu")&"</td>")
response.Write("<td>"&FormatTime(rs("j_time"),"yyyy-mm-dd")&"</td>")
response.Write("<td><a href='Human_info.asp?act=show&jid="&rs("j_id")&"' target='_blank'>查看</a></td></tr>")
rs.movenext
wend
end if
DBclose()
end sub




'========================================================================================
'新闻阅读
'========================================================================================
sub NewsRead()
DBopen("QY_DB/#qyz#.mdb")
rs.open "select * from qy_news where n_id="&nid,conn,1,1
n_title=rs("n_title")
n_content=rs("n_content")
n_author=rs("n_author")
n_time=rs("n_time")
rs.close
DBclose()
end sub


'========================================================================================
'产品显示列表
'========================================================================================
sub showPro()
DBopen("QY_DB/#qyz#.mdb")
page 6,sql
if rs.eof and rs.bof then
response.Write("没有记录")
end if
for i=1 to rs.pagesize
if rs.eof then 
exit for
end if
response.Write("<li><a href='"&rs("ArtPic")&"' title='"&rs("p_content")&"' rel='lightbox'><img src='"&rs("ArtPic")&"' width='200' height='100' alt='example4'/></a></li>")
rs.movenext
next
end sub


'========================================================================================
'新闻中心列列表
'========================================================================================
sub showNewsList()
DBopen("QY_DB/#qyz#.mdb")
page 3,sql
if rs.eof and rs.bof then
response.Write("没有记录")
end if
for i=1 to rs.pagesize
if rs.eof then 
exit for
end if
response.Write("<table width='627' border='0' cellpadding='0' cellspacing='0' class='news'>")
response.Write("<tr class='titleColor'>")
response.Write("<td height='25'><div align='left'><img src='image/n_arrow.gif' width='14' height='20' align='absmiddle'/>")
response.Write(FormatTime(rs("n_time"),"yyyy-mm_dd hh:nn"))
response.Write("　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　<a href='NewsRead.asp?act=read&n_id="&rs("n_id")&"' target='_blank'>详细内容</a></div></td></tr>")
response.Write("<tr class='titleColor'>")
response.Write("<td height='25'><div align='left'>"&rs("n_title")&"</div></td>")
response.Write("</tr>")
response.Write("<tr>")
response.Write("<td height='25'><div align='left'>"&getSubString(rs("n_content"),24)&"</div></td>")
response.Write("</tr></table>")
rs.movenext
next
end sub
%>

