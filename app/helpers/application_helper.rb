module ApplicationHelper
  def display_start_time(item)
    if item['start']['dateTime']
      DateTime.parse(item['start']['dateTime']).strftime("%k:%M")
    else
      "All day"
    end
  end
end
