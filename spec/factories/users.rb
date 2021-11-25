# == Schema Information
#
# Table name: users
#
#  id         :bigint           not null, primary key
#  deleted_at :datetime
#  email      :string           not null
#  first_name :string           not null
#  last_name  :string           not null
#  password   :string           not null
#  photo      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  role_id    :integer
#
# Indexes
#
#  index_users_on_deleted_at  (deleted_at)
#  index_users_on_email       (email) UNIQUE
#
FactoryBot.define do
  factory :user do
    first_name { "MyString" }
    last_name { "MyString" }
    email { "MyString" }
    password_digest { "MyString" }
    photo { "MyString" }
  end
end
