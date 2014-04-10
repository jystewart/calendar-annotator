require 'oauth2'

class CalendarAccessor
  def initialize(auth_token, credential_stash)
    client = OAuth2::Client.new(
      credential_stash.google_client_id,
      credential_stash.google_client_secret,
      site: 'https://www.googleapis.com'
    )
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