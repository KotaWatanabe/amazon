Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get("/", {to: "home#index", as: "root"})
  get("/about", {to: "home#about"})
  get("/contact_us", {to: "contact#new"})
  post("/contact_us/create", {to: "contact#create"})
  get("/admin/panel", {to: "admin#index"})

  resources :news_articles, only:[:new,:create,:show,:index,:destroy,:edit]

  # User route
  resources :users, only:[:new, :create]

  # Session route
  resource :session, only:[:new, :create, :destroy]

  # new products route
  resources :products do
  resources :reviews, only: [:create, :destroy]
  end
  # get("/products/new", {to: "products#new", as: :new_product})
  # post("/products", {to: "products#create"})
  # get("/products/:id", {to: "products#show", as: :product})
  # get("/products", {to: "products#index", as: :index})
  # delete('/products/:id', to: 'products#destroy')
  # get("products/:id/edit",{to: "products#edit",as: :product_edit})
  # patch("/products/:id", to: "products#update")

  
end
