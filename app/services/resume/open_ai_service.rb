class Resume::OpenAiService < ApplicationService
  require 'net/http'
  require 'json'

  def initialize
    @api_key = ENV['OPENAI_API_KEY']
  end

  def call
    suggest_improvements(content)
  end

  private

  def suggest_improvements(content)
    uri = URI('https://api.openai.com/v1/completions')
    request = Net::HTTP::Post.new(uri, { 'Content-Type' => 'application/json', 'Authorization' => "Bearer #{@api_key}" })
    request.body = {
      model: 'text-davinci-003',
      prompt: "Improve the following resume text: #{content}",
      max_tokens: 150
    }.to_json

    response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
      http.request(request)
    end

    JSON.parse(response.body)['choices'].first['text'].strip
  rescue => e
    Rails.logger.error("OpenAI API Error: #{e.message}")
    'Error processing the request'
  end
end
