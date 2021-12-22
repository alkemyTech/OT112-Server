class Api::V1::TestimonialsController < ApplicationController
  include Pagy::Backend
  before_action :set_testimonial, only: %i[update destroy]
  before_action :authorize_request
  after_action { pagy_headers_merge(@pagy) if @pagy }

  def index
    @pagy, @testimonials = pagy(Testimonial.all, items: params[:items] || 10, page: params[:page] || 1)
    render json: TestimonialSerializer.new(@testimonials).serializable_hash.to_json
  end

  def create
    @testimonial = Testimonial.new(testimonial_params)
    if admin?(@current_user) && @testimonial.save
      render json: TestimonialSerializer.new(@testimonial).serializable_hash.to_json, status: :created
    else
      render json: @testimonial.errors, status: :unprocessable_entity
    end
  end

  def update
    if admin?(@current_user) && @testimonial.update(testimonial_params)
      render json: TestimonialSerializer.new(@testimonial).serializable_hash.to_json, status: :created
    else
      render json: @testimonial.errors, status: :unprocessable_entity
    end
  end

  def destroy
    if admin?(@current_user)
      begin
        @testimonials = Testimonial.find(params[:id])
      rescue => exception
        render json: { message: 'Testimonio no encontrado' }, status: :not_found 
      else
        @testimonials.destroy
        render json: {
          status: 'Success',
          message: 'Testimonio eliminado',
          data: @testimonials,
          },
          status: :ok
      end
    end
  end

  private

  def set_testimonial
    @testimonial = Testimonial.find(params[:id])
  end

  def testimonial_params
    params.permit(:name, :content, :image)
  end
end
