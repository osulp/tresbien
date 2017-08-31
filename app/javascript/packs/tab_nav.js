isFirstTab = function(tab) {
  if (tab.prev().length == 0) {
    return true;
  } else {
    return false;
  }
}

isLastTab = function(tab) {
  if (tab.next().length == 0) {
    return true;
  } else {
    return false;
  }
}

$(document).ready(function() {
  $("main").find(".nav-link").each(function() {
    var tabPanel = $($(this).attr('href'));
    if (tabPanel.find(".has-error").length > 0) {
      $(this).addClass("has-error");
    }
  });

  $("#error-body ul li").each((i, element) => {
    let panel_href_value = $(element).data('target-nav-panel');
    if (panel_href_value !== undefined) {
      $(`nav > .nav-link[href='#${panel_href_value}']`).addClass('has-error');
    }
  });

}).on('click', '.next-prev-nav', function(e) {
  e.preventDefault();
  currentTabLink = $(".nav-link.active");
  if ($(this).attr('id') == 'prev-tab') {
    currentTabLink.prev().click();
  } else {
    currentTabLink.next().click();
  }
}).on('show.bs.tab hide.bs.tab', 'a.nav-link', function(e) {
  if (isFirstTab($(this))) {
    $('#prev-tab').toggleClass('visibility-hidden');
  }
  if (isLastTab($(this))) {
    $('#next-tab').toggleClass('visibility-hidden');
  }
});

$(document).on('change', '#error-body', () => {

});
