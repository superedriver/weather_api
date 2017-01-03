require 'rails_helper'

RSpec.describe WeatherRecorder do
  it 'Returns all records' do
    VCR.use_cassette('wecord_weather') do
      expect{described_class.new.record_weather}.to change{WeatherRecord.count}.by(1)
    end
  end
end
