class ActivitySerializer
  include JSONAPI::Serializer
  attributes :name, :content
end
