every 1.hour do
  rake "weather:get", environment: 'development'
end