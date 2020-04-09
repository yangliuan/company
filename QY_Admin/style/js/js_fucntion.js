// JavaScript Document
//-------------------------------------------------------
//表单根据参数跳转到不同的url
//act:url地址
//-------------------------------------------------------
function changeAction(act)
{
  document.form1.action=act;
  document.form1.submit();
}
//-------------------------------------------------------
//复选框全选及取消
//sonName:要更改的复选框组的name
//cbAllId作为按钮使用的复选框的name
//-------------------------------------------------------
function ChkAllClick(sonName, cbAllId){
 var arrSon = document.getElementsByName(sonName);//复选框组
 var cbAll = document.getElementsByName(cbAllId);//作为按钮使用的复选框
 var tempState=cbAll.checked;//获取作为按钮的复选框的checked属性
 for(i=0;i<arrSon.length;i++) {
  if(arrSon[i].checked!=tempState)//如果按钮复选框与复选框组的checked属性不相同
           arrSon[i].click();//改变复选框组的checked属性
 }
}
