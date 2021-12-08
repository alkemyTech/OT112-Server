# == Schema Information
#
# Table name: contacts
#
#  id         :bigint           not null, primary key
#  deleted_at :datetime
#  email      :string           not null
#  message    :text             not null
#  name       :string           not null
#  phone      :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_contacts_on_deleted_at  (deleted_at)
#
require 'rails_helper'

RSpec.describe Contact, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
