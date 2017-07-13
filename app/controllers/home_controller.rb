class HomeController < ApplicationController
  def index
    if user_signed_in?
      redirect_to expense_types_path
    end
  end
end
