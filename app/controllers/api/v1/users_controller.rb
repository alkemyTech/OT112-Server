class Api::V1::UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy]

  def show
    render json: UserRepresenter.new(@user).as_json
  end

  def create
    @user = User.new(user_params)

    if @user.save
      render json: UserRepresenter.new(@user).as_json, status: :created
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @user.destroy
  end

  private
    def user_params
      params.permit(:first_name, :last_name, :email, :password, :photo, :role_id)
    end
    def set_user
      @user = User.find(params[:id])
    end
end
