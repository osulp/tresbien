# frozen_string_literal: true

module ReimbursementRequestHelper
  # returns the html for the remove button as an html safe string
  def remove_button
    '<span class="glyphicon glyphicon-minus bg-danger" id="blah"></span>'
  end

  # returns the html for the add button as an html safe string
  def add_button
    '<span class="glyphicon glyphicon-plus bg-success"></span>'.html_safe
  end

  # returns date formatted as a string in mm/dd/yy format
  def get_simple_date_time(date)
    date&.strftime('%m/%d/%y, %l:%M %p')
  end

  def get_simple_date(date)
    date&.strftime('%m/%d/%y')
  end

  def get_table_row_class(reimbursement_request)
    class_string = reimbursement_request.status.name.downcase + ' '
    class_string += 'claimant ' if user_signed_in? && reimbursement_request.claimant_id == current_user.id
    class_string += 'certifier ' if user_signed_in? && reimbursement_request.certifier_id == current_user.id
    class_string += 'other-user ' if user_signed_in? && reimbursement_request.certifier_id != current_user.id && reimbursement_request.claimant_id != current_user.id
    class_string.html_safe
  end
end
