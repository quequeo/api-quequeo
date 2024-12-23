require 'rails_helper'

RSpec.describe 'Errorable', type: :controller do
  controller(ApplicationController) do
    include Errorable

    def trigger_no_method_error
      nil.some_undefined_method
    end

    def trigger_record_not_found
      raise ActiveRecord::RecordNotFound, "Test record not found"
    end

    def trigger_unprocessable_entity
      user = User.new
      user.validate!
    end

    def trigger_missing_parameters
      raise ActionController::ParameterMissing, "Test missing parameter"
    end

    def trigger_method_not_allowed
      raise ActionController::UnknownHttpMethod, "Test method not allowed"
    end

    def trigger_record_invalid
      raise ActiveRecord::RecordInvalid.new(User.new)
    end
  end

  before do
    routes.draw do
      get 'trigger_no_method_error' => 'anonymous#trigger_no_method_error'
      get 'trigger_record_not_found' => 'anonymous#trigger_record_not_found'
      get 'trigger_unprocessable_entity' => 'anonymous#trigger_unprocessable_entity'
      get 'trigger_missing_parameters' => 'anonymous#trigger_missing_parameters'
      get 'trigger_method_not_allowed' => 'anonymous#trigger_method_not_allowed'
      get 'trigger_record_invalid' => 'anonymous#trigger_record_invalid'
    end
  end

  describe 'Errorable module' do
    context 'when a NoMethodError is raised' do
      it 'returns a 500 error with a descriptive message' do
        get :trigger_no_method_error
        expect(response).to have_http_status(:internal_server_error)
        expect(JSON.parse(response.body)).to include("message" => "An unexpected error occurred")
      end
    end

    context 'when a RecordNotFound error is raised' do
      it 'returns a 404 error with a descriptive message' do
        get :trigger_record_not_found
        expect(response).to have_http_status(:not_found)
        expect(JSON.parse(response.body)).to include("message" => "The requested resource could not be found")
      end
    end

    context 'when a RecordInvalid error is raised' do
      it 'returns a 422 error with a descriptive message' do
        get :trigger_unprocessable_entity
        expect(response).to have_http_status(:unprocessable_entity)
        parsed_response = JSON.parse(response.body)
        expect(parsed_response).to include("message" => "The request was unacceptable")
        expect(parsed_response["error"]).to be_present
      end
    end    

    context 'when a ParameterMissing error is raised' do
      it 'returns a 422 error with a descriptive message' do
        get :trigger_missing_parameters
        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)).to include("message" => "The request is missing required parameters")
      end
    end

    context 'when a MethodNotAllowed error is raised' do
      it 'returns a 405 error with a descriptive message' do
        get :trigger_method_not_allowed
        expect(response).to have_http_status(:method_not_allowed)
        expect(JSON.parse(response.body)).to include("message" => "The requested method is not allowed")
      end
    end
  end
end
