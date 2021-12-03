# == Schema Information
#
# Table name: activities
#
#  id         :bigint           not null, primary key
#  content    :text
#  deleted_at :datetime
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Activity < ApplicationRecord
  has_one_attached :image
  acts_as_paranoid
end
