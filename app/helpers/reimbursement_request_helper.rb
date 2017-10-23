# frozen_string_literal: true

module ReimbursementRequestHelper
  def get_request_title(reimbursement_request)
    itinerary = reimbursement_request.get_first_travel_itinerary
    "#{itinerary.date.strftime('%e %B %Y')}: #{itinerary.city}, #{itinerary.state}  (#{CS.countries.key(itinerary.country)})"
  end

  def get_simple_date(date)
    date&.strftime('%m/%d/%y')
  end

  def get_table_row_class(reimbursement_request)
    class_string = reimbursement_request.status.downcase + ' '
    class_string += 'claimant ' if current_user.present? && reimbursement_request.claimant_id == current_user.id
    class_string += 'certifier ' if current_user.present? && reimbursement_request.certifier_id == current_user.id
    class_string += 'other-user ' if current_user.present? && reimbursement_request.certifier_id != current_user.id && reimbursement_request.claimant_id != current_user.id
    class_string.html_safe
  end

  def new_record_class(reimbursement_request)
    reimbursement_request.new_record? ? 'new-record' : ''
  end

  def get_status_icon(status)
    if status == 'Draft' || status == 'draft'
      'fa-pencil-square-o'
    elsif status == 'Submitted' || status == 'submitted'
      'fa-dot-circle-o'
    elsif status == 'Approved' || status == 'approved'
      'fa-check-circle-o'
    elsif status == 'Declined' || status == 'declined'
      'fa-times-circle-o'
    else
      'fa-shower'
    end
  end
end
