# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :validate_user, except: %i[set_id update]
  before_action :require_fields, only: [:update]
  before_action :set_fields

  def set_id; end

  def update
    if @user.update(user_params)
      flash[:success] = 'User successfully updated.'
      redirect_to root_path
    else
      render :set_id
    end
  end

  private

  def require_fields
    osu_id = params.dig(:user, :osu_id)
    if osu_id.blank? || osu_id.length != 9
      flash[:error] = 'A valid (9 digit) OSU ID is required to use this system.'
    end
    activity_code = params.dig(:user, :activity_code)
    flash[:error] = 'An activity code is required.' if activity_code.blank?
    redirect_to user_set_id_path unless flash[:error].nil?
  end

  def set_fields
    @user = User.find(current_user.id)
    @organizations = Organization.active.sort_by(&:name)
  end

  def user_params
    params.require(:user).permit(:osu_id, :activity_code, :organization_id)
  end
end
