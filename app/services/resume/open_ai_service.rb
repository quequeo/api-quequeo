class Resume::OpenAiService < ApplicationService
  require 'net/http'
  require 'json'

  def initialize
    @api_key = ENV['OPENAI_API_KEY']
  end

  def call
    suggest_improvements(content)
  end

  def suggest_improvements(content)
    uri = URI('https://api.openai.com/v1/chat/completions')
    request = Net::HTTP::Post.new(uri, { 'Content-Type' => 'application/json', 'Authorization' => "Bearer #{@api_key}" })
    request.body = {
      model: 'gpt-3.5-turbo',
      messages: [
        { role: 'system', content: 'You are an expert resume editor.' },
        { role: 'user', content: "Improve the following resume text: #{content}" }
      ],
      max_tokens: 150
    }.to_json
  
    response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
      http.request(request)
    end
  
    unless response.is_a?(Net::HTTPSuccess)
      parsed_error = JSON.parse(response.body)['error']
      Rails.logger.error("OpenAI API Error: #{parsed_error['message']}")
      return "Error: #{parsed_error['message']}"
    end
  
    parsed_response = JSON.parse(response.body)
    parsed_response['choices'].first['message']['content'].strip
  rescue => e
    Rails.logger.error("OpenAI API Error: #{e.message}")
    'Error processing the request'
  end
end
