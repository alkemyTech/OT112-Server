class SlideDetailSerializer
  include JSONAPI::Serializer
  attribute :order
  attribute :text
  attribute :organization_id
  attribute :image do |slide|
    Rails.application.routes.url_helpers.rails_blob_path(slide.image, only_path: true) if slide.image.attached?
  end
  attribute :created_at
  attribute :updated_at
end
