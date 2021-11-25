require 'rails_helper'

RSpec.describe "Organizations", type: :request do
  describe "GET /public" do
    it "returns http success" do
      get "/organization/public"
      expect(response).to have_http_status(:success)
    end
  end

end
