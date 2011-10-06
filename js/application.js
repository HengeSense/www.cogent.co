$(document).ready(function() {

  var uri = window.location.href;
  var page_name = _(uri.split("/")[3].split(".")).first();
  $("a." + page_name).addClass('selected')
});
