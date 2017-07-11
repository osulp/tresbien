
Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  #makes expense_types root
  root 'expense_types#index'

  get 'states/:country', to: 'application#states'
  get 'cities/:state', to: 'application#cities'

  resources :expense_types
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end