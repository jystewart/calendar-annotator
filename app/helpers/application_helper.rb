module ApplicationHelper
  def display_start_time(item)
    DateTime.parse(item['start']['dateTime']).strftime("%k:%M")
  end
end
