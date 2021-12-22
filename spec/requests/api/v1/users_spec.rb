require 'rails_helper'

RSpec.describe 'Api::V1::Users', type: :request do
  let(:role) { FactoryBot.create(:role, name: 'admin', description: 'admin user') }
  let(:role2) { FactoryBot.create(:role, name: 'user', description: 'user user') }

  let(:user) do
    FactoryBot.create(:user, first_name: 'abc', last_name: 'abc', email: 'abc@abc.com', password: '123456', role: role)
  end
  let(:user2) do
    FactoryBot.create(:user, first_name: 'abc5', last_name: 'abc5', email: 'abc5@abc.com', password: '123456',
                             role: role2)
  end

  let(:token) { AuthTokenService.call(user.id) }
  let(:token2) { AuthTokenService.call(user2.id) }

  it 'returns three users (GET /index)' do
    FactoryBot.create(:user, first_name: 'abc2', last_name: 'abc2', email: 'abc2@abc.com', password: '123456',
                             role: role)
    FactoryBot.create(:user, first_name: 'abc3', last_name: 'abc3', email: 'abc3@abc.com', password: '123456',
                             role: role)

    get '/api/v1/users', params: {}, headers: { 'Authorization' => token.to_s }
    expect(response).to have_http_status(:success)
    parsed = JSON.parse(response.body)
    expect(parsed['data'].size).to eq(3)
  end

  it 'returns unauthorized error when the user is not an admin' do
    get '/api/v1/users', params: {}, headers: { 'Authorization' => token2.to_s }
    expect(response).to have_http_status(:unauthorized)
    parsed = JSON.parse(response.body)
    expect(parsed['status']).to eq('Only admin users can list announcements')
  end

  it 'returns http status 401 when no authorization header is sent (GET /index)' do
    get '/api/v1/users', params: {}, headers: {}
    expect(response).to have_http_status(:unauthorized)
  end

  it 'creates a new user (POST /auth/register)' do
    expect do
      post '/api/v1/auth/register',
           params: { first_name: 'abc4', last_name: 'abc4', email: 'abc4@abc.com', password: '123456', role: role }
    end.to change { User.count }.from(0).to(1)
    expect(response).to have_http_status(:success)
  end

  it 'returns an error message if there are missing param (POST /auth/register)' do
    post '/api/v1/auth/register',
         params: { first_name: '', last_name: '', email: 'abc4@abc.com', password: '123456', role: role }
    expect(response).to have_http_status(:unprocessable_entity)
    parsed = JSON.parse(response.body)
    expect(parsed['first_name']).to eq(["can't be blank"])
    expect(parsed['last_name']).to eq(["can't be blank"])
  end

  it 'updates an existing user (PUT /api/v1/users/:id)' do
    put "/api/v1/users/#{user.id}",
        params: { first_name: 'abca', last_name: 'abca', email: 'abc4@abc.com', password: '123456', role: role }, 
        headers: { 'Authorization' => token.to_s }
    expect(response).to have_http_status(:success)
    parsed = JSON.parse(response.body)
    # check if the updated user info is returning correctly
    expect(parsed['data']).to have_key('attributes')
  end

  it 'returns an error when the user id in params does not exist (PUT /api/v1/users/:id)' do
    put '/api/v1/users/4556',
        params: { first_name: 'abca', last_name: 'abca', email: 'abc4@abc.com', password: '123456', role: role }, 
        headers: { 'Authorization' => token.to_s }
    expect(response).to have_http_status(:unprocessable_entity)
    parsed = JSON.parse(response.body)
    expect(parsed['error']).to eq("Could not find user with ID '4556'")
  end

  it 'deletes an user (DELETE /api/v1/users/:id)' do
    delete "/api/v1/users/#{user.id}", params: {}, headers: { 'Authorization' => token.to_s }
    expect(response).to have_http_status(:success)
  end
end
