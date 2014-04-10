class DashboardController < ApplicationController
  rescue_from OAuth2::Error, with: :reauthenticate

  class AnnotatedEventList
    def self.build(events, annotations)
      sorted_event_list(events).collect do |e|
        {
          event: e,
          annotation: annotation_for(e, annotations)
        }
      end
    end

    def self.sorted_event_list(events)
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

    def self.annotation_for(event, annotations)
      annotations.find { |a| a.event_id == event['id'] } || Annotation.new(event_id: event['id'])
    end
  end

  def index
    @events = calendar_accessor.calendar_list(Date.today)
  end

  def calendar
    redirect_to day_path(date: Date.today.strftime("%Y-%m-%d"))
  end

  def day
    @day = Date.parse(params[:date])
    event_list = calendar_accessor.event_list(params[:id], @day)
    annotations = current_user.annotations.where(
      event_id: event_list['items'].collect { |i| i['id'] }
    )
    @event_list = AnnotatedEventList.build(event_list['items'], annotations)
  end

  protected
    def calendar_accessor
      @calendar_accessor ||= CalendarAccessor.new(current_user.access_token)
    end

    def reauthenticate
      sign_out_all_scopes
      redirect_to request.original_url
    end
end
