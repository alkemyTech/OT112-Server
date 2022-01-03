require 'rails_helper'

RSpec.describe 'Api::V1::Users', type: :request do
  let(:user) { create(:user) }

  let(:role2) { create(:role, name: 'user', description: 'user user') }
  let(:user2) { create(:user, email: 'test22@test.com', role: role2) }
  
  subject {
    build(:user)
  }

  let(:good_auth_header) {
    { "Authorization" => AuthTokenService.call(user.id).to_s }
  }
  let(:bad_auth_header) {
    { "Authorization" => AuthTokenService.call(user2.id).to_s }
  }

  describe 'GET /index' do 
    it 'returns http status success' do 
      get api_v1_users_url, params: {}, headers: good_auth_header 
      expect(response).to have_http_status(:success)
    end

    it 'returns three users' do
      create(:user, first_name: 'abc2', last_name: 'abc2', email: 'abc2@abc.com', password: '123456')
      create(:user, first_name: 'abc3', last_name: 'abc3', email: 'abc3@abc.com', password: '123456')
  
      get api_v1_users_url, params: {}, headers: good_auth_header 
      parsed = JSON.parse(response.body)
      expect(parsed['data'].size).to eq(3)
    end

    it 'returns unauthorized error when the user is not an admin' do
      get api_v1_users_url, params: {}, headers: bad_auth_header 
      expect(response).to have_http_status(:unauthorized)
      parsed = JSON.parse(response.body)
      expect(parsed['error']).to eq('You are not authorized to perform that action')
    end
  
    it 'returns http status 401 when no authorization header is sent (GET /index)' do
      get api_v1_users_url, params: {}, headers: {}
      expect(response).to have_http_status(:unauthorized)
    end
  end

  describe 'POST /auth/register' do 
    it 'creates a new user' do
      expect do
        post api_v1_auth_register_url,
             params: { first_name: subject.first_name, last_name: subject.last_name, email: subject.email, password: subject.password, role: subject.role}
      end.to change { User.count }.from(0).to(1)
      expect(response).to have_http_status(:success)
    end
  
    it 'returns an error message if there are missing param' do
      post api_v1_auth_register_url,
           params: { first_name: '', last_name: '', email: subject.email, password: subject.password}
      expect(response).to have_http_status(:unprocessable_entity)
      parsed = JSON.parse(response.body)
      expect(parsed['first_name']).to eq(["can't be blank"])
      expect(parsed['last_name']).to eq(["can't be blank"])
    end
  end

  describe 'PUT /users/:id' do 
    it 'updates an existing user' do
      put api_v1_user_url(user.id),
          params: {first_name: subject.first_name, last_name: subject.last_name, email: subject.email, password: subject.password}, 
          headers: good_auth_header
      expect(response).to have_http_status(:success)
      parsed = JSON.parse(response.body)
      # check if the updated user info is returning correctly
      expect(parsed['data']).to have_key('attributes')
    end
  
    it 'returns an error when the user id in params does not exist' do
      put api_v1_user_url(4556),
          params: {first_name: subject.first_name, last_name: subject.last_name, email: subject.email, password: subject.password}, 
          headers: bad_auth_header
      expect(response).to have_http_status(:unprocessable_entity)
      parsed = JSON.parse(response.body)
      expect(parsed['error']).to eq("Could not find user with ID '4556'")
    end
  end

  describe 'DELETE /users/:id' do
    it 'deletes an user' do
      delete api_v1_user_url(user.id), params: {}, headers: good_auth_header
      expect(response).to have_http_status(:success)
    end
  end
end
