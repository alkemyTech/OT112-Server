class Api::V1::MembersController < ApplicationController
  include Pagy::Backend

  before_action :authorize_request

  after_action { pagy_headers_merge(@pagy) if @pagy }

  def index
    if admin?(@current_user)
      @pagy, @members = pagy(Member.all, items: params[:items] || 10, page: params[:page] || 1)
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

  private

  def member_params
    params.permit(:name, :facebook_url, :instagram_url, :linkedin_url)
  end

  def is_integer?(p)
    p.to_i.to_s == p
  end
end
