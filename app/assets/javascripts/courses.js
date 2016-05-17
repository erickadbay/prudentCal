$(document).ready(function() {
  displayWelcomeMessage();
  $('#submitbtn').click(function(evt) {
    if (!checkForm('course_course_name')) {
      evt.preventDefault();
      alert('Please provide a course name and submit again.');
      return false;
    }
    $('form#submitbtn').submit();
  });
});

function checkForm(id) {
  if ($('#' + id).val() === null || $('#' + id).val() === '') {
    return false;
  } else {
    return true;
  }
}
function displayWelcomeMessage(){
    $('#welcome_message').fadeIn(700, function(){
        setTimeout(function(){
            $('#welcome_message').fadeOut(700);
        }, 3000)
    });
}
