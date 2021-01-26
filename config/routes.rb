Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  scope "(:locale)", locale: /en|vi/ do
    namespace :admin do
      root "adminpages#home"
      resources :users, only: %i(index destroy)
      resources :publishers
      resources :books, only: %i(index new create)
      resources :categories do
        resources :books, except: %i(new create)
      end
      resources :authors
      resources :borrowings, only: %i(update destroy)
    end
    resources :books, only: %i(index show) do
      resources :comments, only: %i(create destroy)
      resources :ratings, only: :create
    end
    resources :borrow_items, only: %i(create index destroy)
    resources :borrowings, only: %i(index create)
    resources :publishers, only: :show

    root "homepages#home"

    get "/login", to: "sessions#new"
    post "/login", to: "sessions#create"
    delete "/logout", to: "sessions#destroy"
    get "/list_append", to: "admin/borrowings#pending"
    get "/list_paying", to: "admin/borrowings#paying"
    get "/search", to: "search#index"
    get "export_csv", to: "admin/export_borrowings#index"
  end
end
