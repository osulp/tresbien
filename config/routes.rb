
# frozen_string_literal: true

Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }
  resources :users
  resources :reimbursement_requests do
    post 'comment', to: 'reimbursement_requests#comment'
    delete 'comment/:id/delete', to: 'reimbursement_requests#delete_comment', as: 'comment_delete'
  end

  resources :expense_others do
    resources :expense_types
  end
  resources :statuses do
    resources :reimbursement_requests
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # makes expense_types root
  root 'home#index'

  patch 'reimbursement_requests/:id/approve', to: 'reimbursement_requests#approve', as: 'approve_reimbursement_request' 
  patch 'reimbursement_requests/:id/decline', to: 'reimbursement_requests#decline', as: 'decline_reimbursement_request' 

  get 'states/:country', to: 'application#states'
  get 'cities/:state/:country', to: 'application#cities'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
