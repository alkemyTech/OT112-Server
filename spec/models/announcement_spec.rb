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
require 'rails_helper'

RSpec.describe Announcement, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
