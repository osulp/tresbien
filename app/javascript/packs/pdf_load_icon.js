$(document)
  .on('click', '#pdf-export-button', (e) => {
    $(e.currentTarget)
      .addClass('loading disabled')
      .tooltip('hide');
    $(e.currentTarget)
      .children('.fa-spin')
      .first()
      .removeClass('hidden');
  })