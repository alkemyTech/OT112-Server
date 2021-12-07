# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# seed acivity
activities = [
  # ["name", "conent"]
  ["activity number 1", "content activity number 1"],
  ["activity number 2", "content activity number 2"],
  ["activity number 3", "content activity number 3"],
  ["activity number 4", "content activity number 4"],
  ["activity number 5", "content activity number 5"],
  ["activity number 6", "content activity number 6"],
  ["activity number 7", "content activity number 7"]
]

activities.each do |name, content|
  Activity.create(name: name, content: content)
end