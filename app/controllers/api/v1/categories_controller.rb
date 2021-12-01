class Api::V1::CategoriesController < ApplicationController
  before_action :authorize_request

  def index
    @categories = Category.all
    if admin?(@current_user)
      render json: CategorySerializer.new(@categories, { fields: { category: [:name] } }).serializable_hash.to_json
    else
      render json: @category.errors, status: :unprocessable_entity
    end
  end

  def create
    @category = Category.new(category_params)
    if admin?(@current_user) && !is_integer?(params[:name])
      if @category.save
        render json: CategorySerializer.new(@category).serializable_hash.to_json
      else
        render json: @category.errors, status: :unprocessable_entity
      end
    else
      render json: @category.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @current_user.role = Role.find_by(name: 'user')
    if admin?(@current_user)
      @categories = Categories.find(params[:id])
      if @categories
        @categories.destroy
      else
        head :no_content
      end
    else
      render json: { 
        "status": "Only admin users can deletes categories" 
      }, status: 422
    end
  end

  private

  def category_params
    params.permit(:name, :description)
  end

  def is_integer?(p)
    p.to_i.to_s == p
  end

end
