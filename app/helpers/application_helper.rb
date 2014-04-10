module ApplicationHelper
  def display_start_time(item)
    DateTime.parse(item['start']['dateTime']).strftime("%k:%M")
  end

  def sorted_item_list(items)
    items.sort_by do |i|
      if i['start'].nil?
        "0"
      elsif ! i['start']['dateTime'].nil?
        i['start']['dateTime']
      else
        "1"
      end
    end
  end
end
