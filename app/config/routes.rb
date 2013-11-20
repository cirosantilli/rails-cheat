App::Application.routes.draw do

  ##root

      root 'controller0#action0'

  # Link urls to actions.

  ##get

    # GET requests only.

  ##post

    # POST requests only.

      get "controller0" => "controller0#action0"
      get "controller0/action0" => "controller0#action0"
      get "controller0/redirect_to_action0" => "controller0#redirect_to_action0"
      get "controller0/ajax_test" => "controller0#ajax_test"
      get "controller0/action1" => "controller0#action1"
      get "controller0/list" => "controller0#list"
      get "controller0/new" => "controller0#new"
      post "controller0/create" => "controller0#create"
      get "controller0/show" => "controller0#show"
      get "controller0/edit" => "controller0#edit"
      post "controller0/update" => "controller0#update"
      get "controller0/delete" => "controller0#delete"
      post "controller0/mail" => "controller0#mail"

  ##devise_for

    # - model: which model defies the user.
    # - path: login path relative to root. Default: `users`

      devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
      #devise_for :users, path: "auth"

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end
  
  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
