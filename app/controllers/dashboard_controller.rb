class DashboardController < ApplicationController
  rescue_from OAuth2::Error, with: :reauthenticate

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

    def reauthenticate
      sign_out_all_scopes
      redirect_to current_url
    end
end
