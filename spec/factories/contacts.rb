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
FactoryBot.define do
  factory :contact do
    name { "MyString" }
    phone { 1 }
    email { "MyString" }
    message { "MyText" }
    deleted_at { "2021-12-07 20:11:09" }
  end
end
