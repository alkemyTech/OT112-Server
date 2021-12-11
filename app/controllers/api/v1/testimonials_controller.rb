class Api::V1::TestimonialsController < ApplicationController
  before_action :set_testimonial, only: [:update]
  before_action :authorize_request

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


  private

  def set_testimonial
    @testimonial = Testimonial.find(params[:id])
  end

  def testimonial_params
    params.permit(:name, :content, :image)
  end
end