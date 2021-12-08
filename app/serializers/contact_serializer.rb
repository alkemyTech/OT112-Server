class ContactSerializer
  include JSONAPI::Serializer
  attributes :name, :email
end
