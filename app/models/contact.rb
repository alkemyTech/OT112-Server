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
class Contact < ApplicationRecord
  acts_as_paranoid

  after_create :send_contact_email

  validates :name, presence: true
  validates :phone, presence: true
  validates :email, presence: true
  validates :message, presence: true

  def send_contact_email
    @contact = self
    ContactNotifierMailer.send_contact_email(@contact).deliver_now
  end
end
