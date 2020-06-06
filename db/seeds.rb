Category.destroy_all
Hashtag.destroy_all
Item.destroy_all
User.destroy_all
puts "Cleaned up DB 🧹"

# USERS
User.create!(
  nickname: "arthur-littm",
  email: "arthur@test.com",
  password: '123456')

users = []

10.times do
  users << User.create!(
  nickname: Faker::Internet.username,
  email: Faker::Internet.free_email,
  password: '123456',
  github_avatar: Faker::LoremPixel.image(size: "50x50"))
end

puts "Created users 🕺"

# CATEGORIES
food = Category.create!(name: "Food", emoji: '🌮')
nature = Category.create!(name: "Nature", emoji: '🌲')
drinks = Category.create!(name: "Drinks", emoji: '🍹')
nightlife = Category.create!(name: "Nightlife", emoji: '🕺')
exercising = Category.create!(name: "Exercising", emoji: '🚴‍♂️')
touristy = Category.create!(name: "Touristy", emoji: '🤳')

categories = [food, nature, drinks, nightlife, exercising, touristy]
puts "Created categories 🌮"

# HASHTAGS
pork = Hashtag.create!(name: "# Pork Belly")
beers = Hashtag.create!(name: "# Beers")
views = Hashtag.create!(name: "# Views")
friday = Hashtag.create!(name: "# Friday")

hashtags = [pork, beers, views, friday]
puts "Created hashtags 🤳"

30.times do
  Item.create!(
    name: Faker::Restaurant.name,
    description: Faker::Restaurant.description[0..150],
    address: Faker::Address.full_address,
    user: User.first,
    category: Category.first,
    hashtag: Hashtag.first)
end
puts "Created items 🌲"
puts "Finished 🚀"
