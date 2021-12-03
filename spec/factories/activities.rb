# == Schema Information
#
# Table name: activities
#
#  id         :bigint           not null, primary key
#  content    :text
#  deleted_at :datetime
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryBot.define do
  factory :activity do
    name { "MyString" }
    content { "MyText" }
    deleted_at { "2021-11-30 23:33:30" }
  end
end
