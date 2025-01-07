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
    bad_ips = ["157.245.36.108", "87.236.176.232", "185.147.124.148"]
    bad_ips.include?(req.ip)
  end

  blocklist("block-suspicious-paths") do |req|
    suspicious_paths = [
      "/.env", 
      "/.git/config", 
      "/info.php", 
      "/RDWeb/Pages", 
      "/server-status", 
      "/login.action", 
      "/_all_dbs", 
      "/.DS_Store", 
      "/s/9333e2430313e2630323e28313/_/;/META-INF/maven/com.atlassian.jira/jira-webapp-dist/pom.properties",
      "/dns-query"
    ]
    suspicious_paths.include?(req.path)
  end
end
