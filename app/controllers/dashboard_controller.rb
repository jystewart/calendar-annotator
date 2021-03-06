require 'annotated_event_list'
require 'calendar_accessor'

class DashboardController < ApplicationController
  rescue_from OAuth2::Error, with: :reauthenticate

  def index
    @calendars = calendar_accessor.calendar_list(Date.today)
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
    @event_list = AnnotatedEventList.new(event_list['items'], annotations)
  end

  protected
    def calendar_accessor
      @calendar_accessor ||= CalendarAccessor.new(current_user.access_token, Rails.application.secrets)
    end

    def reauthenticate
      sign_out_all_scopes
      flash[:notice] = "There was a problem with your google account. Please sign in again."
      redirect_to request.original_url
    end
end
