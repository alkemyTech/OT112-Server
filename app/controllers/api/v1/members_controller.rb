class Api::V1::MembersController < ApplicationController
  before_action :authorize_request
  before_action :set_member, only: %i[destroy]

  def index
    if admin?(@current_user)
      @members = Member.all
      render json: MemberSerializer.new(@members).serializable_hash.to_json, status: :ok
    else
      render json: {error: 'You are not authorized to perform that action'}
    end
  end

  def create
    @member = Member.new(member_params)
    if admin?(@current_user)
      if !is_integer?(params[:name]) && @member.save
        render json: MemberSerializer.new(@member).serializable_hash.to_json
      else
        render json: @member.errors, status: :unprocessable_entity
      end
    else
      render json: { error: 'You are not authorized to perform that action' }, status: :unauthorized
    end
  end

  def destroy
    if admin?(@current_user)
      @member.destroy
    else
      render json: { error: 'You are not authorized to perform that action' }, status: :unauthorized
    end
  end

  private

  def member_params
    params.permit(:name, :facebook_url, :instagram_url, :linkedin_url)
  end

  def is_integer?(p)
    p.to_i.to_s == p
  end

  def set_member
    @member = Member.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: {error: "Could not find member with ID '#{params[:id]}'"}
  end
end
