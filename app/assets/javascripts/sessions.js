

$(document).on("click","#reset_password",function(event){
	var login_email = $('#email_id').val();
	
	if(!login_email || login_email.length == 0) {
		 $('#outer_block').append("Please enter your email address for reset password")
						
	}
});

