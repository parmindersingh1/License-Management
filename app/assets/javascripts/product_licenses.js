$(document).on("click", "#generate_button", function() {
	var keys_count = $("#keys_count").val();
	// var product_id = $("#prod_id").val();
	var product_list = new Array();
	$('input[type=checkbox]').each (function(){
				if(this.checked){
					product_list.push(this.value)
				}
	});
	if(product_list.length==0)
	{
		$('.alert').show().text('Select Products');
	
	}
	else if((keys_count ==null) || (keys_count == ""))
	{
			$('.alert').show().text('Enter number of keys to generate');
	}
	
	else if ((keys_count > 100) || (keys_count < 1) ) {

		$('.alert').show().text('key must be between 1 to 100');

	} 
	else {
		$.get("/product_licenses/generate_keys", {
			keys_count : keys_count,
			product_list : product_list
		}, function(data) {	
			if(!data.valid)		{	
				$('#product_model').modal('hide');
				$('#outer_block').empty();
				$('.alert').show();
				//$('#outer_block').html('<a class="close"  href="#">&times;</a>' + data.notice).removeClass("alert-error").addClass("alert-success");
			  $("#generated_license").empty();
			  $("#generated_license").html(data);
			 }
			 else{
			 	
			 $('.alert').show().find('strong').text('Error Generating Keys');
			 }
		});

	}

});
// $(document).on("click","#product_keys",function(){
// $.get("keys/display_keys",function(data){
//
// });
// });
$(document).ready(function() {
	$("#keys_count").keydown(function(event) {
		// Allow: backspace, delete, tab, escape, and enter
		if (event.keyCode == 46 || event.keyCode == 8 || event.keyCode == 9 || event.keyCode == 27 || event.keyCode == 13 ||
		// Allow: Ctrl+A
		(event.keyCode == 65 && event.ctrlKey === true) ||
		// Allow: home, end, left, right
		(event.keyCode >= 35 && event.keyCode <= 39)) {
			// let it happen, don't do anything
			return;
		} else {
			// Ensure that it is a number and stop the keypress
			if (event.shiftKey || (event.keyCode < 48 || event.keyCode > 57) && (event.keyCode < 96 || event.keyCode > 105 )) {
				event.preventDefault();
			}
		}
	});
});

$(document).on("submit", "#date_submit", function(e) {
	if (($('#alert').is(':visible')) || ($("#date-start").val() == "" || $("#date-end").val() == "")) {
		e.preventDefault();
		$('#alert').show().find('strong').text('Start Date or End Date is Empty');
	} else {
		$('#myModal').modal('hide');
	}
});

$(document).on("change", "#product_licence_name", function(event) {
	var product_id = $(this).val();

	$.get("/product_licenses/show_licenses", {
		product_id : product_id

	}, function(data) {		
		$("#response_div").empty();
		$("#response_div").html(data);
	});
});

$(document).ready(function(){
	$("#example").dataTable();
});
////////////////////////////////////////

