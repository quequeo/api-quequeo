Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins 'http://localhost:3001', 'http://localhost:5173', 'https://web.quequeo.com', 'https://main.d2c58utqvwb6hu.amplifyapp.com'
    resource '*',
      headers: :any,
      methods: [:get, :post, :put, :patch, :delete, :options, :head],
      expose: ['Content-Disposition']
  end
end
