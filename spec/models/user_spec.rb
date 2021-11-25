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
require 'rails_helper'

RSpec.describe User, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
