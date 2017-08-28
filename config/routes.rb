
Rails.application.routes.draw do

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }
  resources :users
  resources :reimbursement_requests do
    resources :travel_itineraries
  end

  resources :expense_others do
    resources :expense_types
  end
  resources :statuses do
    resources :reimbursement_requests
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  #makes expense_types root
  root 'home#index'

  get 'states/:country', to: 'application#states'
  get 'cities/:state/:country', to: 'application#cities'


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
