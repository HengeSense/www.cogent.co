$(function() {
  var slider =  $(".royalSlider").royalSlider({
    loopRewind: true,
    autoScaleSlider: true,
    keyboardNavEnabled: true,
    visibleNearby: {
      enabled: true,
      centerArea: 0.35,
      center: false,
      // breakpoint: 650,
      // breakpointCenterArea: 0.64,
      // navigateByCenterClick: true
      navigateByClick: false
    }
  }).data('royalSlider');

  $('.slider-next').click(function(){slider.next()});
  $('.slider-prev').click(function(){slider.prev()});
});