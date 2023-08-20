class ApplicationController < ActionController::API
  before_action :rate_limiting

  private

  def rate_limiting
    client_ip = request.env["REMOTE_ADDR"]
    key = "count:#{client_ip}"
    count = REDIS.get(key)

    unless count
      REDIS.set(key, 1)
      REDIS.expire(key, THROTTLE_TIME_WINDOW)
      return true
    end

    if count.to_i >= THROTTLE_MAX_REQUESTS
      render status: 429, json: { message: "You have fired too many requests. Please wait for some time." }

      return false
    end

    REDIS.incr(key)

    true
  end
end
