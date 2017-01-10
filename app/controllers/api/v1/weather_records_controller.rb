module Api::V1
  class WeatherRecordsController < ApplicationController
    before_action :doorkeeper_authorize!, only: [:index]

    # GET /api/v1/observations
    def index
      from = convert(params[:from]) if limitation_present?(params, :from)

      to = if limitation_present?(params, :to)
        # to include values with milliseconds like "2016-12-26 10:00:06.413169"
        params[:to][-1] = ".999999Z"
        convert(params[:to])
      end

      @weathers = WeatherRecord.all
      @weathers = @weathers.from_records(from) if from
      @weathers = @weathers.to_records(to) if to

      render json: @weathers
    end

    private

    def limitation_present?(params, limit)
      params[limit].present? && valid_format?(params[limit])
    end

    def valid_format?(string)
      string =~ /^\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}Z$/
    end

    def convert(string)
      begin
        Time.zone.parse(string)
      rescue ArgumentError
        nil
      end
    end
  end
end
