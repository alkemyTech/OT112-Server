# == Schema Information
#
# Table name: members
#
#  id           :bigint           not null, primary key
#  deleted_at   :datetime
#  description  :text
#  facebookUrl  :string(255)
#  instagramUrl :string(255)
#  linkedinUrl  :string(255)
#  name         :string(255)      not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_members_on_deleted_at  (deleted_at)
#
require 'rails_helper'

RSpec.describe Member, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
