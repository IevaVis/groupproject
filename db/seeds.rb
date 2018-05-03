# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
url = 'https://newsapi.org/v2/top-headlines?'\
      'country=us&'\
      'apiKey=fa9620e77f344cceb6b27bc271353aa8'
req = open(url)
response_body = req.read
response_body_json = JSON.parse response_body

tags = ["Democracy", "North Korea", "Immigration", "Trump", "America", "European Union", "Economics", "Foreign Policy", "Mexico", "Kuala Lumpur", "Malaysia", "Police", "Law Enforcement", "Technology", "Data Security", "Slander", "Media Transparency", "Military", "Republican", "Election", "Literature", "College", "Education"]

users = User.all

ActiveRecord::Base.transaction do
  response_body_json["articles"].each do |article|
    Article.create!(
      user_id: users[rand(0...users.length)].id,
      title: article["title"],
      link: article["url"],
      image: article["urlToImage"],
      is_active: false,
      tags: [tags[rand(0...tags.length)], tags[rand(0...tags.length)], tags[rand(0...tags.length)], tags[rand(0...tags.length)]]
    )
  end
end
