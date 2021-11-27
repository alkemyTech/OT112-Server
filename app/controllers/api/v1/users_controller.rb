class Api::V1::UsersController < ApplicationController
  def create
    @user = User.new(user_params)
    @user.role = Role.create_or_find_by(name: 'admin', description: 'admin user')

    if @user.save
      render json: UserSerializer.new(@user).serializable_hash.to_json, status: :created
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.permit(:first_name, :last_name, :email, :password, :photo, :role_id)
  end
end
