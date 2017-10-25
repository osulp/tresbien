# frozen_string_literal: true

class ReimbursementRequestsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_reimbursement_request, only: %i[show edit update approve decline]
  before_action :set_certifiers, only: %i[new create edit update]
  before_action :set_account_codes, only: %i[new create edit update]
  before_action :set_expense_types, only: %i[new create edit update]
  before_action :set_statuses, only: %i[new create edit update]
  before_action :set_descriptions, only: %i[new create edit update]
  before_action :redirect_unless_claimant_or_admin, only: %i[show edit update approve decline]

  def new
    @reimbursement_request = ReimbursementRequest.new
    @reimbursement_request.travel_cities.build
    @reimbursement_request.accountings.build
  end

  def index
    redirect_to root_path
  end

  def show
    respond_to do |format|
      format.html
      format.pdf do
        # pdf = WickedPdf.new.pdf_from_string(render_to_string(template: "reimbursement_requests/show", layout: "pdf", formats: :html))
        pdf = CombinePDF.new
        pdf << CombinePDF.parse(
          WickedPdf.new.pdf_from_string(
            render_to_string(
              template: "reimbursement_requests/show.html.erb",
              layout: "pdf",
              handlers: [:erb],
              formats: [:pdf]
            )
          )
        )
        @image_attachments = []
        @reimbursement_request.attachments.each do |attachment|
          if attachment.is_image?
            @image_attachments << attachment
          elsif attachment.is_pdf?
            pdf << CombinePDF.parse(
              WickedPdf.new.pdf_from_string(
                render_to_string(template: 'attachments/pdf', layout: 'pdf')))
            pdf << CombinePDF.load(attachment.attachment.path, allow_optional_content: true)
            @image_attachments.clear
          end
        end
        pdf << CombinePDF.parse(
          WickedPdf.new.pdf_from_string(
            render_to_string(template: 'attachments/pdf', layout: 'pdf'))) unless @image_attachments.empty?
        send_data pdf.to_pdf, disposition: 'inline', type: 'application/pdf'
      end
    end
  end

  def create
    @reimbursement_request = ReimbursementRequest.create(reimbursement_request_params)
    @reimbursement_request.status = params[:status]
    @reimbursement_request.claimant = current_user if user_signed_in?
    @reimbursement_request.certifier = User.find(params.dig(:reimbursement_request, :certifier_id)) unless params.dig(:reimbursement_request, :certifier_id)
    @reimbursement_request.description = Description.find(params.dig(:reimbursement_request, :description_id)) unless params.dig(:reimbursement_request, :description_id)
    if @reimbursement_request.save
      if @reimbursement_request.status == 'submitted'
        submit_request
        certify_request
      end
      attach_files
      redirect_to reimbursement_request_path(@reimbursement_request)
    else
      render :new
    end
  end

  def edit; end

  def update
    old_status = @reimbursement_request.status
    @reimbursement_request.status = params[:status]
    @reimbursement_request.description = Description.find(params.dig(:reimbursement_request, :description_id)) unless params.dig(:reimbursement_request, :description_id)
    if @reimbursement_request.update(reimbursement_request_params)
      case @reimbursement_request.status
      when 'declined'
        decline_request
      when 'approved'
        approve_request
      when 'submitted'
        old_status == 'draft' ? certify_request : resubmit_request
        submit_request
      end
      synch_files
      redirect_to @reimbursement_request, notice: 'Your reimbursement request was updated.'
    else
      render :edit
    end
  end

  def approve
    @reimbursement_request.update(status: 'approved')
    approve_request
    redirect_to reimbursement_request_path(@reimbursement_request)
  end

  def decline
    @reimbursement_request.update(status: 'declined')
    decline_request
    redirect_to reimbursement_request_path(@reimbursement_request)
  end

  def decline_request
    StatusMailer.decline_request(@reimbursement_request).deliver_now
  end

  def approve_request
    StatusMailer.approve_request(@reimbursement_request).deliver_now
  end

  def submit_request
    StatusMailer.submit_request(@reimbursement_request).deliver_now
  end

  def certify_request
    StatusMailer.certify_request(@reimbursement_request).deliver_now
  end

  def resubmit_request
    StatusMailer.resubmit_request(@reimbursement_request).deliver_now
  end

  private

  def attach_files
    params[:file_ids]&.each do |id|
      @reimbursement_request.attachments << Attachment.find(id)
    end
  end

  def synch_files
    file_ids = params[:file_ids] || []
    existing_file_ids = @reimbursement_request.attachments.pluck(:id)
    existing_file_ids.each do |id|
      @reimbursement_request.attachments.delete(id) unless file_ids.include?(id)
    end
    file_ids.each do |id|
      @reimbursement_request.attachments << Attachment.find(id) unless existing_file_ids.include?(id)
    end
  end

  def reimbursement_request_params
    params.require(:reimbursement_request).permit(
      :identifier,
      :claimant_id,
      :certifier_id,
      :description_id,
      :itinerary_total,
      :mileage_total,
      :airfare_total,
      :other_total,
      :accounting_total,
      :grand_total,
      :claiming_total,
      :depart_time,
      :return_time,
      :non_resident_alien,
      :business_notes_and_purpose,
      :address,
      :status_comment,
      :status,
      accountings_attributes: %i[id index fund organization account program activity amount client_id _destroy],
      expense_airfares_attributes: %i[id from_date to_date from_location to_location notes amount _destroy],
      expense_mileages_attributes: %i[id from_date to_date from_city from_state to_city to_state miles round_trip notes amount _destroy],
      expense_others_attributes: %i[id expense_type_id from_date to_date notes amount above_per_diem_expense client_id _destroy],
      travel_itineraries_attributes: %i[id country city state break lunch dinner hotel amount date per_diem client_id _destroy],
      travel_cities_attributes: %i[id from_date to_date country city state include_meals meals hotel_rate per_diem client_id _destroy]
    )
  end

  def set_reimbursement_request
    @reimbursement_request = ReimbursementRequest.find(params[:id])
  end

  def set_certifiers
    @certifiers = User.where(certifier: true)
  end

  def set_statuses
    @statuses = APPLICATION_CONFIG[:statuses]
  end

  def set_account_codes
    @account_codes = AccountCode.all
  end

  def set_expense_types
    @expense_types = ExpenseType.where(active: true)
  end

  def set_descriptions
    @descriptions = Description.where(active: true)
  end

  # converts all date and time params into valid formats
  # Pre conditions: date and time values should include "date" and "time" in their names, respectively
  #   Non date/time values should not include these terms in their names
  #   All dates must be strings in mm/dd/yy format
  # Post conditions: dates and times will be converted to datetime/time acceptable formats and will be processed correctly when entered into the db
  # Doesn't work right now

  def parse_date_params(params)
    params.each do |param_key, param_val|
      if param_val && param_val.respond_to?('each_pair')
        parse_date_params(param_val)
      else
        if param_key.to_s.include? 'date'
          param_val = DateTime.strptime(param_val, '%m/%d/%d').to_date
        elsif param_key.to_s.include? 'time'
          param_val = param_val.to_time
        end
      end
    end
  end

  def redirect_unless_claimant_or_admin
    if !current_user.admin && @reimbursement_request.claimant != current_user
      flash[:error] = "You are not authorized to view this reimbursement request."
      redirect_to root_path
    end
  end
end
