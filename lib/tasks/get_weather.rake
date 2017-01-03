namespace :weather do
    desc 'Writes the current weather'
    task get: :environment do
      WeatherRecorder.new.record_weather
    end
end
