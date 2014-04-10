class DashboardController < ApplicationController
  def index
    @events = calendar_accessor.calendar_list(Date.today)
  end

  def calendar
    redirect_to day_path(date: Date.today.strftime("%Y-%m-%d"))
  end

  def day
    @event_list = calendar_accessor.event_list(params[:id], Date.parse(params[:date]))
  end

  protected
    def calendar_accessor
      @calendar_accessor ||= CalendarAccessor.new(current_user.access_token)
    end
end
