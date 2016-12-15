Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth'
  namespace :api do
    namespace :v1 do
      get '/observations', to: 'weather_records#index'
    end
  end
end
