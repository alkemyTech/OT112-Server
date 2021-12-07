class Api::V1::TestimonialsController < ApplicationController
  def create
    @testimonial = Testimonial.new(testimonial_params)
    if admin?(@current_user) && @testimonial.save
      render json: TestimonialSerializer.new(@testimonial).serializable_hash.to_json, status: :created
    else
      render json: @testimonial.errors, status: :unprocessable_entity
    end
  end

  private

  def testimonial_params
    params.permit(:name, :content, :image)
  end
end
