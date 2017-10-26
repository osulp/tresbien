# frozen_string_literal: true

RailsAdmin.config do |config|
  config.authorize_with do
    redirect_to main_app.root_path unless warden.user.admin == true
  end

  ### Popular gems integration

  ## == Devise ==
  # config.authenticate_with do
  #   warden.authenticate! scope: :user
  # end
  # config.current_user_method(&:current_user)

  ## == Cancan ==
  # config.authorize_with :cancan

  ## == Pundit ==
  # config.authorize_with :pundit

  ## == PaperTrail ==
  # config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0

  ### More at https://github.com/sferik/rails_admin/wiki/Base-configuration

  ## == Gravatar integration ==
  ## To disable Gravatar integration in Navigation Bar set to false
  # config.show_gravatar = true

  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new
    export
    show
    edit
    delete do
      only %w[ReimbursementRequest ApplicationConfiguration]
    end
    show_in_app

    config.included_models = %w[User ExpenseType Description Organization AccountCode ApplicationConfiguration]

    config.model 'User' do
      object_label_method do
        :full_name_label
      end
      edit do
        field :email
        field :full_name
        field :username
        field :osu_id do
          label 'OSU ID'
        end
        field :activity_code do
          label 'Activity Code'
        end
        field :organization do
          inline_add false
          inline_edit false
        end

        field :admin
        field :certifier
      end
    end

    config.model 'Organization' do
      edit do
        field :active
        field :name
        field :organization_code
        field :program_code
        field :fund
        field :vendor_payment_address
        field :users do
          inline_add false
        end
      end
    end

    ## With an audit adapter, you can add:
    # history_index
    # history_show
  end
end
