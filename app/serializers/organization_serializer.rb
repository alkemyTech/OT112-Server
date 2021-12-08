# == Schema Information
#
# Table name: organizations
#
#  id            :bigint           not null, primary key
#  about_us_text :text
#  address       :string
#  deleted_at    :datetime
#  email         :string           not null
#  facebook_url  :string
#  instagram_url :string
#  linkedin_url  :string
#  name          :string           not null
#  phone         :integer
#  welcome_text  :text             not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
class OrganizationSerializer
  include JSONAPI::Serializer
  attributes :name, :phone, :address
  attribute :image do |organization|
    Rails.application.routes.url_helpers.rails_blob_path(organization.image, only_path: true) if organization.image.attached?
  end
end
