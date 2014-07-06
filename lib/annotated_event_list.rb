require 'time'

class AnnotatedEventList
  include Enumerable

  def initialize(events, annotations)
    events_to_attend = filtered_event_list(events)
    sorted_events = sorted_event_list(events_to_attend)
    @event_list = sorted_events.collect do |e|
      {
        event: e,
        annotation: annotation_for(e, annotations)
      }
    end
  end

  def [](index)
    @event_list[index]
  end

  def each &block
    @event_list.each do |event|
      if block_given?
        block.call(event)
      else
        yield event
      end
    end
  end

  private
  def filtered_event_list(events)
    events.reject { |e| e['status'] == 'cancelled' || not_attending(e) || duplicate_recurring_event(e) }
  end

  # For some reason the google calendar API is returning duplicate events twice, once with an ID
  # unique to the occurrence of the event and once with a generic ID. This logic is my current
  # best effort to identify those and just keep those with unique IDs as they're better for
  # annotating.
  def duplicate_recurring_event(event)
    (event['recurringEventId'].present? && event['id'] == event['recurringEventId']) ||
      (event['recurringEventId'].blank? && event['recurrence'].present?)
  end

  def not_attending(event)
    if event['attendees']
      event['attendees'].detect { |a| a['self'] && a['responseStatus'] == 'declined' }
    else
      false
    end
  end

  def sorted_event_list(events)
    events.sort_by do |i|
      if i['start'].nil?
        Time.parse '1970-01-01'
      elsif i['start']['date']
        Time.parse i['start']['date']
      elsif ! i['start']['dateTime'].nil?
        Time.parse i['start']['dateTime'].gsub(/^\d{4}-\d{2}-\d{2}T/, "")
      end
    end
  end

  def annotation_for(event, annotations)
    annotations.find { |a| a.event_id == event['id'] } || Annotation.new(event_id: event['id'])
  end
end