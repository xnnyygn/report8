class UserController < ApplicationController
	include RecentReports

	skip_before_action :authorize, only: [:profile, :reports]

  def profile
  	@user = User.find(params[:id])
  	set_recent_reports(@user)
  rescue
  	# user not found
  	redirect_to root_path
  end

  def reports
    @user = User.find(params[:id])
    @reports = Report.where(author: @user).order(updated_at: :desc).page(params[:page]).per(10)
  end

  def settings
  end

  def update_settings
    if @current_user.update(params.require(:user).permit([:interface_language, :introduction]))
      redirect_to user_profile_path(@current_user)
    else
      render :settings
    end
  end

end
