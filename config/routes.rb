Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get '/observations', to: 'weather_records#index'
    end
  end
end
