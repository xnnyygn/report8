class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :set_current_user
  before_action :authorize
  before_action :set_locale_from_user_settings

  protected
  	def authorize
      unless @current_user
  			redirect_to login_url
  		end
  	end

    def set_current_user
      id = session[:user_id]
      begin
        @current_user = User.find(id) if id
      rescue ActiveRecord::RecordNotFound
        logout
      end
    end

    def logout
      session.delete :user_id
    end
    
    def set_locale_from_user_settings
      I18n.locale = I18n.default_locale
      if @current_user
        lang = @current_user.interface_language
        if I18n.available_locales.map(&:to_s).include? lang
          I18n.locale = lang
        end
      end
    end

end
