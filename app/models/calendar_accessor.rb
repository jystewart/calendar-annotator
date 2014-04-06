require 'oauth2'

class CalendarAccessor
	def initialize(auth_token)
		client = OAuth2::Client.new(ENV['GOOGLE_CLIENT_ID'], ENV['GOOGLE_CLIENT_SECRET'], :site => 'https://www.googleapis.com')
		@token = OAuth2::AccessToken.new(client, auth_token)
	end

	def event_list(date)
		list = @token.get("/calendar/v3/users/me/calendarList")
		return JSON.parse(list.body)
	end
end