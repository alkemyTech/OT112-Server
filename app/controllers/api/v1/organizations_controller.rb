class Api::V1::OrganizationsController < ApplicationController
  before_action :authorize_request

  def public
    @organization = Organization.find(params[:id])
    render json: OrganizationSerializer.new(@organization).serializable_hash.to_json
  end
end
