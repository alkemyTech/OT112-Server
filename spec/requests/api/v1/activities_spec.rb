require 'rails_helper'

RSpec.describe 'Api::V1::Activities', type: :request do
  let(:role) { FactoryBot.create(:role, name: 'admin', description: 'admin user') }
  let(:role2) { FactoryBot.create(:role, name: 'user', description: 'user user') }
  let(:activity) { FactoryBot.create(:activity, name: 'name 0', content: 'content 0') }

  let(:user) do
    FactoryBot.create(:user, first_name: 'abc', last_name: 'abc', email: 'abc@abc.com', password: '123456', role: role)
  end
  
  let(:user2) do
    FactoryBot.create(:user, first_name: 'abc5', last_name: 'abc5', email: 'abc5@abc.com', password: '123456',
                             role: role2)
  end

  let(:token) { AuthTokenService.call(user.id) }
  let(:token2) { AuthTokenService.call(user2.id) }

  it 'return status 201 to create activity' do
    post '/api/v1/activities', params: { name: 'name 1', content: 'content 1' }, headers: { 'Authorization' => token.to_s }
    expect(response).to have_http_status(:success)
  end

  it 'return unauthorized error when the user is not logged' do
    post '/api/v1/activities', params: { name: 'name 1', content: 'content 1' }
    expect(response).to have_http_status(:unauthorized)
  end

  it 'return unprocessed enty to create without name params' do
    post '/api/v1/activities', params: { content: 'content 1' }, headers: { 'Authorization' => token.to_s }
    expect(response).to have_http_status(:unprocessable_entity)
  end

  it 'return unprocessed entity to create without content params' do
    post '/api/v1/activities', params: { name: 'name 1' }, headers: { 'Authorization' => token.to_s }
    expect(response).to have_http_status(:unprocessable_entity)
  end

  it 'return unprocessed entity to create without params' do
    post '/api/v1/activities', headers: { 'Authorization' => token.to_s }
    expect(response).to have_http_status(:unprocessable_entity)
  end

  it 'return unprocessed enty to create without blank params' do
    post '/api/v1/activities', params: { name: '', content: '' }, headers: { 'Authorization' => token.to_s }
    expect(response).to have_http_status(:unprocessable_entity)
    parsed = JSON.parse(response.body)
    expect(parsed['name']).to eq(["can't be blank"])
    expect(parsed['content']).to eq(["can't be blank"])
  end

  it 'return success status in update' do
    put '/api/v1/activities/1', params: { name: 'name 2', content: 'content 2' }, headers: { 'Authorization' => token.to_s }
    expect(response).to have_http_status(:success)
  end

  it 'return unauthorized error when the user have not admin role in update' do
    put '/api/v1/activities/1', params: { name: 'name 1', content: 'content 1' }, headers: { 'Authorization' => token2.to_s }
    expect(response).to have_http_status(:unauthorized)
  end

  it 'return unprocessable entity error when the entity is not exist' do
    put '/api/v1/activities/100', params: { name: 'name 1', content: 'content 1' }, headers: { 'Authorization' => token.to_s }
    expect(response).to have_http_status(:ok)
    parsed = JSON.parse(response.body)
    expect(parsed['error']).to eq("Could not find activity with ID '100'")
  end
end
