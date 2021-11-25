# == Schema Information
#
# Table name: announcements
#
#  id         :bigint           not null, primary key
#  category   :integer
#  content    :text             not null
#  deleted_at :datetime
#  image      :string
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Announcement < ApplicationRecord
  # TODO: Uncomment this when appropiatte gem configured.
  # act_as_paranoid

  validates :name, presence: true, length: { in: 1..254 }
  validates :content, presence: true, length: { minimum: 1 }
end
