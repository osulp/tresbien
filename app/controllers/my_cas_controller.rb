# from https://github.com/nbudin/devise_cas_authenticatable/wiki/Suppress-devise-login-flash-errors
class MyCasController < Devise::CasSessionsController
  skip_before_action :redirect_to_sign_in, only: [:new, :single_sign_out]
end
