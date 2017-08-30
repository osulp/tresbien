
# frozen_string_literal: true

class StatusComment < ApplicationRecord
  belongs_to :reimbursement_request
  belongs_to :user
  validates :comment, presence: true
end
