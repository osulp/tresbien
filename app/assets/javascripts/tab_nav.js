$(document).ready(function() {
  $("main").find(".nav-link").each(function() {
    var tabPanel = $($(this).attr('href'));
    if (tabPanel.find(".has-error").length > 0) {
      $(this).addClass("has-error");
    }
  });
});
