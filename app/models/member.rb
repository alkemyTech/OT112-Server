# == Schema Information
#
# Table name: members
#
#  id           :bigint           not null, primary key
#  deleted_at   :datetime
#  description  :text
#  facebookUrl  :string(255)
#  instagramUrl :string(255)
#  linkedinUrl  :string(255)
#  name         :string(255)      not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_members_on_deleted_at  (deleted_at)
#
class Member < ApplicationRecord
    has_one_attached :image

    acts_as_paranoid 
end
