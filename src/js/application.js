// 
if (navigator.userAgent.match(/iPhone/i) || navigator.userAgent.match(/iPad/i)) { 
  var viewportmeta = document.querySelector('meta[name="viewport"]'); 
  if (viewportmeta) { 
    viewportmeta.content = 'width=device-width, minimum-scale=1.0, maximum-scale=1.0'; 
    document.body.addEventListener('gesturestart', function() { viewportmeta.content = 'width=device-width, minimum-scale=0.25, maximum-scale=1.6'; }, false); 
  } 
}

// $.fn.stickyPosition = function() {
//   var element = $(this);
//   var elementOffset = $("section:visible:first").offset().top;
//   $(window).scroll(function(e) { 
//     if ($(window).scrollTop() >= elementOffset) {
//       console.log("fixed");
//       console.log(element);
//       element.show();
//       element.css("position", "fixed");
//       element.css("top", "0");
//       element.css("z-index", "1000");
//     } else {
//       console.log("relative");
//       element.css("position", "relative");  
//     }
//   });
// }


$(document).ready(function() {
  // $(".container:first").stickyPosition();
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