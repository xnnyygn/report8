module RecentReports extend ActiveSupport::Concern

	private

		def set_recent_reports(user = nil)
			user ||= @current_user
			if user
				@recent_reports = Report.where(author: user).order(updated_at: :desc).limit(5)
			end
		end

end