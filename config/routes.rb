Rails.application.routes.draw do

  get 'tree/index'

  get 'dashboard/index'

  get 'basic_statistics/index'
  get 'basic_statistics_frequency/index'

  resources :attestations, only: %i[index show]
  resources :coptic_sublemmas, only: %i[index show]
  resources :greek_lemmas, only: %i[index show]
  resources :morpho_syntaxes, only: %i[index show]
  resources :orthographies, only: %i[index show]
  resources :sources, only: %i[index show]


  root 'dashboard#index'

end
