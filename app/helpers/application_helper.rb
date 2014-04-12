module ApplicationHelper
  def display_start_time(item)
    if item['start']['dateTime']
      DateTime.parse(item['start']['dateTime']).strftime("%k:%M")
    else
      "All day"
    end
  end

  def display_oauth_error
    if flash[:alert] && flash[:alert] =~ /Could not authenticate you from GoogleOauth2/
      content_tag(:p, "You really will need to sign in to google to continue.")
    end
  end
end
