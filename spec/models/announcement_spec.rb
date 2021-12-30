# == Schema Information
#
# Table name: announcements
#
#  id          :bigint           not null, primary key
#  comm_type   :string
#  content     :text             not null
#  deleted_at  :datetime
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
require 'rails_helper'

RSpec.describe Announcement, type: :model do
    context 'at creation' do
      let(:category)     { create(:category)}
      let(:announcement) { create(:announcement, category: category)}

      it 'should validate name presence' do
        should validate_presence_of(:name)
      end

      it 'should validate content presence' do
        should validate_presence_of(:content)
      end

      it 'should validate comm_type presence' do
        should validate_presence_of(:comm_type)
      end
    end

end
