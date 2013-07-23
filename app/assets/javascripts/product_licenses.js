$(document).on("click", "#generate_button", function() {
	var keys_count = $("#keys_count").val();
	if (keys_count >100) {
		alert("greater");

	} else {
		$.get("/product_licenses/generate_keys",{keys_count:keys_count}, function(data) {
            location.reload();
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
        if ( event.keyCode == 46 || event.keyCode == 8 || event.keyCode == 9 || event.keyCode == 27 || event.keyCode == 13 || 
             // Allow: Ctrl+A
            (event.keyCode == 65 && event.ctrlKey === true) || 
             // Allow: home, end, left, right
            (event.keyCode >= 35 && event.keyCode <= 39)) {
                 // let it happen, don't do anything
                 return;
        }
        else {
            // Ensure that it is a number and stop the keypress
            if (event.shiftKey || (event.keyCode < 48 || event.keyCode > 57) && (event.keyCode < 96 || event.keyCode > 105 )) {
                event.preventDefault(); 
            }   
        }
    });
});