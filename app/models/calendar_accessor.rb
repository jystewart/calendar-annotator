require 'oauth2'

class CalendarAccessor
	def initialize(auth_token)
		client = OAuth2::Client.new(ENV['GOOGLE_CLIENT_ID'], ENV['GOOGLE_CLIENT_SECRET'], :site => 'https://www.googleapis.com')
		@token = OAuth2::AccessToken.new(client, auth_token)
	end

	def calendar_list(date)
		list = @token.get("/calendar/v3/users/me/calendarList")
		return JSON.parse(list.body)
	end

	def event_list(calendar_id, date = Date.today)
		max_time = URI.escape(date.strftime("%Y-%m-%dT23:59:59Z"))
		min_time = URI.escape(date.strftime("%Y-%m-%dT00:00:00Z"))
		list = @token.get("/calendar/v3/calendars/#{calendar_id}/events?timeMax=#{max_time}&timeMin=#{min_time}")
		return JSON.parse(list.body)
	end
end