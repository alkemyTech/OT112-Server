class Api::V1::SlidesController < ApplicationController
  before_action :set_slide, only: %i[show update destroy]
  before_action :admin?
  before_action :authorize_request

  def index
    @slides = Slide.all
    render json: SlidesSerializer.new(@slides).serializable_hash.to_json
  end

  def show
    render json: SlideDetailSerializer.new(@slide).serializable_hash.to_json, status: :ok
  end

  def create
    @slide = Slide.new(slide_params)
    @slide.image.attach(data: params[:image])
    if @slide.save
      render json: @slide
    else
      render json: @slide.errors, status: :unprocessable_entity
    end
  end

  def update
    if @slide.update(slide_params)
      render json: Slide.Serializer.new(@slide).serializable_hash.to_json
    else
      render json: @slide.errors, status: :unprocessable_entity
    end
  end

  def destroy
    if @slides.destroy
      head :no_content
    else
      render json: @announcement.errors, status: :unprocessable_entity
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
