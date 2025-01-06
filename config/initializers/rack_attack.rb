class Rack::Attack
  # Allow all local traffic
  safelist("allow-localhost") do |req|
    ["127.0.0.1", "::1"].include?(req.ip)
  end

  # Limit requests to 60 per minute
  throttle("req/ip", limit: 60, period: 1.minute) do |req|
    req.ip
  end

  # Block suspicious IPs
  blocklist("block-bad-actors") do |req|
    bad_ips = ["157.245.36.108", "87.236.176.232"]
    bad_ips.include?(req.ip)
  end

  # Block suspicious paths
  blocklist("block-suspicious-paths") do |req|
    suspicious_paths = ["/.env", "/.git/config", "/info.php"]
    suspicious_paths.include?(req.path)
  end
end
