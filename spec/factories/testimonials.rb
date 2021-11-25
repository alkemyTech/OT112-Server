# == Schema Information
#
# Table name: testimonials
#
#  id         :bigint           not null, primary key
#  content    :string
#  deleted_at :datetime
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryBot.define do
  factory :testimonial do
    name { "MyString" }
    content { "MyText" }
    deleted_at { "2021-11-25 19:49:37" }
  end
end
