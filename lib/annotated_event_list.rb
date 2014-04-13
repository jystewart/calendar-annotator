require 'time'

class AnnotatedEventList
  include Enumerable

  def initialize(events, annotations)
    events_happening = events.reject { |e| e['status'] == 'cancelled' }
    sorted_events = sorted_event_list(events_happening)
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