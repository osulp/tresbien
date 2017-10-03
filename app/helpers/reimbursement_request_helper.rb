# frozen_string_literal: true

module ReimbursementRequestHelper
  def get_request_title(reimbursement_request)
    "#{reimbursement_request.travel_cities.first.from_date.strftime('%e %B %Y')}: #{reimbursement_request.travel_cities.first.city}, #{reimbursement_request.travel_cities.first.state}  (#{CS.countries.key(reimbursement_request.travel_cities.first.country).to_s})"
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

  def get_status_icon(status)
    if status == 'Draft' || status == 'draft'
      return 'fa-pencil-square-o'
    elsif status == 'Submitted' || status == 'submitted'
      return 'fa-dot-circle-o'
    elsif status == 'Approved' || status == 'approved'
      return 'fa-check-circle-o'
    elsif status == 'Declined' || status == 'declined'
      return 'fa-times-circle-o'
    else
      return 'fa-shower'
    end
  end
end
