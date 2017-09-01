# frozen_string_literal: true

class HomeController < ApplicationController
  before_action :set_reimbursement_requests, only: [:index]
  before_action :authenticate_user!

  def index; end

  private

  def set_reimbursement_requests
    status_orders = APPLICATION_CONFIG[:statuses].map { |k, v| [k , v["order"] ] }.to_h
    if current_user.admin
      @reimbursement_requests = ReimbursementRequest.all
    else 
      @reimbursement_requests = ReimbursementRequest.user_claimant_requests(current_user.id)
      @reimbursement_requests += ReimbursementRequest.user_certifier_requests(current_user.id) if current_user.certifier
    end
    @reimbursement_requests = @reimbursement_requests.group_by { |r| status_orders[r.status.downcase] }
    .sort_by { |order, requests| order }
    .map { |group, requests| requests.sort_by { |r| r.updated_at }.reverse }
    .flatten
  end
end
