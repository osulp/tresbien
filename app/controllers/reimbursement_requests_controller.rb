# frozen_string_literal: true

class ReimbursementRequestsController < ApplicationController
  before_action :set_reimbursement_request, only: %i[show edit update]
  before_action :set_certifiers, only: %i[new create edit update]
  before_action :set_expense_types, only: %i[new create edit update]

  def new
    @reimbursement_request = ReimbursementRequest.new
    @reimbursement_request.travel_cities.build
  end

  def index
    @status_comments = StatusComment.all
    redirect_to root_path
  end

  def show
    @status_comments = @reimbursement_request.status_comments
    @children = @reimbursement_request.children
    respond_to do |format|
      format.html
      format.pdf do
        render pdf: @reimbursement_request.id.to_s,
               template: 'reimbursement_requests/show.html.erb',
               layout: 'pdf',
               handlers: [:erb],
               formats: [:pdf]
      end
    end
  end

  def create
    @reimbursement_request = ReimbursementRequest.create(reimbursement_request_params)
    @reimbursement_request.claimant = current_user if user_signed_in?
    @reimbursement_request.certifier = User.find(params.dig(:reimbursement_request, :certifier_id)) unless params.dig(:reimbursement_request, :certifier_id)
    @reimbursement_request.status = Status.order(:order).first
    if @reimbursement_request.save
      params[:attachments]&.each do |file|
        @reimbursement_request.attachments.create(attachment: file)
      end
      redirect_to reimbursement_request_path(@reimbursement_request)
    else
      render 'new'
    end
  end

  def edit; end

  def update
    if @reimbursement_request.update(reimbursement_request_params)
      redirect_to @reimbursement_request, notice: 'Your reimbursement request was updated.'
    else
      render :edit
    end
  end

  def comment
    reimbursement_request = ReimbursementRequest.find(params[:reimbursement_request_id])
    reimbursement_request.status_comments << StatusComment.create(comment: params[:status_comment][:comment], user: current_user)
    reimbursement_request.save
    redirect_to reimbursement_request_path(reimbursement_request)
  end

  def delete_comment
    reimbursement_request = ReimbursementRequest.find(params[:reimbursement_request_id])
    status_comment = StatusComment.find(params[:id])
    status_comment.destroy
    redirect_to reimbursement_request_path(reimbursement_request)
  end

  private

  def reimbursement_request_params
    params.require(:reimbursement_request).permit(
      :attachments,
      :identifier,
      :description,
      :claimant_id,
      :certifier_id,
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
      accountings_attributes: %i[id fund organization account program activity amount _destroy],
      expense_airfares_attributes: %i[id from_date to_date from_location to_location notes amount _destroy],
      expense_mileages_attributes: %i[id from_date to_date from_city from_state to_city to_state miles round_trip notes amount _destroy],
      expense_others_attributes: %i[id expense_type_id from_date to_date notes amount _destroy],
      travel_itineraries_attributes: %i[id country city state break lunch dinner hotel amount date _destroy],
      travel_cities_attributes: %i[id from_date to_date country city state include_meals hotel_rate _destroy]
    )
  end

  def set_reimbursement_request
    @reimbursement_request = ReimbursementRequest.find(params[:id])
  end

  def set_certifiers
    @certifiers = User.where(certifier: true)
  end

  def set_expense_types
    @expense_types = ExpenseType.where(active: true)
  end

  # converts all date and time params into valid formats
  # Pre conditions: date and time values should include "date" and "time" in their names, respectively
  #   Non date/time values should not include these terms in their names
  #   All dates must be strings in mm/dd/yy format
  # Post conditions: dates and times will be converted to datetime/time acceptable formats and will be processed correctly when entered into the db
  # Doesn't work right now

  def parse_date_params(params)
    params.each do |param_key, param_val|
      puts 'parsing params'
      if param_val && param_val.respond_to?('each_pair')
        parse_date_params(param_val)
      else
        if param_key.to_s.include? 'date'
          param_val = DateTime.strptime(param_val, '%m/%d/%d').to_date
          puts "converted #{param_key} value to #{param_val}"
        elsif param_key.to_s.include? 'time'
          param_val = param_val.to_time
        end
      end
    end
  end
end
