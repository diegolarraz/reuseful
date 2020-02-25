
require 'faker'
require 'open-uri'

Exchange.destroy_all
Item.destroy_all
User.destroy_all


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
end

puts "Created the users! Creating the items..."

12.times do
  item_attr = {
    name: Faker::House.furniture,
    description: Faker::TvShows::TheFreshPrinceOfBelAir.quote,
    category: Item::CATEGORIES.sample,
    user: User.all.sample
  }
  item = Item.new(item_attr)

  file = URI.open("https://picsum.photos/400/300.jpg")
  item.pictures.attach(io: file, filename: "#{item.id}.jpg", content_type: 'image/jpg')
  file = URI.open("https://picsum.photos/400/300.jpg")
  item.pictures.attach(io: file, filename: "#{item.id}.jpg", content_type: 'image/jpg')
  begin
    item.save!
  rescue
    puts "SKIPPED"
    next
  end
  puts "ITEM CREATED"
end
puts 'Items created!'
