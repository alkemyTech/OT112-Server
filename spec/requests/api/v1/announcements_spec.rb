require 'rails_helper'

RSpec.describe "Api::V1::Announcements", type: :request do


  let(:role)                { create(:role) }
  let(:admin_role)          { create(:role, name: 'admin') }
  let(:user)                { create(:user, role: role) }
  let(:admin_user)          { create(:user, role: admin_role) }
  let(:category)            { create(:category)}
  let(:announcement)        { create(:announcement, category: category)}
  let(:announcement_params) { attributes_for(:announcement)}

  let(:authorization_header) {
    {'Authorization' => AuthTokenService.call(user.id).to_s}
  }
  let(:admin_authorization_header) {
    {'Authorization' => AuthTokenService.call(admin_user.id).to_s}
  }

  context 'with no auth header' do
    it 'GET must be denied' do
      get api_v1_announcements_url
      expect(response).to have_http_status(401)
    end

    it 'POST must be denied' do
      post api_v1_announcements_url
      expect(response).to have_http_status(401)
    end

    it 'DESTROY must be denied' do
      delete api_v1_announcement_url(announcement.id)
      expect(response).to have_http_status(401)
    end

    it 'UPDATE must be denied' do
      put api_v1_announcement_url(announcement.id)
      expect(response).to have_http_status(401)
    end
  end

  context 'with regular user' do
    it 'GET  must be Ok' do
      get api_v1_announcements_url, headers: authorization_header
      expect(response).to have_http_status(200)
    end

    it 'POST must be Denied' do
      post api_v1_announcements_url, params: announcement_params, headers: authorization_header
      expect(response).to have_http_status(401)
    end

    it 'DESTROY must be Denied' do
      delete api_v1_announcement_url(announcement.id), headers: authorization_header
      expect(response).to have_http_status(401)
    end

    it 'DESTROY on unexistent record must be Denied' do
      delete api_v1_announcement_url(-1), headers: authorization_header
      expect(response).to have_http_status(401)
    end

    it 'UPDATE must be Denied' do
      put api_v1_announcement_url(announcement.id), headers: authorization_header
      expect(response).to have_http_status(401)
    end
  end

  context 'with admin user' do
    it 'GET  must be Ok' do
      get api_v1_announcements_url, headers: admin_authorization_header
      expect(response).to have_http_status(200)
    end

    it 'POST must be Ok' do
      post api_v1_announcements_url, params: announcement_params, headers: admin_authorization_header
      expect(response).to have_http_status(201)
    end

    it 'DESTROY must be Ok' do
      delete api_v1_announcement_url(announcement.id), headers: admin_authorization_header
      expect(response).to have_http_status(200)
    end

    it 'DESTROY must be not found for unexistent Announcement' do
      delete api_v1_announcement_url(-1), headers: admin_authorization_header
      expect(response).to have_http_status(404)
    end

    it 'UPDATE must be Ok' do
      put api_v1_announcement_url(announcement.id), headers: admin_authorization_header
      expect(response).to have_http_status(201)
    end
  end

end
