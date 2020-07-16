Rails.application.routes.draw do
  scope :api do
    resources :players, only: %i[index create show]

    resources :series, only: %i[show create index update destroy] do
    	resources :games, only: %i[create index update]
    end
  end
end
