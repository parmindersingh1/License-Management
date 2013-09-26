
$(document).on("click", "#licenses_gen", function() {
	
	$('#product_model').modal('show');
	var product = $(this).attr("product_id")
	$("#prod_id").val(product);
	
});

$(document).on("click","#delete_product", function() {
	
	$('#delete_product_modal').modal('show');
	
	$('.product_name').each (function(){
				if(this.checked){
					$("#products_div").append("<input type='hidden' class='p_ids' value='"+(this.value)+"'>");
				}
	});
	$("#products").val(product_list);
});
$(document).on("click","#delete_selected_product",function(event){
	product_list = new Array();
	$(".p_ids").each (function(){
		product_list.push(this.value)
	});
	
	if (product_list.length == 0){
		$('#outer_block').empty();
		$('.alert').show();
		$('#outer_block').html('<a class="close"  href="#">&times;</a>Please Select Products to delete').removeClass("alert-success").addClass("alert-error");
	}
	else
	{
	 $.get("/products/delete_product",{products : product_list},function(data){
		if (data.valid){
			$('#outer_block').empty();
			$('.alert').show();
			$('#outer_block').html('<a class="close"  href="#">&times;</a>'+data.notice).removeClass("alert-error").addClass("alert-success");
		}else
			{
			$('#outer_block').empty();
			$('.alert').show();
			$('#outer_block').html('<a class="close"  href="#">&times;</a>'+data.notice).removeClass("alert-success").addClass("alert-error");

		}
		 	
	 });
	}
	
	
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

// $(document).on("click","#delete_product", function() {
	// deleteproductmodelbox();
	// // var product_id = $("#product_id1").val();
	// // $.get("products/delete_product?id="+product_id,function(data){
		// // if(data.valid){	
			// // $('#delete_product_modal').modal('hide');
			// // $('#outer_block').empty();
			// // $('.alert').show();
			// // $('#outer_block').html('<a class="close"  href="#">&times;</a>' + data.notice).removeClass("alert-error").addClass("alert-success");				
		// // }else{
			// // $('#delete_product_modal').modal('hide');
			// // $('#outer_block').empty();
			// // $('.alert').show();
			// // $('#outer_block').html('<a class="close"  href="#">&times;</a>' + data.notice).removeClass("alert-success").addClass("alert-error");				
		// // }
	// // })
// });

