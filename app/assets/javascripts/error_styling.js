$(document)
  .on('change', '.has-error', function() {
    console.log('Query');
    var has_error = $(this);
    console.log(has_error);
    has_error.removeClass("has-error");
    $(this)
      .wrap('<div />')
      .find('span')
      .remove();
    //find parent tab-pane get id,
    var parent = has_error.parents('.tab-pane');
    var has_more_errors = parent.find('.has-error');

    if (has_more_errors.length === 0) {
      // find nav-panel w/ href of match id,
      // then remove has-error
      var link = $(document)
        .find(`.nav-link.has-error[href='#${parent.attr('id')}']`);
      link.removeClass("has-error");
    }
  });