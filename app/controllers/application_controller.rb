class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :set_current_user
  before_action :authorize

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
    
end
