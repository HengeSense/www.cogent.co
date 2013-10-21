if (navigator.userAgent.match(/iPhone/i) || navigator.userAgent.match(/iPad/i)) { 
  var viewportmeta = document.querySelector('meta[name="viewport"]'); 
  if (viewportmeta) { 
    viewportmeta.content = 'width=device-width, minimum-scale=1.0, maximum-scale=1.0'; 
    document.body.addEventListener('gesturestart', function() { viewportmeta.content = 'width=device-width, minimum-scale=0.25, maximum-scale=1.6'; }, false); 
  } 
}

$(function() {
  var slider =  $(".royalSlider").royalSlider({
    loopRewind: true,
    autoScaleSlider: true,
    keyboardNavEnabled: true,
    imageAlignCenter: false,
    addActiveClass: true,
    slideSpacing: 10,
    sliderDrag:false,
    navigateByCenterClick: false,
    navigateByClick: false,
    visibleNearby: {
      enabled: true,
      centerArea: 0.6,
      center: false,
      breakpoint: 650,
      breakpointCenterArea: 0.5,
    }
  }).data('royalSlider');

  $('.slider-next').click(function(){slider.next()});
  $('.slider-prev').click(function(){slider.prev()});
  $('.slider-prev').hide();

  slider.ev.on('rsAfterSlideChange', function(event) {
    var $next = $('.slider-next');
    var $prev = $('.slider-prev');
    if (slider.currSlideId <= 0) {
      $prev.hide();
      $next.show();
    } else if (slider.currSlideId > 0 && slider.currSlideId < (slider.numSlides - 1)){
      $prev.show();
      $next.show();
    } else {
      $prev.show();
      $next.hide();
    }
  });

  // TODO try to find a better way to do this. maybe ad an anchor dynamically?
  // Make slider image behave like a link if it is the active one
  $(".royalSlider").on("click", ".jsLink", function(){
      var isTheActiveSlide = $(this).parents('.rsActiveSlide').length >= 1;
      if (isTheActiveSlide) {
        window.location.href = $(this).attr('data-href');
      }
  });
});
