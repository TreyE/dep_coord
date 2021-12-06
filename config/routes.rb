Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :projects, only: [:index]
  resources :branch_version_records, only: [:show]

  root "projects#index"
end
