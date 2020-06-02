Category.destroy_all
Hashtag.destroy_all
Scubo.destroy_all
User.destroy_all

# USERS
User.create!(
  nickname: "arthur-littm",
  email: "arthur@test.com",
  password: '123456')


# CATEGORIES
Category.create!(name: "🌮 Food")
Category.create!(name: "🌲 Nature")
Category.create!(name: "🍹 Drinks")
Category.create!(name: "🕺 Nightlife")
Category.create!(name: "🚴‍♂️ Exercising")
Category.create!(name: "🤳 Touristy")

# HASHTAGS
Hashtag.create!(name: "# Pork Belly")
Hashtag.create!(name: "# Beers")
Hashtag.create!(name: "# Views")
Hashtag.create!(name: "# Happy Hour")

Scubo.create!(
  name: "Hoxton 101",
  description: "They have the best pork belly in town.",
  user: User.first,
  category: Category.first,
  hashtag: Hashtag.first)
