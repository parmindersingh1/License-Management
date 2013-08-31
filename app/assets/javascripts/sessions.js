$(document).on("click", "#reset_password", function(event) {
	    $(this).button('loading');       
        
	var login_email = $('#email_id').val();
	if(!login_email || login_email.length == 0) {
		$('#outer_block').empty();
		$('.alert').show();
		$('#outer_block').html('<a class="close"  href="#">&times;</a>Please enter your email address for reset password');

	}else{
	$.getJSON('/sessions/recovery', {
		
		'login_email' : login_email,

	}, function(data) {
	 $("#reset_password").button('reset');
		if(data.valid) {			
			$('#outer_block').empty();
			$('.alert').show();
			$('#outer_block').html('<a class="close"  href="#">&times;</a>'+ data.notice).removeClass("alert-error").addClass("alert-success");
		}
		else{
			
			$('#outer_block').empty();
			$('.alert').show();
			$('#outer_block').html('<a class="close"  href="#">&times;</a>'+ data.notice).removeClass("alert-success").addClass("alert-error");
		}
	});
	}
});

$(document).on("click","#change_password",function(event){
	
	var old_pass =$("#old_password").val();
	var new_pass =$("#new_password").val();
	var confirm_pass =$("#confirm_password").val();
	var user_id = $("#user_id").val();
	
	if (!old_pass || old_pass.length == 0){
		$('#outer_block').empty();
		$('.alert').show();
		$('#outer_block').html('<a class="close"  href="#">&times;</a> Old Password field is empty...').removeClass("alert-success").addClass("alert-error");
		return false;
	}
	
	if (!new_pass || new_pass.length == 0){
		$('#outer_block').empty();
		$('.alert').show();
		$('#outer_block').html('<a class="close"  href="#">&times;</a> New Password field is empty...').removeClass("alert-success").addClass("alert-error");
		return false;
	}
	
	if (!confirm_pass || confirm_pass.length == 0){
		$('#outer_block').empty();
		$('.alert').show();
		$('#outer_block').html('<a class="close"  href="#">&times;</a> Confirm Password field is empty...').removeClass("alert-success").addClass("alert-error");
		return false;
	}
	
	if( new_pass != confirm_pass){
		$('#outer_block').empty();
		$('.alert').show();
		$('#outer_block').html('<a class="close"  href="#">&times;</a> Confirm Password not matched...').removeClass("alert-success").addClass("alert-error");
		return false;
	}
	
	$.getJSON("/sessions/change_password",{
		'old_pass' : old_pass,
		'new_pass' : new_pass},
		function(data){
			if (data.valid){
				$('#outer_block').empty();
				$('.alert').show();
				$('#outer_block').html('<a class="close"  href="#">&times;</a>'+ data.notice).removeClass("alert-error").addClass("alert-success");
			}
			else{
				$('#outer_block').empty();
				$('.alert').show();
				$('#outer_block').html('<a class="close"  href="#">&times;</a>'+data.notice).removeClass("alert-success").addClass("alert-error");
				
			}
			
		}
	);
});
