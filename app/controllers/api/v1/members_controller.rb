class Api::V1::MembersController < ApplicationController
  before_action :authorize_request

  def create
    @member = Member.new(member_params)
    if is_string?(params[:name]) && @member.save

    else
      render json: @member.errors, status: :unprocessable_entity
    end
  end

  private
  def member_params
    params.permit(:name)
  end

  def is_string?(param)
    param.class == String
  end
end
