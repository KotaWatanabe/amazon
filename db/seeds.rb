# # This file should contain all the record creation needed to seed the database with its default values.
# # The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
# #
# # Examples:
# #
# #   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
# #   Character.create(name: 'Luke', movie: movies.first)
# PASSWORD = "supersecret"


# Product.delete_all
# User.delete_all
# Review.delete_all

# 10.times do
#     first_name = Faker::Name.first_name
#     last_name = Faker::Name.last_name
#     User.create(
#       first_name: first_name,
#       last_name: last_name,
#       email: "#{first_name.downcase}.#{last_name.downcase}@example.com",
#       password: PASSWORD
#     )
#   end

# users = User.all


# 200.times do
#     created_at = Faker::Date.backward(365 * 5)
#     p = Product.create(
#         title: Faker::Commerce.product_name,
#         description: Faker::Marketing.buzzwords,
#         price: Faker::Commerce.price,
#         created_at: created_at,
#         updated_at: created_at,
#         user: users.sample
#     )
#     if p.valid?
#         p.reviews = rand(0..5).times.map do
#           Review.new(body: Faker::GreekPhilosophers.quote, user: users.sample)
#         end
#       end
# end

# products = Product.all
# reviews= Review.all

# puts Cowsay.say("Generated #{ products.count } products", :ghostbusters)
# puts Cowsay.say("Generated #{ reviews.count } reviews", :stegosaurus)
# puts Cowsay.say("Generated #{ users.count } users", :beavis)

PASSWORD = 'supersecret'

Review.delete_all
Product.delete_all
User.delete_all

super_user = User.create(
  first_name: "Jon",
  last_name: "Snow",
  email: "js@winterfell.gov",
  password: PASSWORD,
  is_admin: true
)

20.times do
  created_at = Faker::Date.backward(365 * 5);
  User.create(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.email,
    password: PASSWORD
  )
end

users = User.all

200.times do
  created_at = Faker::Date.backward(365 * 5)
  p = Product.create(
    title: Faker::Commerce.product_name,
    description: Faker::Hacker.say_something_smart,
    price: Faker::Commerce.price(range = 10..400),
    created_at: created_at,
    updated_at: created_at,
    user: users.sample
  )
  if p.valid?
    p.reviews = rand(0..5).times.map do
      Review.new(body: Faker::GreekPhilosophers.quote, rating: rand(1..5), user: users.sample)
    end
  end
end

products = Product.all
reviews = Review.all

puts Cowsay.say("Generated #{products.count} products", :ghostbusters)
puts Cowsay.say("Generated #{reviews.count} reviews", :cow)
puts Cowsay.say("Generated #{users.count} users", :sheep)
puts "Login as admin with #{super_user.email} and password of '#{PASSWORD}'!"
