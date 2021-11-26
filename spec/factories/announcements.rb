# == Schema Information
#
# Table name: announcements
#
#  id          :bigint           not null, primary key
#  content     :text             not null
#  deleted_at  :datetime
#  image       :string
#  name        :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  category_id :bigint           not null
#
# Indexes
#
#  index_announcements_on_category_id  (category_id)
#
# Foreign Keys
#
#  fk_rails_...  (category_id => categories.id)
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
