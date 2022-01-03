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
FactoryBot.define do
  factory :member do
    name { "Juan Carlos" }
    facebook_url { "https://facebook.com/juancarlos" }
    instagram_url { "https://instagram.com/juancarlos" }
    linkedin_url { "https://linkedin.com/in/juancarlos" }
    description { "Miembro de prueba" }
  end
end
