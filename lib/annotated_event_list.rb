class AnnotatedEventList
  include Enumerable

  def initialize(events, annotations)
    @event_list = sorted_event_list(events).collect do |e|
      {
        event: e,
        annotation: annotation_for(e, annotations)
      }
    end
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
        "0"
      elsif ! i['start']['dateTime'].nil?
        i['start']['dateTime']
      else
        "1"
      end
    end
  end

  def annotation_for(event, annotations)
    annotations.find { |a| a.event_id == event['id'] } || Annotation.new(event_id: event['id'])
  end
end