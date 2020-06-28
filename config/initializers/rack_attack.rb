

class Rack::Attack
  cache.store = ActiveSupport::Cache::MemoryStore.new
  throttle('by ip generating mailbox', limit: 1, period: 2.seconds) do |req|
    if req.path == '/mailbox' && req.post?
      req.ip
    end
  end

  throttle('by ip creating mailbox in api', limit: 15, period: 20.seconds) do |req|
    if req.path == '/api/v1/mailbox' && req.post?
      req.ip
    end
  end
end
