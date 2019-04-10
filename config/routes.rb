Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get("/", {to: "home#index", as: "root"})
  get("/about", {to: "home#about"})
  get("/contact_us", {to: "contact#new"})
  post("/contact_us/create", {to: "contact#create"})
  # new products route
  get("/products/new", {to: "products#new", as: :new_product})
  post("/products", {to: "products#create"})
  get("/products/:id", {to: "products#show", as: :product})
  get("/products", {to: "products#index", as: :index})
  delete('/products/:id', to: 'products#destroy')
  get("products/:id/edit",{to: "products#edit",as: :product_edit})
  patch("/products/:id", to: "products#update")
end
