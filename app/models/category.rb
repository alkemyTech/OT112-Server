# == Schema Information
#
# Table name: categories
#
#  id          :bigint           not null, primary key
#  description :string
#  name        :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Category < ApplicationRecord
  has_one_attached :image
  has_many :announcements
  acts_as_paranoid

  validates :name, presence: true
end
