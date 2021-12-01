class Api::V1::CategoriesController < ApplicationController
  before_action :authorize_request
  before_action :set_category, only: [:show]

  def index
    @categories = Category.all
    if admin?(@current_user)
      render json: CategorySerializer.new(@categories, { fields: { category: [:name] } }).serializable_hash.to_json
    else
      render json: @category.errors, status: :unprocessable_entity
    end
  end

  def show
    render json: CategorySerializer.new(@category).serializable_hash.to_json  
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
    if admin?(@current_user)
      @categories = Category.find(params[:id])
      if @categories
        @categories.destroy
      else
        head :no_content
      end
    else
      render json: { 
        "status": "Only admin users can delete categories" 
      }, status: 422
    end
  end

  private

  def set_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.permit(:name, :description)
  end

  def is_integer?(p)
    p.to_i.to_s == p
  end
end
