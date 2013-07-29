$(document).on("click", "#product_license", function() {
	
	$('#product_modal').modal('show');
});

$(document).on("click", "#date_range", function() {
	$('#myModal').modal('show');
});
$(document).on("click", ".close", function() {
	$('.alert').hide();
});

$(document).ready(function() {
	$("#date-start").val("");
	$("#date-end").val("");
	var startDate = "";
	var endDate = "";

	$('#date-start').datepicker({
		format : "dd/mm/yyyy"
	}).on('changeDate', function(ev) {
		if (endDate.valueOf() != "") {
			if (ev.date.valueOf() > endDate.valueOf()) {
				$('#alert').show().find('strong').text('The start date must be before the end date.');
				$("#date-start").val("");
			} else {
				$('#alert').hide();
				startDate = new Date(ev.date);
			}
		} else {
			$('#alert').hide();
			startDate = new Date(ev.date);
		}
		$('#date-start').datepicker('hide');
	});
	$('#date-end').datepicker({
		format : "dd/mm/yyyy"
	}).on('changeDate', function(ev) {

		if (startDate.valueOf() != "") {
			if (ev.date.valueOf() < startDate.valueOf()) {
				$('#alert').show().find('strong').text('The end date must be after the start date.');
				$("#date-end").val("");
			} else {
				$('#alert').hide();
				endDate = new Date(ev.date);
			}
		} else {
			$('#alert').hide();
			endDate = new Date(ev.date);
		}
		$('#date-end').datepicker('hide');
	});
});

$(document).on("submit", "#product_submit", function(e) {
	var product_id = $("#product_license_name").val();
	if ((product_id == "") || (product_id == null)) {
		e.preventDefault();
		alert("error");
		$('#product_alert').show().find('strong').text('Select Product');
	} else {
		$('#product_modal').modal('hide');
	}
});

$(document).ready(function(){
	$('.license_table').dataTable({
  "sDom": "<'row-fluid'<'span6'l><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
  "sPaginationType": "bootstrap"
});
	
});
