Rails.application.routes.draw do
  root to: 'home#index'
  get "*path", to: "home#index", constraints: { format: "html" }

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
