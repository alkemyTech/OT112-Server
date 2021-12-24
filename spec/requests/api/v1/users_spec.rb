require 'rails_helper'

RSpec.describe 'Api::V1::Users', type: :request do
  let(:role) { FactoryBot.create(:role) }
  let(:role2) { FactoryBot.create(:role, name: 'user', description: 'user user') }

  let(:user) { FactoryBot.create(:user, role: role) }
  let(:user2) { FactoryBot.create(:user, email: 'test22@test.com', role: role2) }
  
  let(:good_auth_header) {
    { "Authorization" => AuthTokenService.call(user.id).to_s }
  }
  let(:bad_auth_header) {
    { "Authorization" => AuthTokenService.call(user2.id).to_s }
  }

  it 'returns three users (GET /index)' do
    FactoryBot.create(:user, first_name: 'abc2', last_name: 'abc2', email: 'abc2@abc.com', password: '123456',
                             role: role)
    FactoryBot.create(:user, first_name: 'abc3', last_name: 'abc3', email: 'abc3@abc.com', password: '123456',
                             role: role)

    get api_v1_users_url, params: {}, headers: good_auth_header 
    expect(response).to have_http_status(:success)
    parsed = JSON.parse(response.body)
    expect(parsed['data'].size).to eq(3)
  end

  it 'returns unauthorized error when the user is not an admin' do
    get api_v1_users_url, params: {}, headers: bad_auth_header 
    expect(response).to have_http_status(:unauthorized)
    parsed = JSON.parse(response.body)
    expect(parsed['status']).to eq('Only admin users can list announcements')
  end

  it 'returns http status 401 when no authorization header is sent (GET /index)' do
    get api_v1_users_url, params: {}, headers: {}
    expect(response).to have_http_status(:unauthorized)
  end

  it 'creates a new user (POST /auth/register)' do
    expect do
      post api_v1_auth_register_url,
           params: { first_name: 'abc4', last_name: 'abc4', email: 'abc4@abc.com', password: '123456', role: role }
    end.to change { User.count }.from(0).to(1)
    expect(response).to have_http_status(:success)
  end

  it 'returns an error message if there are missing param (POST /auth/register)' do
    post api_v1_auth_register_url,
         params: { first_name: '', last_name: '', email: 'abc4@abc.com', password: '123456', role: role }
    expect(response).to have_http_status(:unprocessable_entity)
    parsed = JSON.parse(response.body)
    expect(parsed['first_name']).to eq(["can't be blank"])
    expect(parsed['last_name']).to eq(["can't be blank"])
  end

  it 'updates an existing user (PUT /api/v1/users/:id)' do
    put api_v1_user_url(user.id),
        params: {first_name: 'abca', last_name: 'abca', email: 'abc4@abc.com', password: '123456', role: role }, 
        headers: good_auth_header
    expect(response).to have_http_status(:success)
    parsed = JSON.parse(response.body)
    # check if the updated user info is returning correctly
    expect(parsed['data']).to have_key('attributes')
  end

  it 'returns an error when the user id in params does not exist (PUT /api/v1/users/:id)' do
    put api_v1_user_url(4556),
        params: {first_name: 'abca', last_name: 'abca', email: 'abc4@abc.com', password: '123456', role: role }, 
        headers: bad_auth_header
    expect(response).to have_http_status(:unprocessable_entity)
    parsed = JSON.parse(response.body)
    expect(parsed['error']).to eq("Could not find user with ID '4556'")
  end

  it 'deletes an user (DELETE /api/v1/users/:id)' do
    delete api_v1_user_url(user.id), params: {}, headers: good_auth_header
    expect(response).to have_http_status(:success)
  end
end
