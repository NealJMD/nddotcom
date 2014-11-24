$(document).ready(function(){

  var random_integer = function(min, max) {
    return Math.floor(Math.random() * (max - min)) + min;
  }

  var change_bg_color = function(){
    // yellow is bottom of hue, and dark yellow looks bad so skip it
    var hue = Math.random() * 0.7 + 0.3;
    // keep it dark
    var luminance = Math.random() * 0.05 + 0.05
    // full saturation cause it's dark
    var rgb = hslToRgb(hue, 1, luminance)
    var a = 0.85;
    var rgba = "rgba("+rgb[0]+","+rgb[1]+","+rgb[2]+","+a+")"
    $('.color-overlay').css("background-color", rgba)
  }

  // change_bg_color();
  // var bg_interval = window.setInterval(change_bg_color, 20000);

  $(document).on('touchstart click', '.toggle-nav', function(event){
    event.stopPropagation();
    event.preventDefault();
    if(event.handled !== true) {
      var targets = $('.menu-category.togglable');
      var switcher = $('.toggle-nav .liner')
      if (targets.hasClass('nav-toggled-off')) {
        targets.removeClass('nav-toggled-off').addClass('nav-toggled-on');
        switcher.text('Hide navigation');
      } else {
        targets.removeClass('nav-toggled-on').addClass('nav-toggled-off');
        switcher.text('Show navigation');
      }
      event.handled = true;
    } else {
      return false;
    }
  });
});



// HSL -> RGB
// from repost on http://axonflux.com/handy-rgb-to-hsl-and-rgb-to-hsv-color-model-c
function hue2rgb(p, q, t){
  if(t < 0) t += 1;
  if(t > 1) t -= 1;
  if(t < 1/6) return p + (q - p) * 6 * t;
  if(t < 1/2) return q;
  if(t < 2/3) return p + (q - p) * (2/3 - t) * 6;
  return p;
}

function hslToRgb(h, s, l){
  var r, g, b;
  if (s == 0) {
      r = g = b = l; // achromatic
  } else {
    var q = l < 0.5 ? l * (1 + s) : l + s - l * s;
    var p = 2 * l - q;
    r = hue2rgb(p, q, h + 1/3);
    g = hue2rgb(p, q, h);
    b = hue2rgb(p, q, h - 1/3);
  }
  return [Math.round(r * 255), Math.round(g * 255), Math.round(b * 255)];
}