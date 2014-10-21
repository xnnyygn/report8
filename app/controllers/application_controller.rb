class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authorize

  protected
  	def authorize
      user_id = session[:user_id]
  		@user = User.find(user_id) if user_id

      unless @user
  			redirect_to login_url
  		end
  	end
  	
    def logged_in?
      session[:user_id].present?
    end

    helper_method :logged_in?
    
end
