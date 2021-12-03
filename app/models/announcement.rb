# == Schema Information
#
# Table name: announcements
#
#  id          :bigint           not null, primary key
#  content     :text             not null
#  deleted_at  :datetime
#  name        :string           not null
#  type        :string
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
  validates :type, presence: true
end
