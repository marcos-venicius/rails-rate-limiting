require "redis"

THROTTLE_TIME_WINDOW = 15 * 60 # 15 minutes
THROTTLE_MAX_REQUESTS = 60

host = ENV['REDIS_HOST'] || 'localhost'

if ENV['RAILS_ENV'] == 'test'
  host = 'localhost'
end

REDIS = Redis.new(host:, port: ENV['REDIS_PORT'] || 6379)
