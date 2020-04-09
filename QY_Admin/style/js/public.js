// JavaScript Document


//-------banner图片过滤效果----------------------------------------------------------------------------------------------------------------

var NowFrame = 1;var MaxFrame = 5;var bStart = 0;
 function fnToggle()
 { var next = NowFrame + 1;
 if(next == MaxFrame+1) 
 {NowFrame = MaxFrame;next = 1;}
 if(bStart == 0)
 {bStart = 1;setTimeout('fnToggle()', 2000);return;}
 else{oTransContainer.filters[0].Apply();document.images['oDIV'+next].style.display = "";document.images['oDIV'+NowFrame].style.display = "none";oTransContainer.filters[0].Play(duration=2);
 if(NowFrame == MaxFrame){NowFrame = 1;}
 else{NowFrame++;}}	
 setTimeout('fnToggle()', 6500);}
 //--------------------------------end banner图片过滤效果-----------------------------------------------------------------------------------------






//--------------------------------高亮显示导航-----------------------------------------------------------------------------------------
var  $c=function(array){var nArray = [];for (var i=0;i<array.length;i++) nArray.push(array[i]);return nArray;};
Array.prototype.each=function(func){
for(var i=0,l=this.length;i<l;i++) {func(this[i],i);};
};
document .getElementsByClassName=function(cn){
var hasClass=function(w,Name){
var hasClass = false;
w.className.split(' ').each(function(s){
if (s == Name) hasClass = true;
});
return hasClass;
}; 
var elems =document.getElementsByTagName("*")||document.all;
            var elemList = [];
           $c(elems).each(function(e){
if(hasClass(e,cn)){elemList.push(e);}
		   })
        return $c(elemList);
};		
function change_bg(obj){
var a=document.getElementsByClassName("class_nav")[0].getElementsByTagName("a");
for(var i=0;i<a.length;i++){a[i].className="";}
obj.className="current";
}

 //--------------------------------end 高亮显示导航-----------------------------------------------------------------------------------------
 