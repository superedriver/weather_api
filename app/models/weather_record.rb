class WeatherRecord < ApplicationRecord
  scope :from_records, -> (from) { where('created_at >= ?', from) }
  scope :to_records, -> (to) { where('created_at <= ?', to) }
end
