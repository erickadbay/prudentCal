$(document).ready(function() {
    $('#success_banner').fadeIn(700, function(){
        setTimeout(function(){
            $('#success_banner').fadeOut(700);
        }, 2000);
    });
});
