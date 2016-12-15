class WeatherRecordSerializer < ActiveModel::Serializer
  type 'weather_record'

  attributes :id, :temperature, :humidity, :pressure, :created_at

  def created_at
    object.created_at.iso8601
  end
end
