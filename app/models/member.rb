# == Schema Information
#
# Table name: members
#
#  id            :bigint           not null, primary key
#  deleted_at    :datetime
#  description   :text
#  facebook_url  :string
#  instagram_url :string
#  linkedin_url  :string
#  name          :string           not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
# Indexes
#
#  index_members_on_deleted_at  (deleted_at)
#
class Member < ApplicationRecord
    has_one_attached :image

    acts_as_paranoid 

    validates :name, presence: true
    validates :facebook_url, uniqueness: true
    validates :instagram_url, uniqueness: true
    validates :linkedin_url, uniqueness: true
end
