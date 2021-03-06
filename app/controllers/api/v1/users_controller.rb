class Api::V1::UsersController < ApplicationController
  before_action :authorize_request, except: :create
  before_action :admin?, only: %i[index] 
  before_action :set_user, only: %i[update destroy]

  def index
    @users = User.all
    render json: UserSerializer.new(@users).serializable_hash.to_json
  end

  def create
    @user = User.new(user_params)
    @user.role = Role.create_or_find_by(name: 'admin', description: 'admin user')
    if @user.save
      token = AuthTokenService.call(@user.id)
      render json: {
        "token" => token,
        "user" => UserSerializer.new(@user).serializable_hash
      }
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def update
    if @user.update(user_params)
      render json: UserSerializer.new(@user).serializable_hash.to_json
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def destroy
    if @user.destroy
      head :no_content
    else
      render :json, @user.errors, status: 422
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: {error: "Could not find user with ID '#{params[:id]}'"}, status: :unprocessable_entity
  end

  def user_params
    params.permit(:first_name, :last_name, :email, :password, :photo, :role_id)
  end
end
