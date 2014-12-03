App::Application.routes.draw do

  # Determines:
  #
  # - which URL will be treated by which action, method of a `module::controller#action`.
  # - the name of named URL helpers

  # The priority is based upon order of creation: first created -> highest priority.

  # See how all your routes layout:
  #
  #     rake routes
  #
  # The output is of form:

    #contexts    GET    /contexts(.:format)           {:action=>"index", :controller=>"blog/contexts"}
    #            POST   /contexts(.:format)           {:action=>"create", :controller=>"blog/contexts"}
    #new_context GET    /contexts/new(.:format)       {:action=>"new", :controller=>"blog/contexts"}

  ##scope

    # Every URL route in the `do end` will get the given prefix.
    #
    # No other side effect happens without extra options:
    #
    # - the controller is not put inside a module
    # - the names URL helpers are not prefixd by the scope
    #
    # Using options, it is also possible to set:
    #
    # - controller
    # - module
    # - module of the controllers
    #
    # But you are likely better off doing that with `namespace` which is DRYer.

  ##namespace

    # Shortcut for scope that also adds `as` and `module` options.
    # http://stackoverflow.com/questions/3029954/difference-between-scope-and-namespace-of-ruby-on-rails-3-routing

      namespace :namespace0 do
        get 'action0' => 'controller0#action0'
        root to: 'controller0#action0'
      end

    # Is the same as:

      #scope '/namespace0', as: 'namespace0', module: 'namespace0' do
      #end

  ##get

    # GET requests only.

      #get 'url' => 'controller#action'

      #scope 'prefix', controller: :controller, id: /[^\/]/ do
        #get 'url/:id' => :action
      #end

    # Optional part:

      #get 'url(/something)' => 'controller#action'

  ##post

    # POST requests only.

  ##i18n optional locale prefix.

  scope '(:locale)', constraints: {locale: /en|zh/}, defaults: {locale: 'en'} do

    ##root

      # Set the website root.

          root 'controller0#action0'

      # If inside a namespace, sets the root for the namespace only:

          #namespace :admin do
            #root to: 'admin#index'
          #end

    ##Name path helpers

    ##as

        get 'no_as' => 'controller0#action0'
        get 'slash/no_as' => 'controller0#action0'

        scope 'no_as_scope', controller: 'controller0' do
          get 'in_no_as_scope' => 'action0'
        end

        scope 'as_scope', as: 'as_scope' do
          get 'in_as_scope' => 'controller0#action0'
        end

    scope 'controller0', controller: :controller0 do

          get '' => :action0
          post '' => :post, as: :post
          get 'action0' => :action0
          get 'redirect-to-action0' => :redirect_to_action0
          get 'ajax' => :ajax
          get 'action1' => :action1
          post 'mail' => :mail

      ## URL params

          get 'url_params_keyval' => :url_params_keyval
          get 'url_params/:id' => :url_params
          get 'url_params_abc/:id' => :url_params_abc, id: /[abc]+/

      ##resources ##CRUD

        # Automatically create all CRUD URLs at once

          resources :model0s, controller: :controller0 do

        # Same as:

          #scope 'model0' do
            #get '' => :index
            #get 'new' => :new
            #post '' => :create
            #get ':id' => :show
            #get ':id/edit' => :edit
            #put ':id' => :update
            #delete ':id' => :destroy

          ##member

            # Add member actions to the current resource

            # This example would recognize an URL of type `model0/:id/preview`
            # And redirect it to the `preview` action in current controller.

              #member do
                #get 'preview'
              #end

            # Generated helpers of form `preview_model0_path`. Weirdly, model0 comes after,
            # so it sounds like English, but is insane.

            # Method `preview` must be in the same class as the parent resource: Model0Controller.
        end

        # TODO Automatically generate exactly all above 7 CRUD operations:
        #resource :controller0, path: 'model0'

        # Generate only some of the above actions
        #resources :controller0, only: [:index, :show]

        ##_index helpers

          # If a singular name is usde like: `:model0`,
          # then the helper path for index gets `_index` appended to it:

          # <http://stackoverflow.com/questions/6476763/rails-3-route-appends-index-to-route-name>

      ##Singular resources

      ##resource

        # Different from `resources` with `s`!

        # Shortcut for resources like profile, for which there is no index.

      ##file upload

        scope 'file_upload', id: /[^\/]+/ do
          get '' => :file_upload
          post '' => :do_file_upload
          get ':id' => :file_download
          delete ':id' => :file_delete
        end
    end
  end

  get 'controller1' => 'controller1#action0'
  get 'controller1/action0' => 'controller1#action0'

  ##third party

    # The following URLs exist for the test of third party tools:

      get 'capybara' => 'controller0#capybara'
      get 'haml' => 'controller0#haml'
      get 'view_tests' => 'controller0#view_tests'
      get 'rspec' => 'controller0#rspec'

  ##devise

    # Cannot be inside a scope. TODO workaround.

    # - model: which model defies the user.
    # - path: login path relative to root. Default: `users`

      devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
      resources :users, :only => [:index, :show]
      #devise_for :users, path: 'auth'

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
