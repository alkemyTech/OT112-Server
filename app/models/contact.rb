# == Schema Information
#
# Table name: contacts
#
#  id         :bigint           not null, primary key
#  deleted_at :datetime
#  email      :string           not null
#  message    :text             not null
#  name       :string           not null
#  phone      :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Contact < ApplicationRecord
  acts_as_paranoid
  
  validates :name, presence: true
  validates :phone, presence: true
  validates :email, presence: false
  validates :message, presence: false
end
