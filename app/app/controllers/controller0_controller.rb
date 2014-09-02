class Controller0Controller < ApplicationController
  include Concern0

  def action0

    ##pass variables to templates

      # Variables defined here will become available
      # for the template that will use this view.

        @var0 = 0
        @var1 = 1
        @model0s = Model0.all

    ##actions

      ##render

        # Best doc I can find:
        # http://api.rubyonrails.org/v4.1.1/classes/ActionController/Base.html
        #
        # Prepares an HTTP response:
        #
        # - 200 OK status
        # - response whose body is given by the layout with the same basename
        #     without dots (.html.erb) as the current method, e.g. views/controller0/action0.(html|html.erb|html.haml|js)
        #     TODO what if there are multiple? Resolved by respond_to? What about Content-Type response header?
        #

          #render

        # Calling render twice gives an error.

        # Does not automatically exit the method. To do that, the common patter is `and return`:

          #render :show and return

        # This is the default action that happens if the end of this method is reached.

        # Use body from template of action `new`:

          #render action: 'new'

        # Give the body on a string without any template files:

          #render text: '<h1>text</h1>'

        # Give the body on a string. Pass it through erb before returning:

          #render text: '<h1><%= 1 %></h1>'

        # Render and/or redirect can only be called once on the controller. Error:

          #render
          #render

        # Only variables defined before the render / redirect are visible on the template.

          @arr = [0]
          render
          @arr == [1] or raise
          @after_render = 1

        # Response status:

          #render file: Rails.root.join('public', '404'), layout: false, status: '404'

        # Empty body:

          #render nothing: true, status: '404'

        # It is however recommended that you use the `head` method instead on this case for a header only response.

          #head :forbidden

      ##redirect_to

        # Return an HTTP 302 redirect to another address with an automatically generated appropriate body:

          #redirect_to action: 'list'

        # Return to the last page specified by the HTTP `Referer` header:

          #redirect_to(:back)

        # Should not be reliable since that header is optional and may be disabled by users:
        # http://stackoverflow.com/questions/6023941/how-reliable-is-http-referer

        # Possible to specify other redirect statuses with `status: `. Must of course be a 3XX status.

      ##respond_to

        # Allows to generate different formats of response depending on the `Accept-Type` HTTP header of the request.

        # If the there is no format for the incomming `Accept-Type`, an error occurs.

        # Well explained in the docs: <http://api.rubyonrails.org/classes/ActionController/MimeResponds.html#method-i-respond_to>

        # Exaple from the docs:
        # the typical way to make `format.js` AJAX calls is via `link_to` with `remote: true`.

          #respond_to do |format|
            #format.html { redirect_to(person_list_url) }

            #format.js   { render text: 'AJAX response!' }

            # If no callback given, render the layout with respective extension `controller/action.js`:
            #format.js

            #format.xml  { render xml: @person.to_xml(include: @company) }
          #end

    ##helpers

      # Sanitize:

        ActionController::Base.helpers.strip_tags('<p data-key="val">a<p>b</p>c</p>') == 'abc' or raise

    ##cookies

      # Expires when browser is closed:

        if not cookies.has_key?(:browser_close)
          cookies[:expire_browser_close] = '0'
        else
          cookies[:expire_browser_close] = (cookies[:expire_browser_close].to_i + 1).to_s
        end

        if not cookies.has_key?(:expire_three_secs)
          cookies[:expire_three_secs] = '0'
        else
          cookies[:expire_three_secs] = {
            value: (cookies[:expire_three_secs].to_i + 1).to_s,
            expires: 3.seconds.from_now
          }
        end

      # Expires in maximum possible time (20 years):

        cookies.permanent[:permanent] = '0'

      # Assign an array of values to a cookie.

        cookies[:array] = [0, 1]

    ##flash

      # Standard method of giving user notifications.

      # Useful specially for messages generated in one action that must cross redirection.

      # Rendered on templates as functions `notice` and `alert`, typically on the layout.

      # Flash only for current page:

        flash.now[:notice] = 'notice0'
        flash.now[:alert] = 'alert0'
        flash.now[:something] = 'something0'

      # Flash from now until the next page or redirection:

        #flash[:notice] = 'notice0'
        #flash[:alert] = 'alert0'
        #
        #redirect_to root_url
        #redirect_to root_url

      # Flash now overrides it a flash.

      # Shorter version

        #redirect_to root_url,
          #notice: 'You have successfully logged out.',
          #alert: 'You're stuck here!'

    ##logger

        Rails.logger.info('controller0 log test')

    ##concern

      # The include automatically exports the `ClassMethods` methods, which is a magic name.

      # *Very* explicit behaviour!

        Controller0Controller.concern0_class_method == 0 or raise

    ##response

      # The counterpart of the request object.

      # Checks and possibly modifies the current state of the response.

      # Unlike the request, the response should almost never be used.

    ##before_filter

        @before_filter_do == 1 or raise

    ##view_context

      # Run thing as they would if you were on a view, for example helpers.

        view_context.controller0_helper == 0 or raise

    ##mokey patches

      # Rails adds many methods to existing Ruby stdlib objects.

      ##hash

          h = {'a' => 1, 'b' => 2}
          h.symbolize_keys == {a:1, b:2} or raise

    ##third party

      ##breadcrumbs_on_rails

          add_breadcrumb 'action0', action0_path

      ##settingslogic

          Settings.group0.s0 == 0 or raise
          Settings['group0']['s0'] == 0 or raise
          Settings.group0.s1 == 1 or raise
          Settings.erb == 2 or raise
          (0 == Settings['not_defined'] || 0) or raise

          # May raise depending on the `suppress_errors` option, so don't rely on it,
          # use the map version instead.
          #Settings.not_defined

          # Give a default value at usage time if value not set.
          (0 == Settings['not_defined'] || 0) or raise

          Settings.not_in_yml == 1 or raise

      ##gon

          gon.key1 = 'val1'
          gon.key2 = 'val2'
  end

  def redirect_to_action0
    redirect_to action: 'action0',
                notice: 'notice redirect',
                alert:  'alert redirect'
  end

  def ajax
    sleep(0.5)
    # If `json` jQuery ajax dataType:
    #render text: '{"date":"' + Time.new.to_s + '"}'
    # If `text` jQuery ajax dataType:
    render text: Time.new.to_s
  end

  def action1
    @var0 = 1
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

  ##CRUD

    # Typcial CRUD actions:

    def index
      @per_page = params.fetch('per_page', 25).to_i
      @page = params.fetch('page', 1).to_i
      pages = Model0.all.order(:id)
      @npages = (pages.count - 1) / @per_page + 1
      @model0s = pages.limit(@per_page).offset(@per_page*(@page-1))
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
        # The form values the user entered will

        # Must be recalculated.
        @model1s = Model1.all

        # No need to return a 422 status if invalid,
        # since that would make no difference to the browser.
        # Use separate URLs for REST APIs.
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

  ##before_filter ##before_action

    # Synonyms. `before_action` was introduced in Rails 4,
    # but before_filter is not yet deprecated as of Rails 4.1.
    #
    # But it may be some day, and `before_action` makes more sense.

    # Action taken before doing any action.

    # To make a fileter for all controllers, place it in `application_controller.rb`,
    # which is the base class of every controller.

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

      def before_filter_skip
        @before_filter_do = 2
      end

      before_filter :before_filter_skip
      skip_before_filter :before_filter_skip

  def mail
    # Mailer method.
    MyMailer.email0(
      params[:mail][:to],
      params[:mail][:from]
    ).deliver

    # Custom email.
    ActionMailer::Base.mail(
      to: params[:mail][:to],
      from: params[:mail][:from],
      subject: 'string body',
      content_type: 'text/html',
      body: 'the body is a string',
    ).deliver
    redirect_to action: 'action0'
  end

  ##layout

    # Set layout for entire controller:

      #layout 'standard'

  ##file upload ##download

      def file_upload
        @uploaded_files = Dir.entries(File.join(upload_dir)).
          map{|x| File.basename(x)}.delete_if{|x| x == '.' or x == '..'}
        @upload_total = UploadTotal.take.upload_total
      end

      def upload_dir
        Rails.root.join('public', 'uploads')
      end

      # Upload a file.
      #
      # Limits both:
      #
      # - the size of individual files
      # - the total upload disk usage
      #
      def do_file_upload
        #TODO deal with .gitkeep
        max_size = 500000
        total_upload_max = 1000000
        file = params[:file]
        file_size = file.size
        if file_size > max_size
          flash[:upload_error] = "Error: File too large. Max size = #{max_size}B. Given size = #{file_size}."
        else
          upload_total = UploadTotal.take
          new_upload_total = upload_total.upload_total + file_size
          if new_upload_total > total_upload_max
            flash[:upload_error] = "Error: Total upload limit reached. Limit = #{total_upload_max}B."
          else
            File.open(File.join(upload_dir, file.original_filename), 'wb') do |f|
              f.write(file.read)
            end
            upload_total.upload_total = new_upload_total
            upload_total.save
          end
        end
        redirect_to :back
      end

      def file_delete
        file_path = File.join(upload_dir, File.basename(params[:id]))
        file_size = File.size(file_path)
        File.unlink(file_path)
        upload_total_row = UploadTotal.take
        upload_total_row.upload_total -= file_size
        upload_total_row.save
        redirect_to :back
      end

      # ##send_file: takes path as input.
      # ##send_data: takes data as input.
      def file_download
        send_file File.join(upload_dir, params[:id])
      end

  ##devise

    # This redirects any unauthenticated users to the login:

        #before_filter :authenticate_user!

    # If not present, login is not mandatory.

  ##third party

    # The following actions exist to test third party tools.

      def haml
        @a = 1
      end

      def capybara
      end

      def view_tests
      end

  private

    # This determines which parameters can be sent through POST methods.
    # It is mandatory to whitelist possible parameters or they won't work.
    # Otherwise, end users could do naughty things like attempt to set an ID.
    #
    # ##require
    #
    # Method added by `ActionController::Parameters`.
    # If parameter is not present, raises.
    # http://stackoverflow.com/questions/18424671/what-is-params-requireperson-permitname-age-doing-in-rails-4
    def model0_params
      # This will allow parameters of type `model0[string_col]`,
      # typically created with `form_for`.
      params.require(:model0).permit(:string_col, :integer_col, :model1_id)
    end
end
