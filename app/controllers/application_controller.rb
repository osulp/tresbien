class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :set_country_sym, only: [:cities, :states]
  before_action :redirect_to_sign_in, unless: :user_signed_in?
  before_action :set_application_configurations

  def cities
    render json: CS.cities(params[:state], @country_sym).to_json
  end

  def states
    render json: CS.states(@country_sym).to_json
  end

  private

  def set_country_sym
    @country_sym = CS.countries.find { |k, v| k == params[:country].to_sym }.first
  end

  def validate_user
    if current_user && !current_user.required_fields?
      flash[:error] = "Required user details are missing, please update."
      redirect_to user_set_id_path
    end
  end

  def redirect_to_sign_in
    redirect_to new_user_session_path
  end

  def set_application_configurations
    @contact_email = ApplicationConfiguration.contact_email.pluck(:value).first
  end
end
