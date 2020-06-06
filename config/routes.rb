Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :players, only: %i[index create show]

  resources :series, only: %i[show create index update destroy] do
  	resources :games, only: %i[create index update]
  end
end
