// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

$(document).ready(function(){
  var LEFT_KEYCODE = 37;
  var RIGHT_KEYCODE = 39;
  $('html').keydown(function(e){
    var pressed = e.which;
    if (pressed == LEFT_KEYCODE) {
      $('.proximal-buttons .previous').click();
    } else if (pressed == RIGHT_KEYCODE) {
      $('.proximal-buttons .next').click();
    }
  });
})