# == Schema Information
#
# Table name: categories
#
#  id          :bigint           not null, primary key
#  deleted_at  :datetime
#  description :string
#  name        :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_categories_on_deleted_at  (deleted_at)
#
class CategorySerializer
  include JSONAPI::Serializer
  attributes :name, :description
end
