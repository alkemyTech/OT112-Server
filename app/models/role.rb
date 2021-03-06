# == Schema Information
#
# Table name: roles
#
#  id          :bigint           not null, primary key
#  description :string
#  name        :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Role < ApplicationRecord
  has_many :users

  validates :name, presence: true
end
