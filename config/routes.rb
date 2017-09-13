Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  post "/email", to: "emails#create"
  get "/curl_example", to: "base_api#thanks"
end
