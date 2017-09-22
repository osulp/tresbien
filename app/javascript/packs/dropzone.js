Dropzone.options.fileUploader = {
  url: "/files/upload",
  dictDefaultMessage: "Click (or drag/drop files) here to upload.",
  success: (response, file) => {
    //add a hidden input with the file_id that was generated, to be attached to the reimbursement_request when its created
    $('<input>', {
      type: 'hidden',
      name: 'file_ids[]',
      value: file['id']
    }).appendTo('#file_uploader');
  }
};
