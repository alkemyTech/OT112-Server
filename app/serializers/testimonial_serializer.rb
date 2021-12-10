class TestimonialSerializer
  include JSONAPI::Serializer
  attributes :name, :content
  attribute :image do |testimonial|
    Rails.application.routes.url_helpers.rails_blob_path(testimonial.image, only_path: true) if testimonial.image.attached?
  end
end
