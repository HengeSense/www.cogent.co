$(function() {
  var slider =  $(".royalSlider").royalSlider({
    loopRewind: true,
    autoScaleSlider: false,
    keyboardNavEnabled: true,
    imageAlignCenter: false,
    addActiveClass: true,
    slideSpacing: 10,
    sliderDrag:false,
    navigateByCenterClick: false,
    navigateByClick: true,
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
});