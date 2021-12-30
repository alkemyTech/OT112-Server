require 'rails_helper'

RSpec.describe "Auth", type: :request do
  let(:role) { FactoryBot.create(:role) }
  let(:user) { FactoryBot.create(:user, role: role) }
  let(:token) {AuthTokenService.call(user.id)}

  describe "POST /login" do
    it "returns a string token to perform actions in the API" do
      post api_v1_auth_login_path, params: { email: user.email, password: user.password }
      expect(response).to have_http_status(:success)
      parsed = JSON.parse(response.body)
      expect(parsed).to have_key("token")
      expect(parsed["token"]).not_to be_empty
      expect(parsed["token"]).to be_kind_of(String)
    end
  end

  describe "POST /register" do 
    it "registers a new user and returns a token" do
      post api_v1_auth_register_path, params: {
        first_name: 'test', 
        last_name: 'test', 
        email: 'test@test.test', 
        password: '123456', 
        role: role
      }
      expect(response).to have_http_status(:success)
      parsed = JSON.parse(response.body)
      expect(parsed).to have_key("token")
      expect(parsed["token"]).not_to be_empty
      expect(parsed["token"]).to be_kind_of(String)
    end
  end

  describe "GET /me" do
    it "returns the info of the current user" do
      get api_v1_auth_me_path, headers: {"Authorization" => token.to_s}
      expect(response).to have_http_status(:success)
      parsed = JSON.parse(response.body)
      expect(parsed).to have_key("data")
      expect(parsed["data"]).not_to be_blank
    end
  end
end
