# == Schema Information
#
# Table name: organizations
#
#  id            :bigint           not null, primary key
#  about_us_text :text
#  address       :string
#  deleted_at    :datetime
#  email         :string           not null
#  name          :string           not null
#  phone         :integer
#  welcome_text  :text             not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
class Organization < ApplicationRecord
  has_one_attached :image
  acts_as_paranoid

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :welcome_text, presence: true
end
