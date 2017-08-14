class ReimbursementRequestsController < ApplicationController
  before_action :set_reimbursement_request, only: [:show, :edit, :update]
  before_action :set_certifiers, only: [:new, :create, :edit, :update]
  before_action :set_expense_types, only: [:new, :create, :edit, :update]

  def new
    @reimbursement_request = ReimbursementRequest.new
    @reimbursement_request.accountings.build
    @reimbursement_request.expense_airfares.build
    @reimbursement_request.expense_mileages.build
    @reimbursement_request.expense_others.build
    @reimbursement_request.travel_cities.build
    @reimbursement_request.travel_itineraries.build
  end


  def show
    @reimbursement_request = ReimbursementRequest.find(params[:id])
    @children = @reimbursement_request.children
  end

  def create
    @reimbursement_request = ReimbursementRequest.create(reimbursement_request_params)
    @reimbursement_request.claimant = current_user if user_signed_in?
    @reimbursement_request.certifier = User.find(params.dig(:reimbursement_request, :certifier_id)) unless params.dig(:reimbursement_request, :certifier_id)
    @reimbursement_request.expense_others.each_with_index { |expense_other, index| expense_other.expense_type = ExpenseType.find(params[:reimbursement_request][:expense_others_attributes][index.to_s][:expense_type_id]) unless params[:reimbursement_request][:expense_others_attributes][index.to_s][:expense_type_id]  }
    @reimbursement_request.status = Status.order(:order).first
    if @reimbursement_request.save
      if params[:attachments]
        # Uncomment to begin sending emails when reimbursement request is submitted
        # CertifierMailer.certifiy_request(@certifier).deliver_now
        params[:attachments].each do |file|
          @reimbursement_request.attachments.create(attachment: file)
        end
      end
      redirect_to reimbursement_request_path(@reimbursement_request)
    else
      flash[:alert] = "Some fields were left blank"
      puts @reimbursement_request.errors.full_messages.to_s
      render "new"
    end
  end

  def edit
  end

  def update
    if @reimbursement_request.update(reimbursement_request_params)
      redirect_to @reimbursement_request, notice: "Your reimbursement request was updated."
    else
      render :edit
    end
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
      accountings_attributes: [:id, :fund, :organization, :account, :program, :activity, :amount, :_destroy],
      expense_airfares_attributes: [:id, :from_date, :to_date, :from_location, :to_location, :notes, :amount, :_destroy],
      expense_mileages_attributes: [:id, :from_date, :to_date, :from_city, :from_state, :to_city, :to_state, :miles, :round_trip, :notes, :amount, :_destroy],
      expense_others_attributes: [:id, :expense_type_id, :from_date, :to_date, :notes, :amount, :_destroy],
      travel_itineraries_attributes: [:id, :city, :state, :break, :lunch, :dinner, :hotel, :amount, :date, :_destroy],
      travel_cities_attributes: [:id, :from_date, :to_date, :city, :state, :include_meals, :hotel_rate, :_destroy])
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
      puts "parsing params"
      if param_val && param_val.respond_to?("each_pair")
        parse_date_params(param_val)
      else
        if param_key.to_s.include? "date"
          param_val = DateTime.strptime(param_val, "%m/%d/%d").to_date
          puts "converted #{param_key} value to #{param_val}"
        elsif param_key.to_s.include? "time"
          param_val = param_val.to_time
        end
      end
    end
  end
end
