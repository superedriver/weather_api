class WeatherRecorder
  KELVIN = 273.15

  def record_weather
    weather = Faraday.new(:url => 'http://api.openweathermap.org') do |faraday|
      faraday.request  :url_encoded             # form-encode POST params
      faraday.response :logger                  # log requests to STDOUT
      faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
    end

    response = weather.get do |req|
      req.url '/data/2.5/weather'
      req.params['q'] = ENV['WEATHER_CITY']
      req.params['appid'] = ENV['WEATHER_API_KEY']
    end

    body = JSON.parse(response.body)

    WeatherRecord.create({
      temperature: (body['main']['temp'] - KELVIN).round(1),
      humidity: body['main']['humidity'],
      pressure: body['main']['pressure'].round(1)
    })
  end
end
