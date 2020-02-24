
require 'faker'

puts 'Creating the users...'

5.times do
  attributes = {
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    password: Faker::Internet.password(min_length: 8, mix_case: true, special_characters: true),
    location: Faker::Address.street_address,
    email: Faker::Internet.email
  }
  user = User.create!(attributes)

  2.times do
    item_attr = {
      name: Faker::House.furniture,
      description: Faker::TvShows::TheFreshPrinceOfBelAir.quote,
      category: Item::CATEGORIES.sample,
      user: user
    }
    Item.create!(item_attr)
  end
end

puts 'Users and items created!'

