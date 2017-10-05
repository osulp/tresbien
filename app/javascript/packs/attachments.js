$(document)
  .ready(function() {
    $('.delete-attachment-btn')
      .on('click', function() {
        $(this)
          .parent()
          .remove();
      });
  });