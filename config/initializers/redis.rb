$REDIS = if ENV["REDISCLOUD_URL"]
  Redis.new(url: ENV["REDISCLOUD_URL"])
else
  REDIS_CONFIG = Config.get('redis')

  Redis.new(
    host: REDIS_CONFIG[:host],
    port: REDIS_CONFIG[:port],
    password: REDIS_CONFIG[:password]
  )
end
