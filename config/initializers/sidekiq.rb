# frozen_string_literal: true

redis_config = Rails.application.config_for(:redis)

url = "redis://#{redis_config.fetch('host', 'localhost')}:#{redis_config.fetch('port', 6379)}"
redis_config['url'] = url

Sidekiq.configure_server do |config|
  config.redis = redis_config
end

Sidekiq.configure_client do |config|
  config.redis = redis_config
end
