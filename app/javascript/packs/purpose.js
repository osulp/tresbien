$(function() {
  $('.reimbursement_request_business_notes_and_purpose')
    .on('input', function() {
      var text_length = $(this)
        .find('textarea')
        .val()
        .length;
      $(this)
        .find('p')
        .text(text_length + "/250 characters");
    });
});