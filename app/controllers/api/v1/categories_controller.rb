class Api::V1::CategoriesController < ApplicationController
  before_action :authorize_request
  
  def create
    @category = Category.new(category_params)
    params[:name].to_i.class != Integer
      if @category.save
        render json: CategorySerializer.new(@category).serializable_hash.to_json
      else
        render json: @category.errors, status: :unprocessable_entity
      end
        
    # else
    #   render json: @category.errors, status: :unprocessable_entity 
    # end
  end

  private
    def category_params
      params.permit(:name, :description)
    end

end
