// 
if (navigator.userAgent.match(/iPhone/i) || navigator.userAgent.match(/iPad/i)) { 
  var viewportmeta = document.querySelector('meta[name="viewport"]'); 
  if (viewportmeta) { 
    viewportmeta.content = 'width=device-width, minimum-scale=1.0, maximum-scale=1.0'; 
    document.body.addEventListener('gesturestart', function() { viewportmeta.content = 'width=device-width, minimum-scale=0.25, maximum-scale=1.6'; }, false); 
  } 
}

$(document).ready(function() {
  $(".products a.show-more").click(function(e) {
    $(".products-grid a.optional").removeClass("optional");
    $(e.target).hide();
  });

  $(".products-grid a").mouseenter(function(e) {
    var img = $(e.currentTarget).find("img");
    $(e.currentTarget).append("<div class='red-white' style='display:none'><h3>"+img.attr("alt")+"</h3></div>");
    $(e.currentTarget).find(".red-white").fadeIn(130);
  });

  $(".products-grid a").mouseleave(function(e) {
    $(e.currentTarget).find(".red-white").fadeOut(130);
    $(e.currentTarget).find(".red-white").remove();
  });

});