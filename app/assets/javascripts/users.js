$(document).on("click","#close_notice",function(){ 
	$(this).parent('div').hide();	
});

$(document).ready(function() {
 var count=$("#error_notice").text().length;
if(count<3)
{
	$("#error_notice").css("display","none");
}

var count2=$("#notice").text().length;
if(count2<3)
{
	$("#notice").css("display","none");
}

});
