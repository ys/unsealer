Rails.application.routes.draw do
  resource :sessions
  get "/auth/:provider/callback" => "sessions#create"
  root "unsealer#index"
end
