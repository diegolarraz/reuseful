
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

10.times do
  item_attr = {
    name: Faker::House.furniture,
    description: Faker::TvShows::TheFreshPrinceOfBelAir.quote,
    category: Item::CATEGORIES.sample,
    user: User.all.sample
  }
  item = Item.create!(item_attr)

  file = URI.open("https://picsum.photos/400/300.jpg")
  item.pictures.attach(io: file, filename: "#{item.id}.jpg", content_type: 'image/jpg')

  file = URI.open("https://picsum.photos/400/300.jpg")
  item.pictures.attach(io: file, filename: "#{item.id}.jpg", content_type: 'image/jpg')

  # # first_file = URI.open("https://i.picsum.photos/id/#{range.sample}/400/300.jpg")
  # # second_file = URI.open("https://i.picsum.photos/id/#{range.sample}/400/300.jpg")

  # # first_file = Cloudinary::Uploader.upload("https://res.cloudinary.com/annedj/image/upload/v1582644229/Reuseful/Samples/#{i}.jpg")
  # # second_file = Cloudinary::Uploader.upload("https://res.cloudinary.com/annedj/image/upload/v1582644229/Reuseful/Samples/#{i + 1}.jpg")

  # item.pictures = ["https://res.cloudinary.com/annedj/image/upload/v1582644229/Reuseful/Samples/#{i}.jpg", "https://res.cloudinary.com/annedj/image/upload/v1582644229/Reuseful/Samples/#{i + 1}.jpg"]
  # i += 2
end

puts 'Items created!'
