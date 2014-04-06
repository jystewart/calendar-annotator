class DashboardController < ApplicationController
	def index
		abc = CalendarAccessor.new(current_user.access_token)
		@events = abc.event_list(Date.today)
	rescue OAuth2::Error
		@events = "NO PERMISSION"
	end
end
