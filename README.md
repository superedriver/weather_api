# Weather 
The simple API for getting the weather in any(Shostka as example) city.

You can try how it works here:
[http://weathersms.herokuapp.com](http://weathersms.herokuapp.com)


## Description
The weather in city is taken from [Open Weather Map](http://openweathermap.org) once per hour.

User can get the weather after registration and with access token.

#### Registration
For registration user have to send POST request to `/auth`  endpoint with email and password:
```json
{
    "email": "email@example.com",
    "password": "12345678"
}
```

#### Get access token
To get access token, after registration, user  have to send POST request to `/oauth/token` endpoint with email, password and "grant_type": "password":
```json
{
    "grant_type": "password",
    "email": "qaz@qaz.com",
    "password": "12345678"
}
```

In response user will get access_token.

```json
{
    "access_token": "b763a5537421a01f5b125ea1694420132f63600b0060b10ae6a8ec72c847dd34",
    "token_type": "bearer",
    "expires_in": 7200,
    "created_at": 1483448308
}
```


#### Get weather
To get weather user have to send GET request to `/api/v1/observations` endpoint with header:
```
  Authorization: Bearer access_token
```
And thus the access will be granted. 

The weather will be sent in JSON format:


```json
{
  "data": [
    {
      "id": "1",
      "type": "weather-record",
      "attributes": {
        "temperature": -0.3,
        "humidity": 92,
        "pressure": 1010.8,
        "created-at": "2016-12-26T10:00:06Z"
      }
    },
    {
      "id": "2",
      "type": "weather-record",
      "attributes": {
        "temperature": -0.3,
        "humidity": 89,
        "pressure": 1010,
        "created-at": "2016-12-26T11:00:08Z"
      }
    }
  ]
}    
```

To filter result you can use two query parameters **from** and **to**

**from** and **to** are timestamps in format iso8601 
`/api/v1/observations?from=2016-12-26T11:00:01Z&to=2016-12-26T11:00:08Z`

You can use them together or separately.

## Dependecies
 * [PostgreSQL](http://www.postgresql.org)

## Installation
* Go to the project folder

* Copy configuration files
```
cp .env.example .env
```
```
cp config/database.yml.example config/database.yml
```
Configure them with your data

* Install needed gems
```
bundle install
```

* Run migrations
```
bundle exec rake db:migrate
```

* Install cron job for getting weather
```
whenever --update-crontab
```
* To run application:
```
rails server
```

## Used gems
  - **Active model serializers** - for serializing models
  - **Devise** - user registrations
  - **Doorkeeper** - authorization
  - **Whenever** - for generating cron job
  - **Faraday** - for making http requests
  - **Dotenv** - for configuring app
  - **Vcr** - for mocking http requests whole testing
