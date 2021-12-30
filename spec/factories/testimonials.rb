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
FactoryBot.define do
  factory :testimonial do
    name { "How Somos Mas changed my life." }

    content { "Lorem ipsum dolor sit amet, consectetur adipiscing elit."\
              "Nullam tempus, orci non scelerisque lacinia, erat erat"\
              "consectetur ex, a mollis nisi ante a lacus. Etiam fermentum"\
              "quis nisi ac efficitur. Lorem ipsum dolor sit amet,"\
              "consectetur adipiscing elit. Sed odio ante, pharetra aliquam"\
              "elementum id, consectetur et ex. Quisque vestibulum congue"\
              "aliquam.\n"\
              "Vestibulum interdum sem odio, at consectetur leo gravida"\
              "sed. Nam aliquet neque ac pretium egestas. Nam semper"\
              "finibus nisl, vel vehicula magna laoreet ac. Fusce luctus"\
              "nulla vitae mauris pulvinar fermentum sed nec felis. Integer"\
              "eget neque sed velit ullamcorper tempus nec sed augue." }

    after(:build) do |testimonial|
      testimonial.image.attach(
        io: File.open(Rails.root.join('spec', 'images', 'butter.png')),
        filename: 'butter.png',
        content_type: 'image/png'
      )
    end
  end
end
