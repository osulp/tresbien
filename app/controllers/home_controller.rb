class HomeController < ApplicationController
  before_action :set_reimbursement_requests, only: [:index]

  def index

  end

  private

  def set_reimbursement_requests
    if user_signed_in?
      if current_user.admin
        @reimbursement_requests = Status.order(:order).map { |status| status.reimbursement_requests.order(updated_at: :desc) }.flatten
      elsif current_user.certifier
        # @reimbursement_requests = ReimbursementRequest.where("status.name = ? AND certifier_id = ? OR claimant_id = ?", "Pending", current_user.id, current_user.id)
        @reimbursement_requests = Status.order(:order).map { |status| status.reimbursement_requests.order(updated_at: :desc) }.flatten.map { |request| request if request.certifier_id == current_user.id or request.claimant_id == current_user.id }
      else 
        @reimbursement_requests = Status.order(:order).map{ |status| status.reimbursement_requests.order(updated_at: :desc) }.flatten.map { |request| request if request.claimant_id == current_user.id }
      end
    end
  end
end
