require 'rails_helper'

RSpec.describe Api::V1::WeatherRecordsController, type: :controller do
  before(:all) do
    create(:weather_record, created_at: '2016-01-01T00:00:01Z')
    create(:weather_record, created_at: '2016-01-01T00:00:02Z')
    create(:weather_record, created_at: '2016-01-01T00:00:03Z')
    create(:weather_record, created_at: '2016-01-01T00:00:04Z')
    create(:weather_record, created_at: '2016-01-01T00:00:05Z')
    create(:weather_record, created_at: '2016-01-01T00:00:06Z')
    create(:weather_record, created_at: '2016-01-01T00:00:07Z')
    create(:weather_record, created_at: '2016-01-01T00:00:08Z')
    create(:weather_record, created_at: '2016-01-01T00:00:09Z')
    create(:weather_record, created_at: '2016-01-01T00:00:10Z')
  end

  describe 'GET /api/v1/observations' do
    describe 'Authorized user' do
      before do
        user = create(:user)
        token = Doorkeeper::AccessToken.create(resource_owner_id: user.id).token
        request.headers['Authorization'] = "Bearer #{token}"
      end

      it 'Returns all records' do
        get :index
        data = JSON.parse(response.body)['data']
        expect(data.length).to eq(10)
      end

      describe 'Request with FROM param' do
        it 'with correct param' do
          get :index, params: { from: '2016-01-01T00:00:04Z' }
          data = JSON.parse(response.body)['data']
          expect(data.length).to eq(7)
        end

        it 'with incorrect param' do
          get :index, params: { from: 'incorrect_param' }
          data = JSON.parse(response.body)['data']
          expect(data.length).to eq(10)
        end
      end

      describe 'Request with TO param' do
        it 'with correct param' do
          get :index, params: { to: '2016-01-01T00:00:04Z' }
          data = JSON.parse(response.body)['data']
          expect(data.length).to eq(4)
        end

        it 'with incorrect param' do
          get :index, params: { to: 'incorrect_param' }
          data = JSON.parse(response.body)['data']
          expect(data.length).to eq(10)
        end
      end

      it 'with FROM and TO param' do
        get :index, params: {
          from: '2016-01-01T00:00:03Z',
          to: '2016-01-01T00:00:05Z'
        }
        data = JSON.parse(response.body)['data']
        expect(data.length).to eq(3)
      end
    end

    describe 'Unauthorized user' do
      it 'Returns 401 status' do
        get :index
        expect(response.status).to eq(401)
        expect(response.body).to eq("")
      end
    end
  end
end
