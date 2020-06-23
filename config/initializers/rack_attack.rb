

class Rack::Attack
  cache.store = ActiveSupport::Cache::MemoryStore.new
  throttle('by ip generating mailbox', limit: 1, period: 2.seconds) do |req|
    if req.path == '/mailbox' && req.post?
      req.ip
    end
  end
end