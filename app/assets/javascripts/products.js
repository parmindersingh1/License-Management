$(document).ready(function(){
	$("#product_release_date").datepicker({format: "dd/mm/yyyy"});
});

$(document).on("click", "#licenses_gen", function() {
	
	$('#product_model').modal('show');
	var product = $(this).attr("product_id")
	$("#prod_id").val(product);
});


$(document).on("click","#submit_search", function (){
	var email = $("#search_email").val();
	
	if(!email || email.length == 0) {
		$('#outer_block').empty();
		$('.alert').show();
		$('#outer_block').html('<a class="close"  href="#">&times;</a>Please enter your email address for reset password');

	}else{
		$.get("search_email",{email:email},function(data){
			$("#searched_email").empty();
			$("#searched_email").html(data);
		})	
	}
});

$(document).on("click","#re_gen_id",function(){
	var value= $(this).attr("license_id");
	alert (value);
	
	$.get("allow_regeneration?id="+value,function(data){
		$("#searched_email").empty();
		$("#searched_email").html(data);
	});
})
