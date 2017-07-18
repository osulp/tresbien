
Rails.application.routes.draw do

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }
  resources :users
  resources :reimbursement_requests do
    resources :travel_itineraries
  end
<<<<<<< 3f17f3ee03611436545f149ab7e55b66d8f8480a
  resources :statuses do
    resources :reimbursement_requests
  end
=======

>>>>>>> Allows multiple files upload
  resources :city_state

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  #makes expense_types root
  root 'home#index'

  get 'states/:country', to: 'application#states'
  get 'cities/:state', to: 'application#cities'


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
