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

  def claimant_name(reimbursement_request)
    reimbursement_request.new_record? ? current_user.full_name : reimbursement_request.claimant.full_name
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

  def invoice_number(request)
    request.invoice_number.blank? ? "-- Not Assigned --" : request.invoice_number
  end

  def request_times
    [
      '12:00am',
      '12:30am',
      '1:00am',
      '1:30am',
      '2:00am',
      '2:30am',
      '3:00am',
      '3:30am',
      '4:00am',
      '4:30am',
      '5:00am',
      '5:30am',
      '6:00am',
      '6:30am',
      '7:00am',
      '7:30am',
      '8:00am',
      '8:30am',
      '9:00am',
      '9:30am',
      '10:00am',
      '10:30am',
      '11:00am',
      '11:30am',
      '12:00pm',
      '12:30pm',
      '1:00pm',
      '1:30pm',
      '2:00pm',
      '2:30pm',
      '3:00pm',
      '3:30pm',
      '4:00pm',
      '4:30pm',
      '5:00pm',
      '5:30pm',
      '6:00pm',
      '6:30pm',
      '7:00pm',
      '7:30pm',
      '8:00pm',
      '8:30pm',
      '9:00pm',
      '9:30pm',
      '10:00pm',
      '10:30pm',
      '11:00pm',
      '11:30pm'
    ]
  end
end
