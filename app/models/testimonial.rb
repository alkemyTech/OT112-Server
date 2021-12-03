# == Schema Information
#
# Table name: testimonials
#
#  id         :bigint           not null, primary key
#  content    :string
#  deleted_at :datetime
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Testimonial < ApplicationRecord
  has_one_attached :image
  acts_as_paranoid

  validates :name, presence: true
end
