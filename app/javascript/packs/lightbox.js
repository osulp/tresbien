$(function() {
  $('.openModal')
    .on('click', function() {
      let id = $(this)
        .data('id');
      $(`.modal.attachment-${id}`)
        .show();
    });
});


$(function() {
  $('.close')
    .on('click', function() {
      $(this)
        .parent()
        .hide();
    });
});

$(function() {
  $('.modal')
    .on('click', function() {
      $(this)
        .hide();
    });
});