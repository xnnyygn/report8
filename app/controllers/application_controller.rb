class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authorize

  protected
  	def authorize
  		user_id = session[:user_id]
  		unless user_id and User.find(user_id)
  			redirect_to login_url
  		end
  	end
  	
end
