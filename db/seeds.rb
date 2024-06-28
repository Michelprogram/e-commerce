require 'faker'

#Clear
User.destroy_all
Product.destroy_all
Order.destroy_all
Buyer.destroy_all
Seller.destroy_all

#Users
password = 'password123'
10.times do
  user = User.create!(
    email: Faker::Internet.unique.email,
    password: password,
    password_confirmation: password
  )

  Buyer.create!(user: user)

  if [true, false].sample
    seller = Seller.create!(user: user)
    5.times do
      Product.create!(
        name: Faker::Commerce.product_name,
        description: Faker::Lorem.sentence,
        price: Faker::Commerce.price(range: 0..100.0),
        stock: Faker::Number.between(from: 1, to: 100),
        seller: seller
      )
    end
  end
end

# Orders
buyers = Buyer.all
products = Product.all

buyers.each do |buyer|
  3.times do
    product = products.sample
    quantity = Faker::Number.between(from: 1, to: product.stock)
    Order.create!(
      product: product,
      buyer: buyer,
      quantity: quantity,
      total_price: product.price * quantity
    )
  end
end

puts "Seed data created successfully"
