# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# User.create!(
#   name: 'admin_master',
#   email: 'admin@example.com',
#   password: 'adminadmin',
#   admin: true,
# )

labels = [
  { name: 'red' },
  { name: 'green' },
  { name: 'blue' },
  { name: 'yellow' }
]
Label.create! labels

# i18nの切り替えが面倒なので自作のシードデータを上記で少し生成します
# 10.times do |n|
#   name = Faker::Games::Pokemon.name
#   email = Faker::Internet.email
#   password = "password"
#   User.create!(name: name,
#                email: email,
#                password: password,
#                password_confirmation: password,
#                )
# end