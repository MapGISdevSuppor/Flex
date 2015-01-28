// JavaScript Document

function $(id){ return document.getElementById(id)}

function changeBgcolor(index,url){
	var total = 15;
	var urlFrame = $("iframe");
	for(var i=1;i<=total;i++){
		var obj = $("li_"+i);
		if(obj!=null){
			if(i==index){
				obj.style.backgroundColor="#BDDEF5";
				//obj.style.backgroundImage = "url(images/left_link_bg_b.gif)";
				urlFrame.src = url;
			}	
			else{
				obj.style.backgroundColor="#F8FCFE";
				//obj.style.backgroundImage = "url(images/left_link_bg_a.gif)";
			}
				
		}
	}
}

function init(){
	var urlFrame = $("iframe");
	if(urlFrame!=null)
		urlFrame.src = "iframe/iframe1_1.html";
}