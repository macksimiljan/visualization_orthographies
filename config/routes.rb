Rails.application.routes.draw do

  get 'dashboard/index'

  resources :coptic_sublemmas, only: %i[index show]
  resources :greek_lemmas, only: %i[index show]
  resources :orthographies, only: %i[index show]
  resources :sources, only: %i[index show]


  root 'dashboard#index'

end
