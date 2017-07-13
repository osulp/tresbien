
Rails.application.routes.draw do

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  #makes expense_types root
  root 'home#index'

  get 'states/:country', to: 'application#states'
  get 'cities/:state', to: 'application#cities'

  resources :expense_types
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end