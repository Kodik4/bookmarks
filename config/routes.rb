Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'bookmarks#index'
  
  resources :bookmarks, only: %i[index create destroy]
  resources :domains, only: %i[show]
end
