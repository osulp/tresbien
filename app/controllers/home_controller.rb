# frozen_string_literal: true

class HomeController < ApplicationController
  before_action :set_reimbursement_requests, only: [:index]
  before_action :authenticate_user!

  def index; end

  private

  def set_reimbursement_requests
    @reimbursement_requests = ReimbursementRequest.all.sort_by { |r| [r.status, r.updated_at] }
    # if user_signed_in?
    #   if current_user.admin
    #     @reimbursement_requests = APPLICATION_CONFIG[:statuses].order_by(&:order).map { |status| status.reimbursement_requests.order(updated_at: :desc) }.flatten
    #   elsif current_user.certifier
    #     # @reimbursement_requests = ReimbursementRequest.where("status.name = ? AND certifier_id = ? OR claimant_id = ?", "Pending", current_user.id, current_user.id)
    #     @reimbursement_requests = APPLICATION_CONFIG[:statuses].order_by(&:order).map { |status| status.reimbursement_requests.order(updated_at: :desc) }.flatten.map { |request| request if request.certifier_id == current_user.id || request.claimant_id == current_user.id }
    #   else
    #     @reimbursement_requests = APPLICATION_CONFIG[:statuses].order_by(&:order).map { |status| status.reimbursement_requests.order(updated_at: :desc) }.flatten.map { |request| request if request.claimant_id == current_user.id }
    #   end
    # end
  end
end
