// 
if (navigator.userAgent.match(/iPhone/i) || navigator.userAgent.match(/iPad/i)) { 
  var viewportmeta = document.querySelector('meta[name="viewport"]'); 
  if (viewportmeta) { 
    viewportmeta.content = 'width=device-width, minimum-scale=1.0, maximum-scale=1.0'; 
    document.body.addEventListener('gesturestart', function() { viewportmeta.content = 'width=device-width, minimum-scale=0.25, maximum-scale=1.6'; }, false); 
  } 
}

$(document).ready(function() {
  $(".products-grid a.show-more").on("click", function(e) {
    $(".products-grid a.optional").removeClass("optional");
    $(e.target).hide();
  });
});