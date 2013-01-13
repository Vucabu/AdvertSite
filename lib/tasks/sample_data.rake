namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    Role.types.each do |role|
      name = role[0]
      Role.create!(name: name)
    end

    Category.types.each do |category|
      name = category[0]
      Category.create!(name: name)
    end

    User.create!(name: "Admin",
                 email: "admin@ruby.com",
                 password: "123456",
                 password_confirmation: "123456",
                 role_id: Role.where(:name => "Admin").first.id)

    5.times do |n|
      name  = Faker::Name.name
      email = "user-#{n+1}@ruby.com"
      password  = "123456"
      User.create!(name: name,
                   email: email,
                   password: password,
                   password_confirmation: password,
                   role_id: Role.where(:name => "User").first.id)
    end
    users = User.all(limit: 5)
    category_count = Category.all.count
    #image = File.open("collage.jpeg")
    20.times do |n|
      content = Faker::Lorem.sentence(5)
      title = "Title #{n+1}"
      picture = "picture"
      city = "City #{n+1}"
      address = "str. International, #{n+1}"
      users.each do |user|
        user.adverts.create!(content: content,
                             title: title,
                             email: user.email,
                             city: city,
                             address: address,
                             #image: image,
                             category_id: n % category_count + 1)
      end
    end
  end
end