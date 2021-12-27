class Api::V1::CategoriesController < ApplicationController
  before_action :authorize_request
  before_action :set_category, only: %i[show update destroy]
  after_action { pagy_headers_merge(@pagy) if @pagy }

  def index
    @pagy, @categories = pagy(Category.all, items: params[:items] || 10, page: params[:page] || 1)
    if admin?(@current_user)
      render json: CategorySerializer.new(@categories, { fields: { category: [:name] } }).serializable_hash.to_json
    else
      render json: { error: 'You are not authorized to perform that action' }, status: :unauthorized
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
      render json: { error: 'You are not authorized to perform that action' }, status: :unauthorized
    end
  end

  def update
    if admin?(@current_user)
      if @category.update(category_params)
        render json: CategorySerializer.new(@category).serializable_hash.to_json
      else
        render json: @category.errors, status: :unprocessable_entity
      end
    else
      render json: { error: 'You are not authorized to perform that action' }, status: :unauthorized
    end
  end

  def destroy
    if admin?(@current_user)
      if @category.destroy
        head :no_content
      else
        render json: @category.errors, status: :unprocessable_entity
      end
    else
      render json: { error: 'You are not authorized to perform that action' }, status: :unauthorized
    end
  end

  private

  def set_category
    @category = Category.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: {error: "Could not find category with ID '#{ params[:id] }'"}
  end
  

  def category_params
    params.permit(:name, :description)
  end

  def is_integer?(p)
    p.to_i.to_s == p
  end

end
