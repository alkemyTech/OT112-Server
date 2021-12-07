class Api::V1::OrganizationsController < ApplicationController
  before_action :authorize_request

  def public
    @organization = Organization.find(params[:id])
    render json: OrganizationSerializer.new(@organization).serializable_hash.to_json
  end

  def create
    @organization = Organization.new(organization_params)
    if @organization.save
      render json: OrganizationSerializer.new(@organization).serializable_hash.to_json
    else
      render json: @organization.errors, status: :unprocessable_entity
    end
  end

  private
    def organization_params
      params.permit(:name, :email, :adress, :about_us_text, :phone, :welcome_text, :instagram_url, :facebook_url, :linkedin_url)
    end

end
