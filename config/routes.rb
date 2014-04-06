CalendarAnnotator::Application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  devise_scope :user do
  	get "/signout" => "devise/sessions#destroy"
  end

  # get "/signout" => "devise/sessions#destroy", :as => :signout  

  root 'dashboard#index'
end
