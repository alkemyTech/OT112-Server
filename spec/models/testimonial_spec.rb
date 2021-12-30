# == Schema Information
#
# Table name: testimonials
#
#  id         :bigint           not null, primary key
#  content    :string
#  deleted_at :datetime
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'rails_helper'

RSpec.describe Testimonial, type: :model do
  subject{build(:testimonial)}

  context "at creation" do
    it "is valid with valid attributes" do
      expect(subject).to be_valid
    end

    it "name should be present" do
      subject.name = nil
      expect(subject).to_not be_valid
    end

    it "name should be at least 1 character" do
      subject.name = "A"
      expect(subject).to be_valid
    end

    it "content should be present" do
      subject.content = nil
      expect(subject).to_not be_valid
    end

    it "content should be at least 1 character" do
      subject.content = "A"
      expect(subject).to be_valid
    end

    it "image may not be present" do
      subject.image = nil
      expect(subject).to be_valid
    end

    it "image should be attached" do
      expect(subject.image).to be_attached
    end

  end
end
