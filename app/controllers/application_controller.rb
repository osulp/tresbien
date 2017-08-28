class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :set_country_sym, only: [:cities, :states]

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
end
