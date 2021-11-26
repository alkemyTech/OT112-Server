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
#  photo           :string
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

class User < ApplicationRecord
  has_secure_password
  acts_as_paranoid
  belongs_to :role

  after_create :send_signup_email

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :password, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }

  private

  def send_signup_email
    @user = self
    UserNotifierMailer.send_signup_email(@user).deliver_now
  end
end
