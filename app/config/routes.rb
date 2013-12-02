App::Application.routes.draw do

  # Link urls to actions.

  # The priority is based upon order of creation: first created -> highest priority.

  # See how all your routes lay out with "rake routes".

  ##scope

    # Everything inside the scope do end block gets the scope url prefix.

    # Can also set the controller for all routes inside the scope.

  ##namespace

    #TODO vs scope

  ##get

    # GET requests only.

      #get "url" => 'controller#action'

      #scope "prefix", controller: :controller, id: /[^\/]/ do
        #get "url/:id" => :action
      #end

    # Optional part:

      #get "url(/something)" => 'controller#action'

  ##post

    # POST requests only.

  ##i18n optional locale prefix.

  scope "(:locale)", locale: /en|zh/ do

    ##root

      # Set the website root.

          root 'controller0#action0'

      # If inside a namespace, sets the root for the namespace.

          #namespace :admin do
            #root to: "admin#index"
          #end

    scope "controller0", controller: :controller0 do

          get "" => :action0
          get "action0" => :action0
          get "redirect-to-action0" => :redirect_to_action0
          get "ajax-test" => :ajax_test
          get "action1" => :action1
          post "mail" => :mail

      ## URL params

          get "url_params_keyval" => :url_params_keyval
          get "url_params/:id" => :url_params
          get "url_params_abc/:id" => :url_params_abc, id: /[abc]+/

      ##resource ##CRUD

        scope "model0" do
          get "" => :index
          get "new" => :new
          post "" => :create
          get ":id" => :show
          get ":id/edit" => :edit
          put ":id" => :update
          delete ":id" => :destroy
        end

        # TODO Automatically generate exactly all above 7 CRUD operations:
        #resource :controller0, path: 'model0'

        # Generate only some of the above actions
        #resources :controller0, only: [:index, :show]

      ##file upload

        scope "file_upload", id: /[^\/]+/ do
          get "" => :file_upload
          post "" => :do_file_upload
          get ":id" => :file_download
          delete ":id" => :file_delete
        end

      ##haml

          get "haml" => :haml

    end
  end

  ##devise

    # Cannot be inside a scope. TODO workaround.

    # - model: which model defies the user.
    # - path: login path relative to root. Default: `users`

      devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }
      resources :users, :only => [:index, :show]
      #devise_for :users, path: "auth"

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
