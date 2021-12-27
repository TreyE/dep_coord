# Use DB 4 for all job data
redis_url = ENV['REDIS_URL'] || 'redis://localhost:6379/4'
redis = { url: redis_url }
Sidekiq.configure_client do |config|
  config.redis = redis
end
