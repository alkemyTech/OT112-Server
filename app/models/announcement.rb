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
  act_as_paranoid

  validates :name, presence: true
  validates :content, presence: true
end
