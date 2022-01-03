require "rails_helper"

RSpec.describe "Api::V1::Members", type: :request do
  let(:role) { create(:role) }
  let(:role2) { FactoryBot.create(:role, name: "user", description: "user user") }
  

  let(:user) { FactoryBot.create(:user, role: role) }
  let(:user2) do 
    FactoryBot.create(:user, first_name: "test", last_name: "user2", email: "test2@example.com", password: "12345", role: role2)
  end 

  let(:member) { FactoryBot.create(:member) }

  let(:token) { AuthTokenService.call(user.id) }
  let(:token2) { AuthTokenService.call(user2.id) }

  context "(GET /api/v1/members)" do
    it "returns all members if user is admin" do
      FactoryBot.create(:member)
      get api_v1_members_url, params: {}, headers: { "Authorization" => token.to_s }
      expect(response).to have_http_status(:ok)
      parsed = JSON.parse(response.body)
      expect(parsed["data"].size).to eq(1)
    end
      
    it "returns unauthorized user message if user is not admin" do
      get api_v1_members_url, params: {}, headers: { "Authorization" => token2.to_s }
      expect(response).to have_http_status(:unauthorized)
      parsed = JSON.parse(response.body)
      expect(parsed["error"]).to eq('You are not authorized to perform that action')
    end
  end

  context "(POST /api/v1/members)" do
    it "creates a member if user is admin" do
      post api_v1_members_url, 
      params: {
              name: "Ana Clara",
              facebook_url: "https://facebook.com/anaclara",
              instagram_url: "https://instagram.com/anaclara",
              linkedin_url: "https://linkedin.com/anaclara",
              description: "Otro miembro de prueba"
              }, 
      headers: { "Authorization" => token.to_s }
      expect(response).to have_http_status(:ok)
    end
    
    it "returns unauthorized user message if user is not admin" do
      post api_v1_members_url, 
      params: {
        name: "Ana Clara",
        facebook_url: "https://facebook.com/anaclara",
        instagram_url: "https://instagram.com/anaclara",
        linkedin_url: "https://linkedin.com/anaclara",
        description: "Otro miembro de prueba"
        }, 
      headers: { "Authorization" => token2.to_s }
      expect(response).to have_http_status(:unauthorized)
      parsed = JSON.parse(response.body)
      expect(parsed["error"]).to eq('You are not authorized to perform that action')
    end
  
    it "returns unprocessable entity if name is not a string" do
      post api_v1_members_url, 
      params: {
              name: 2,
              facebook_url: "https://facebook.com/anaclara",
              instagram_url: "https://instagram.com/anaclara",
              linkedin_url: "https://linkedin.com/anaclara",
              description: "Otro miembro de prueba"
              }, 
      headers: { "Authorization" => token.to_s }
      expect(response).to have_http_status(:unprocessable_entity)
    end

    it "returns unprocessable entity if name is empty or missing" do
      post api_v1_members_url, 
      params: {
              name: "",
              facebook_url: "https://facebook.com/anaclara",
              instagram_url: "https://instagram.com/anaclara",
              linkedin_url: "https://linkedin.com/anaclara",
              description: "Otro miembro de prueba"
              }, 
      headers: { "Authorization" => token.to_s }
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  context "(PUT /api/v1/members/:id)" do
    it "updates a member if user is admin" do
      put api_v1_member_url(member.id), 
      params: {
              name: "Ana Clara Updated",
              facebook_url: "https://facebook.com/anaclara",
              instagram_url: "https://instagram.com/anaclara",
              linkedin_url: "https://linkedin.com/anaclara",
              description: "Otro miembro de prueba"
              }, 
      headers: { "Authorization" => token.to_s }
      expect(response).to have_http_status(:ok)
    end

    it "returns unauthorized if user is not admin" do
      put api_v1_member_url(member.id), 
      params: {
              name: "Ana Clara Updated",
              facebook_url: "https://facebook.com/anaclara",
              instagram_url: "https://instagram.com/anaclara",
              linkedin_url: "https://linkedin.com/anaclara",
              description: "Otro miembro de prueba"
              }, 
      headers: { "Authorization" => token2.to_s }
      expect(response).to have_http_status(:unauthorized)
      parsed = JSON.parse(response.body)
      expect(parsed["error"]).to eq('You are not authorized to perform that action')
    end

    it "returns error if member does not exist" do
      put api_v1_member_url(-1), 
      params: {
              name: "Ana Clara Updated",
              facebook_url: "https://facebook.com/anaclara",
              instagram_url: "https://instagram.com/anaclara",
              linkedin_url: "https://linkedin.com/anaclara",
              description: "Otro miembro de prueba"
              }, 
      headers: { "Authorization" => token.to_s }
      parsed = JSON.parse(response.body)
      expect(parsed["error"]).to eq("Could not find member with ID '-1'")
    end
  end

  context "(DELETE /api/v1/members/:id)" do
    it "destroy a member if user is admin" do
      delete api_v1_member_url(member.id), params: {}, headers: { "Authorization" => token.to_s }
      expect(response).to have_http_status(:no_content)
    end

    it "returns unauthorized if user is not admin" do
      delete api_v1_member_url(member.id), params: {}, headers: { "Authorization" => token2.to_s }
      expect(response).to have_http_status(:unauthorized)
    end

    it "returns error if member does not exist" do
      delete api_v1_member_url(-1), params: {}, headers: { "Authorization" => token.to_s }
      parsed = JSON.parse(response.body)
      expect(parsed["error"]).to eq("Could not find member with ID '-1'")
    end
  end
end