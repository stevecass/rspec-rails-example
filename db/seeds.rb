require 'factory_girl_rails'
require 'faker'
User.delete_all
Post.delete_all
FactoryGirl.create :user, :email => "admin@example.com", password:'123456'
10.times do
  Post.create!(title:Faker::Commerce.product_name, content: Faker::Lorem.paragraph)

end