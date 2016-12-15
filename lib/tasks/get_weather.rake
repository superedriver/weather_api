namespace :weather do
    desc 'Gets '
    task get: :environment do
      WeatherRecorder.record_weather
    end
end
