CalendarAnnotator::Application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }
  devise_scope :user do
    get "/signout" => "devise/sessions#destroy"
  end

  constraints(:id => /[0-9A-Za-z\-\.@_]+/) do
    get "/calendars/:id" => "dashboard#calendar", as: :calendar
    get "/calendars/:id/:date" => "dashboard#day", as: :day, constraints: { date: /\d{4}-\d{2}-\d{2}/ }
  end

  resources :annotations

  root 'dashboard#index'
end
