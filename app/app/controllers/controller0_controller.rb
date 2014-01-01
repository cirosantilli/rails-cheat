class Controller0Controller < ApplicationController

  def action0

    ##blank

      # Implemeted by Rails for all objects.
      # Difference from `empty`: works on all objects, including `nil`
      # while empty throws a NoMethodError for nil.

        nil.blank? == true or raise

    ##pass variables to templates

      # Variables defined here will become available
      # for the template that will use this view.

        @var0 = 0
        @var1 = 1
        @model0s = Model0.all

    ##active record methods

      # You should understand at least one SQL language like MySQL before using this.

      ##to_sql

        # Shows what the SQL query will look like.

          puts "===================="
          puts Model0.where(id: [1, 2]).order(:id).to_sql

        # Note how queries are lazy evaluated: the following produces the same as the above:

          q = Model0.where(id: [1, 2])
          puts q.order(:id).to_sql

      ##find

        # Retreive a single item by its primary ID.

      ##take ##limit

        # SELECT * FROM table LIMIT N

        # Default is `N = 1`.

        # `nil` if non found.

      ##find_by

        # Same as `where.take`

          Model0.find_by(id: 1).string_col == 's1' or raise
          Model0.find_by(id: 1, string_col: 's1').string_col == 's1' or raise

        # Helper find_by_FIELD methods are automatically defined for each table field:

          Model0.find_by_id(1).string_col == 's1' or raise
          Model0.find_by_string_col('s1').id == 1 or raise

        # Redudant with find_by, so never use to avoid confusion.

      ##where

        # Returns an array like object of rows matching a criteria.

        # Even if here is a single matching object, it is still array like,
        # so you still need to use the `[]`.

        # There are many forms of using `where`.

        # String:

          Model0.where("id = 1 AND string_col = 's1'")[0].string_col == 's1' or raise
          Model0.where("id = 1 OR id = 2").order(:id).pluck(:string_col) == ['s1', 's2'] or raise

        # Array:

          Model0.where(["id = ? ", 1])[0].string_col == 's1' or raise
          Model0.where(["id = :id", {id: 1}])[0].string_col == 's1' or raise

        # Hash:

          Model0.where({id: 1})[0].string_col == 's1' or raise
          Model0.where({id: [1, 2]}).order(:id).pluck(:string_col) == ['s1', 's2'] or raise

        # Error:

          #Model0.where(id: 1).string_col == 's1' or raise

        # If you are only interested in a single object, consider using `find_by`.

        ##or query

          # While it is possible to do an `AND` query without using the messy string method
          # by using the hash signature,
          # it is seems that it is not possible to do `OR` queries across multiple columns without plugins
          # and without a string query: <http://stackoverflow.com/questions/3639656/activerecord-or-query>
          #
          # It is possible on a single colum via the hash array construct: `{id: [1, 2]}`.

      ##all

          @model0s = Model0.all

      ##create

        # Unlike new, immediately creates the element on the database.

      ##save

        # Saves a model instance to the database, usually one that was created with new.

          #@model0 = Model0.new(model0_params)
          #@model0.save

      ##save! vs save

        # `save!` does validations, `save` does not.

      ##count

          #Model0.count
          #Model0.all.count

      ##order

          #Model0.order(:id)
          #Model0.order(id: :asc)
          #Model0.order(id: :desc)

      ##limit ##offset

        # Pagination friends.

          #Model0.all.limit(5).offset(10)

      ##pluck

        #   Person.pluck(:name)
        #
        # is the same as:
        #
        #   Person.all.map(&:name)
        #
        # except that the first may be faster as it only fetches
        # required rows from the server.
        #
        # Example:
        #
        #   Person.pluck(:id)
        #   # SELECT people.id FROM people
        #   # => [1, 2, 3]
        #
        # Multi row example:
        #
        #   Person.pluck(:id, :name)
        #   # SELECT people.id, people.name FROM people
        #   # => [[1, 'David'], [2, 'Jeremy'], [3, 'Jose']]

      ##associations

        # <http://guides.rubyonrails.org/association_basics.html>

        ##belongs_to

          # `belogs_to :model1` in Model0, gives it the `model1` method:

            Model0.find_by(string_col: 's1').model1.string_col == 't1' or raise

          # `has_many :model0s` gives the `model0s` method to `Model1`:

            Model1.find_by(string_col: 't1').model0s.take.string_col == 's1' or raise

      ##joins

        # Does SQL joins on data.

        # Requires that the table rows be associated via `belongs_to` family methods.

          Model0.joins(:model1).find_by(model1s: {string_col: 't1'}).string_col == 's1' or raise
          #                                                          ^
          #                                                          This is the Model0 string_col.

          Model1.joins(:model0s).find_by(model0s: {string_col: 's1'}).string_col == 't1' or raise
          #                                                          ^
          #                                                          This is the Model1 string_col.

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

        # Render and/or redirect can only be called once on the controller. Error:

          #render
          #render

        # Only variables defined before the render / redirect are visible on the template.

          @arr = [0]
          render
          @arr == [1] or raise
          @after_render = 1

      ##redirect_to

        # Return an http redirect to another address.

          #redirect_to :action => 'list'

        # Return to the last page:

          #redirect_to(:back)

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
        flash.now[:something] = "something0"

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

    ##breadcrumbs_on_rails

        add_breadcrumb "action0", action0_path

    ##response

      # The counterpart of the request object.

      # Checks and possibly modifies the current state of the response.

      # Unlike the request, the response should almost never be used.

    ##before_filter

        @before_filter_do == 1 or raise

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

  ##file upload

      def file_upload
        @uploaded_files = Dir.entries(File.join(upload_dir)).map{|x| File.basename(x)}.delete_if{|x| x == '.' or x == '..'}
        @upload_total = UploadTotal.take.upload_total
      end

      def upload_dir
        Rails.root.join('public', 'uploads')
      end

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

      def file_download
        send_file File.join(upload_dir, params[:id])
      end

  ##devise

    # This redirects any unauthenticated users to the login:

        #before_filter :authenticate_user!

    # If not present, login is not mandatory.

  ##haml

      def haml
        @a = 1
      end

  private

    # This determines which parameters can be sent through POST methods.
    # It is mandatory to whitelist possible parameters or they won't work.
    # Otherwise, end users could do naughty things like attempt to set an ID.
    #
    def model0_params
      params.require(:model0).permit(:string_col, :integer_col, :model1_id)
    end
end
