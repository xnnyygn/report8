class UserController < ApplicationController
	include RecentReports

	skip_before_action :authorize, only: [:profile]

  def profile
  	@user = User.find(params[:id])
  	set_recent_reports(@user)
  rescue => e
  	# user not found
  	redirect_to root_path
  end

  def settings
  end

end
