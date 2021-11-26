# == Schema Information
#
# Table name: members
#
#  id            :bigint           not null, primary key
#  deleted_at    :datetime
#  description   :text
#  facebook_url  :string
#  instagram_url :string
#  linkedin_url  :string
#  name          :string           not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
# Indexes
#
#  index_members_on_deleted_at  (deleted_at)
#
require 'rails_helper'

RSpec.describe Member, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
