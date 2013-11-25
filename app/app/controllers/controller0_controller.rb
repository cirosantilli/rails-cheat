class Controller0Controller < ApplicationController
  def action0

    ##blank

      # Implemeted by Rails for all objects.
      # Difference from `empty`: works on all objects, including `nil`
      # while empty throws a NoMethodError for nil.

        nil.blank? == true or raise()

    ##pass variables to templates

      # Variables defined here will become available
      # for the template that will use this view.

        @var0 = 0
        @var1 = 1

    ##db functions

      ##find

          @model0s = Model0.all

      ##save

        # Saves a model instance to the database.

          #@model0 = Model0.new(model0_params)
          #@model0.save

    ##actions

      ##render

        # Return an HTTP 200 OK response whose body is given by the template with the same name
        # as the current method.

          #render

        # Exists this method afterwards.

        # This is the default action that happens if the end of this method is reached.

        # Use body from template of action `new`:

          #render action: 'new'

        # Give the body on a string without any template files:

          #render text: '<h1>text</h1>'

        # Give the body on a string. Pass it through erb before returning:

          #render text: '<h1><%= 1 %></h1>'

      ##redirect_to

        # Return an http redirect to another address.

          #redirect_to :action => 'list'

      ##respond_to

        # Allows to generate different formats of response depending on the `Accept-Type` HTTP header of the request.

        # If the there is no format for the incomming `Accept-Type`, an error occurs.

        # Well explained in the docs: <http://api.rubyonrails.org/classes/ActionController/MimeResponds.html#method-i-respond_to>

        # Exaple from the docs:

          #respond_to do |format|
            #format.html { redirect_to(person_list_url) }
            #format.js
            #format.xml  { render xml: @person.to_xml(include: @company) }
          #end

    ##cookies

      # Expires when browser is closed:

        if not cookies.has_key?(:browser_close)
          cookies[:expire_browser_close] = "0"
        else
          cookies[:expire_browser_close] = (cookies[:expire_browser_close].to_i + 1).to_s
        end

        if not cookies.has_key?(:expire_three_secs)
          cookies[:expire_three_secs] = "0"
        else
          cookies[:expire_three_secs] = {
            value: (cookies[:expire_three_secs].to_i + 1).to_s,
            expires: 3.seconds.from_now
          }
        end

      # Expires in maximum possible time (20 years):

        cookies.permanent[:permanent] = "0"

      # Assign an array of values to a cookie.

        cookies[:array] = [0, 1]

    ##flash

      # Standard method of giving user notifications.

      # Useful specially for messages generated in one action that must cross redirection.

      # Rendered on templates as functions `notice` and `alert`, typically on the layout.

      # Flash only for current page:

        flash.now[:notice] = "notice0"
        flash.now[:alert] = "alert0"

      # Flash from now until the next page or redirection:

        #flash[:notice] = "notice0"
        #flash[:alert] = "alert0"
        #
        #redirect_to root_url
        #redirect_to root_url

      # Flash now overrides it a flash.

      # Shorter version

        #redirect_to root_url,
          #notice: "You have successfully logged out.",
          #alert: "You're stuck here!"

    ##logger

        Rails.logger.info('controller0 log test')
  end

  def redirect_to_action0
    redirect_to action: "action0",
      notice: "notice redirect",
      alert: "alert redirect"
  end

  def ajax_test
    render text: Time.new.to_s
  end

  def action1
  end

  ##routes

      def url_params
      end

      def url_params_abc
          render action: 'url_params'
      end

      def url_params_keyval
          render action: 'url_params'
      end

  # Typcial CRUD actions:

    def index
      @model0s = Model0.all
    end

    # Detail on on one item.
    def show
        @model0 = Model0.find(params[:id])
    end

    # GET action that shows the creation form.
    # The POST is treated by `create`
    def new
        @model0 = Model0.new
        @model1s = Model1.all
    end

    # POST action that will actually create the new model
    # The initial  GET is typically generated by the `new` method.
    def create
      @model0 = Model0.new(model0_params)
      if @model0.save
        redirect_to action: 'index'
      else
        @model1s = Model1.all
        render action: 'new'
      end
    end

    def edit
        @model0 = Model0.find(params[:id])
        @model1s = Model1.all
    end

    def update
        @model0 = Model0.find(params[:id])
        if @model0.update_attributes(model0_params)
          redirect_to action: 'show', id: @model0
        else
          @model1s = Model1.all
          render action: 'edit'
        end
    end

    def destroy
        Model0.find(params[:id]).destroy
        redirect_to action: 'index'
    end

  ##before_filter

    # Action taken before doing any action.

    # Can for example redirect user to another page.

      before_filter :before_filter_do, unless: :before_filter_dont

      # Things you can do here:
      #
      # - pass variables to template
      # - redirect_to somewhere.
      #
      def before_filter_do
        @before_filter_do = 1
      end

      # If this is true, `before_filter_do` will not be run.
      #
      def before_filter_dont
        false
      end

  ##i18n

      before_action :set_locale

      def set_locale
        I18n.locale = params[:locale] || I18n.default_locale
      end

  def mail
      MyMailer.email0(params[:user][:address]).deliver
      ActionMailer::Base.mail(
        to: params[:user][:address],
        from: 'ror-cheat',
        subject: 'string body',
        content_type: "text/html",
        body: 'the body is a string',
      ).deliver
      redirect_to action: 'action0'
  end

  ##layout

    # Set layout for entire controller:

      #layout 'standard'

  ##devise

    # This redirects unauthenticated users to the login:

        #before_filter :authenticate_user!

  private

    # This determines which parameters can be sent through POST methods.
    # It is mandatory to whitelist possible parameters or they won't work.
    # Otherwise, end users could do naughty things like attempt to set an ID.
    def model0_params
      params.require(:model0).permit(:string_col, :integer_col, :model1_id)
    end
end
