# == Schema Information
#
# Table name: announcements
#
#  id         :bigint           not null, primary key
#  category   :integer
#  content    :text             not null
#  deleted_at :datetime
#  image      :string
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryBot.define do
  factory :announcement do
    name { "MyString" }
    content { "MyText" }
    image { "MyString" }
    category { 1 }
    deleted_at { "2021-11-24 22:40:24" }
  end
end
