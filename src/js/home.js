$(function() {
  var slider =  $(".royalSlider").royalSlider({
    loopRewind: true,
    autoScaleSlider: false,
    keyboardNavEnabled: true,
    imageAlignCenter: false,
    slideSpacing: 10,
    visibleNearby: {
      enabled: true,
      centerArea: 0.6,
      center: false,
      breakpoint: 650,
      breakpointCenterArea: 0.5,
      navigateByCenterClick: true,
      navigateByClick: false
    }
  }).data('royalSlider');

  $('.slider-next').click(function(){slider.next()});
  $('.slider-prev').click(function(){slider.prev()});
});