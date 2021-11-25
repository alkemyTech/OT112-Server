class Organization < ApplicationRecord
    validates :name, presence: true
    validates :email, uniqueness: true, presence: true
    validates :welcomeText, presence: true
end
