module UserAdmin
  extend ActiveSupport::Concern

  included do
    rails_admin do
      include_fields :email, :username, :index_code, :admin, :certifier
    end
  end
end
