OkComputer.mount_at = false

redis_config = Rails.application.config_for(:redis)

OkComputer::Registry.register "redis", OkComputer::RedisCheck.new(redis_config)