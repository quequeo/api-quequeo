require 'rails_helper'

RSpec.describe Api::V1::AuthController, type: :controller do
  describe 'POST #register' do
    let(:valid_attributes) { { email: 'test@example.com', password: 'password', password_confirmation: 'password' } }
    let(:invalid_attributes) { { email: '', password: 'password', password_confirmation: 'password' } }

    context 'with valid attributes' do
      it 'creates a user and returns a token' do
        expect {
          post :register, params: valid_attributes
        }.to change(User, :count).by(1)
        expect(response).to have_http_status(:created)
        expect(JSON.parse(response.body)).to include('token')
      end
    end

    context 'with invalid attributes' do
      it 'returns unprocessable entity' do
        post :register, params: invalid_attributes
        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)).to include('errors')
      end
    end
  end

  describe 'POST #login' do
    let(:user) { create(:user, email: 'test@example.com', password: 'password', password_confirmation: 'password') }

    context 'with valid credentials' do
      it 'returns a token' do
        post :login, params: { email: user.email, password: 'password' }
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)).to include('token')
      end
    end

    context 'with invalid credentials' do
      it 'returns unauthorized' do
        post :login, params: { email: user.email, password: 'wrong_password' }
        expect(response).to have_http_status(:unauthorized)
        expect(JSON.parse(response.body)).to include('errors')
      end
    end
  end
end
