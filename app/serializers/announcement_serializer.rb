# == Schema Information
#
# Table name: announcements
#
#  id          :bigint           not null, primary key
#  comm_type   :string
#  content     :text             not null
#  deleted_at  :datetime
#  name        :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  category_id :bigint           not null
#
# Indexes
#
#  index_announcements_on_category_id  (category_id)
#
# Foreign Keys
#
#  fk_rails_...  (category_id => categories.id)
#
class AnnouncementSerializer
  include JSONAPI::Serializer
  attributes :name, :content, :image
  belongs_to :category
end
