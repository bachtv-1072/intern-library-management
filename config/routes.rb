Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  scope "(:locale)", locale: /en|vi/ do
    namespace :admin do
      root "adminpages#home"
      resources :users, only: %i(index destroy)
      resources :publishers
      resources :book_details, only: :create
      resources :books, only: %i(index new)
      resources :categories do
<<<<<<< HEAD
        resources :books, except: %i(new create)
=======
        resources :books, except: :new
>>>>>>> 7d6959d (Task 33084)
      end
      resources :authors
    end
    root "homepages#home"

    get "/login", to: "sessions#new"
    post "/login", to: "sessions#create"
    delete "/logout", to: "sessions#destroy"
  end
end
