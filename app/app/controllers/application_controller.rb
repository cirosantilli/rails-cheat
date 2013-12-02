# This is the base class of every controller.
#
# This class is therefore useful to share things amongst multiple controllers
# for example `before_action`.
#
class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  add_breadcrumb "home", :root_path

  ##i18n

      before_action :set_locale

      def set_locale
        # Set the actual locale based on parsed params.
        I18n.locale = params[:locale] || I18n.default_locale

        # link_to links will keep current locale.
        if params.has_key? :locale
          Rails.application.routes.default_url_options[:locale] = I18n.locale 
        else
          Rails.application.routes.default_url_options.delete(:locale)
        end
      end
end
