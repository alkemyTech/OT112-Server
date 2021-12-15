class Api::V1::MembersController < ApplicationController
  before_action :authorize_request

  def create
    @member = Member.new(member_params)
    
    if admin?(@current_user)
      if is_string?(params[:name]) && @member.save

      else
        render json: @member.errors, status: :unprocessable_entity
      end
    else
      render json: {error: 'You are not authorized to perform that action'}, status: :unauthorized
    end
  end

  private
  def member_params
    params.permit(:name, :facebook_url, :instagram_url, :linkedin_url)
  end

  def is_string?(param)
    param.class == String
  end
end
