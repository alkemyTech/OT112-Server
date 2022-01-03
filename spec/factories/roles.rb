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
FactoryBot.define do
  factory :role do
    name { "admin" }
    description { "admin user" }
  end
end
