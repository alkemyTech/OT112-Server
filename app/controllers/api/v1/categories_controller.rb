class Api::V1::CategoriesController < ApplicationController
  before_action :authorize_request
  before_action :admin?, only: %i[index create update destroy]
  before_action :set_category, only: %i[show update]
  after_action { pagy_headers_merge(@pagy) if @pagy }

  def index
    @pagy, @categories = pagy(Category.all, items: params[:items] || 10, page: params[:page] || 1)
    render json: CategorySerializer.new(@categories, { fields: { category: [:name] } }).serializable_hash.to_json
  end

  def show
    render json: CategorySerializer.new(@category).serializable_hash.to_json  
  end

  def create
    @category = Category.new(category_params)
    if !is_integer?(params[:name])
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
    if @category.update(category_params)
      render json: CategorySerializer.new(@category).serializable_hash.to_json
    else
      render json: @category.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @categories = Category.find(params[:id])
    if @categories
      @categories.destroy
    else
      head :no_content
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
