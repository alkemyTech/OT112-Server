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
class Announcement < ApplicationRecord
  acts_as_paranoid
  belongs_to :category
  has_one_attached :image

  validates :name, presence: true
  validates :content, presence: true
  validates :comm_type, presence: true
end
