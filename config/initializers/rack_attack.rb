
class Rack::Attack
  cache.store = ActiveSupport::Cache::MemoryStore.new

  throttled_response = lambda do |env|
    match_data = env['rack.attack.match_data']
    now = match_data[:epoch_time]

    headers = {
      'RateLimit-Limit' => match_data[:limit].to_s,
      'RateLimit-Remaining' => '0',
      'RateLimit-Reset' => (now + (match_data[:period] - now % match_data[:period])).to_s
    }

    [ 429, headers, ["Throttled\n"]]
  end

  throttle('by ip generating mailbox', limit: 1, period: 3.seconds) do |req|
    if req.path == '/mailbox' && req.post?
      req.ip
    end
  end

  throttle('by ip creating mailbox in api', limit: 15, period: 24.seconds) do |req|
    if req.path == '/api/v1/mailbox' && req.post?
      req.ip
    end
  end
end
