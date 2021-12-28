# frozen_string_literal: true

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
require 'rails_helper'

RSpec.describe User, type: :model do
  subject do
    FactoryBot.build(:user, role: role)
  end

  let(:role) { FactoryBot.create(:role) }

  describe 'Associations' do
    it { is_expected.to belong_to(:role) }
  end

  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end

  it 'is not valid without a email' do
    subject.email = nil
    expect(subject).not_to be_valid
  end

  it 'is not valid without a first_name' do
    subject.first_name = nil
    expect(subject).not_to be_valid
  end

  it 'is not valid without a last_name' do
    subject.last_name = nil
    expect(subject).not_to be_valid
  end

  it 'is not valid without a password' do
    subject.password = nil
    expect(subject).not_to be_valid
  end

  it 'is not valid without a role' do
    subject.role = nil
    expect(subject).not_to be_valid
  end
end
