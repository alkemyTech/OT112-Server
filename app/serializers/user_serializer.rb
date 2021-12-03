# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  deleted_at      :datetime
#  email           :string           not null
#  first_name      :string           not null
#  last_name       :string           not null
#  password_digest :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  role_id         :bigint           not null
#
# Indexes
#
#  index_users_on_deleted_at  (deleted_at)
#  index_users_on_email       (email) UNIQUE
#  index_users_on_role_id     (role_id)
#
# Foreign Keys
#
#  fk_rails_...  (role_id => roles.id)
#
class UserSerializer
  include JSONAPI::Serializer
  attributes :first_name, :last_name, :email, :photo
end
