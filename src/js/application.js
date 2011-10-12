function highlight_selected_menu_item() {
  var uri = window.location.href;
  var page_name = _(uri.split("/")[3].split(".")).first();
  $("a." + page_name).addClass('selected');
}

$(document).ready(function() {
  highlight_selected_menu_item();
  $("span.time").timeago();
});


