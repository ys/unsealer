Rails.application.routes.draw do
  resource :sessions
  resource :unsealers
  get "/auth/:provider/callback" => "sessions#create"
  root "unsealers#index"
end
