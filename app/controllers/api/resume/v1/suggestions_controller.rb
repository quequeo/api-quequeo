class Api::Resume::V1::SuggestionsController < Api::Resume::ApplicationController
  def create
    content = params[:content]
    return render json: { error: 'Content cannot be blank' }, status: :bad_request if content.blank?

    response = Resume::OpenAiService.new.suggest_improvements(content)

    if response.blank?
      return render json: { error: "No suggestions could be generated" }, status: :internal_server_error
    end

    if response.start_with?('Error')
      return render json: { error: response }, status: :internal_server_error
    end

    render json: { suggestions: response }, status: :ok
  end
end
