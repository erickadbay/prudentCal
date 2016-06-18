$(document).ready(function() {
    $('#welcome_message').fadeIn(700, function(){
        setTimeout(function(){
            $('#welcome_message').fadeOut(700);
        }, 2000);
    });
});
