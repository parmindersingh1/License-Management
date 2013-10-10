$(document).on("click", "#close_notice", function() {
	$(this).parent('div').hide();
});


$(document).on("click", "#delete_user", function() {
	
	$('#delete_user_modal').modal('show');
	var user_id = $(this).attr("user")
	$("#user_id1").val(user_id);
	
});

$(document).on("click", "#delete_selected_user", function() {
	var user = $("#user_id1").val();
	$.get("/users/delete_user?id="+user,function(data){
		if(data.valid){	
			refresh_users()
			$('#delete_user_modal').modal('hide');
			$('#outer_block').empty();
			$('.alert').show();
			$('#outer_block').html('<a class="close"  href="#">&times;</a>' + data.message).removeClass("alert-error").addClass("alert-success");				
		}else{
			$('#delete_user_modal').modal('hide');
			$('#outer_block').empty();
			$('.alert').show();
			$('#outer_block').html('<a class="close"  href="#">&times;</a>' + data.message).removeClass("alert-success").addClass("alert-error");				
		}
	});

});
function refresh_users () {
		$.get("/users/refersh_user",function(data){
		$("#all_users").empty();
		$("#all_users").html(data);
	});
  
}


