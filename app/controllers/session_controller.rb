class SessionController < ApplicationController

  skip_before_action :authorize, only: [:new, :create]

  def new
  end

  def create
  	user = User.find_by(name: params[:name])
  	if user and user.authenticate(params[:password])
  		session[:user_id] = user.id
  		redirect_to root_url
  	else
  		redirect_to login_url, alert: 'Incorrect user name and password combination'
  	end
  end

  def destroy
    logout
    redirect_to root_url
  end
  
end
