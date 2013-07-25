$(document).ready(function(){
	$("#product_release_date").datepicker({format: "dd/mm/yyyy"});
});

$(document).on("click", "#licenses_gen", function() {
	
	$('#product_model').modal('show');
	var product = $(this).attr("product_id")
	$("#prod_id").val(product);
});
