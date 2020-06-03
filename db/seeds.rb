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
Category.create!(name: "Food", emoji: '🌮')
Category.create!(name: "Nature", emoji: '🌲')
Category.create!(name: "Drinks", emoji: '🍹')
Category.create!(name: "Nightlife", emoji: '🕺')
Category.create!(name: "Exercising", emoji: '🚴‍♂️')
Category.create!(name: "Touristy", emoji: '🤳')

# HASHTAGS
Hashtag.create!(name: "# Pork Belly")
Hashtag.create!(name: "# Beers")
Hashtag.create!(name: "# Views")
Hashtag.create!(name: "# Happy Hour")

Scubo.create!(
  name: "Hoxton 101",
  description: "They have the best pork belly in town.",
  address: "100 Hoxton St, Hackney, London N1 6SG",
  user: User.first,
  category: Category.first,
  hashtag: Hashtag.first)
