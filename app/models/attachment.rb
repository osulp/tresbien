class Attachment < ApplicationRecord
  belongs_to :reimbursement_request

  # has_attached_file :attachments,
  #                   path: "rails_root/public/attachments/:id/:filename",
  #                   url: "/attachments/:id/:filename"
  #do_not_validate_attachment_file_type :file
  has_attached_file :attachment, styles: { thumb: ["100x100>", :jpg] }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :attachment, content_type: [/png\Z/, /jpe?g\Z/, /gif\Z/, /application\/pdf/]

end
