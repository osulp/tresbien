onbeforeunload = (event) => {
  if ($('.reimbursement-request-form.new-record')
    .length > 0 && $(event.target.activeElement)
    .prop("type") !== "submit") {
    var dialogText = "You haven't saved this new request";
    event.returnValue = dialogText;
    return dialogText;
  }
};

window.onbeforeunload = onbeforeunload;