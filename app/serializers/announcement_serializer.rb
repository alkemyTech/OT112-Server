class AnnouncementSerializer
  include JSONAPI::Serializer
  attributes :name, :content, :image
  belongs_to :category
end
