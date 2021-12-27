class Api::V1::SlidesController < ApplicationController
  before_action :authorize_request
  before_action :set_slide, only: %i[show update destroy]

  def index
    if admin?(@current_user)
      @slides = Slide.all
      render json: SlidesSerializer.new(@slides).serializable_hash.to_json
    else
      render json: { msg: 'You are not authorized to perform that action' }, status: :unauthorized
    end
  end

  def show
    if admin?(@current_user)
      render json: SlideDetailSerializer.new(@slide).serializable_hash.to_json, status: :ok
    else
      render json: { msg: 'You are not authorized to perform that action' }, status: :unauthorized
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
      render json: { msg: 'You are not authorized to perform that action' }, status: :unauthorized
    end
  end

  def update
    if admin?(@current_user)
      if @slide.update(slide_params)
        render json: SlidesSerializer.new(@slide).serializable_hash.to_json
      else
        render json: @slide.errors, status: :unprocessable_entity
      end
    else
      render json: { msg: 'You are not authorized to perform that action' }, status: :unauthorized
    end
  end

  def destroy
    if admin?(@current_user)
      if @slide.destroy
        head :no_content
      else
        render json: @announcement.errors, status: :unprocessable_entity
      end
    else
      render json: { msg: 'You are not authorized to perform that action' }, status: :unauthorized
    end
  end

  private

  def set_slide
    @slide = Slide.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Could not find slide with ID '#{params[:id]}'" }
  end

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

