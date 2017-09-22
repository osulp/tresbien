# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  # devise :database_authenticatable, :registerable,
  #        :recoverable, :rememberable, :trackable, :validatable
  devise :cas_authenticatable
  belongs_to :organization, optional: true
  validates :username, presence: true
  validates :email, presence: true
  validates :full_name, presence: true
  validates :osu_id, presence: true
  validates :activity_code, presence: true

  def can_manage(reimbursement_request)
    reimbursement_request.certifier.id == id
  end

  def required_fields?
    !osu_id.blank? && !activity_code.blank? && !organization.nil?
  end

  def full_name_label
    full_name.to_s
  end

  # Sets email and pidm attributes for current_user
  # If a user is created manually in the database but email and pidm fields are left blank,
  # this will set those fields for that user
  def cas_extra_attributes=(extra_attributes)
    extra_attributes.each do |name, value|
      case name.to_sym
      # when :fullname
      #   self.fullname = value
      when :email
        self.email = value
      when :osupidm
        self.pidm = value
      when :fullname
        self.full_name = value
      end
    end
  end
end
