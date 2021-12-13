class ContactSerializer
  include JSONAPI::Serializer
  attributes :name, :phone, :email, :message
end
