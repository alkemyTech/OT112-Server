class Api::V1::SlidesController < ApplicationController
  before_action :authorize_request

  def index
    if admin?(@current_user)
      @slides = Slide.all
      render json: SlidesSerializer.new(@slides).serializable_hash.to_json
    else
      render json: {msg: 'You are not authorized to perform that action'}, status: :forbidden
    end
  end

  def create
    if admin?(@current_user)
      @slide = Slide.new(slide_params)
      @slide.image.attach(data: params[:image])
      if @slide.save
        render json: @slide
      else
        render json: @slide.errors, status: :unprocessable_entity 
      end
    else
      render json: {msg: 'You are not authorized to perform that action'}, status: :forbidden
    end
  end
    
  private
  
    def slide_params
      default = { order: order_default.max + 1 }
      params.permit(:order, :organization_id).reverse_merge(default)
    end

    def order_default
      order_array = []
      slides = Slide.all
      
      slides.each do |slide|
        order_array << slide.order
      end
      order_array.empty? ? [0] : order_array
    end
    
end
