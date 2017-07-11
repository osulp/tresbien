class CityStateController < ApplicationController
  def cities
    render json: CS.cities(params[:state], :us).to_json
  end

end
