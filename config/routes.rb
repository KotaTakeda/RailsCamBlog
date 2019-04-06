Rails.application.routes.draw do
  get 'staticpages/top'
  devise_for :users
  root 'staticpages#top'
  devise_scope :user do
    get "user/:id", :to => "users/registrations#detail"
    get "signup", :to => "users/registrations#new"
    get "login", :to => "users/sessions#new"
    get "logout", :to => "users/sessions#destroy"
  end
  resources :articles
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
