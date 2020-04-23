Rails.application.routes.draw do
  resources :books, expect: [:new]
  root to: "books#top"
end
