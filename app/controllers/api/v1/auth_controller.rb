class Api::V1::AuthController < ApplicationController
  before_action :authorize_request, only: [:show]

  class AuthenticationError < StandardError; end

  rescue_from ActionController::ParameterMissing, with: :parameter_missing
  rescue_from AuthenticationError, with: :handle_unauthenticated

  def create
    if user
      raise AuthenticationError unless user.authenticate(params.require(:password))

      token = AuthTokenService.call(user.id)
      render json: user.as_json(only: [:email]).merge(token: token)
    else
      render json: { ok: false }
    end
  end

  def show
    if @current_user
      render json: UserSerializer.new(@current_user).serializable_hash.to_json
    else
      render json: { ok: false }
    end
  end

  private

  def user
    @user ||= User.find_by(email: params.require(:email))
  end

  def parameter_missing(e)
    render json: { error: e.message }, status: :unprocessable_entity
  end

  def handle_unauthenticated
    render json: { ok: false }
  end
end
