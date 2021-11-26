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
FactoryBot.define do
  factory :organization do
    name { "MyString" }
    address { "MyString" }
    phone { 1 }
    email { "MyString" }
    welcomeText { "MyText" }
    aboutUsText { "MyText" }
    deleted_at { "2021-11-24 20:23:52" }
  end
end
