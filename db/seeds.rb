require 'faker'

def random_date(start_date, end_date)
  Time.at((end_date.to_f - start_date.to_f) * rand + start_date.to_f)
end


User.find_or_create_by!(email: "admin@example.com") do |user|
  user.password = "123456"
  user.password_confirmation = "123456"
  user.role = :admin
end

User.find_or_create_by!(email: "developer@example.com") do |user|
  user.password = "123456"
  user.password_confirmation = "123456"
  user.role = :developer
end

buyer = User.find_or_create_by!(email: "buyer@example.com") do |user|
  user.password = "123456"
  user.password_confirmation = "123456"
  user.role = :buyer
end

["Orange Curry", "Belly King"].each do |store_name|
  user = User.find_or_create_by!(email: "#{store_name.split.map { |s| s.downcase }.join(".")}@example.com") do |user|
    user.password = "123456"
    user.password_confirmation = "123456"
    user.role = :seller
  end

  Store.find_or_create_by!(name: store_name, user: user)
end


orange_curry_products = [
  "Massaman Curry",
  "Risotto with Seafood",
  "Tuna Sashimi",
  "Fish and Chips",
  "Pasta Carbonara"
]

belly_king_products = [
  "Mushroom Risotto",
  "Caesar Salad",
  "Tuna Sashimi",
  "Chicken Milanese"
]

orange_curry_products.each do |dish|
  store = Store.find_by(name: "Orange Curry")
  Product.find_or_create_by!(
    title: dish,
    store: store,
    price: 10,
    description: "produto delicioso da vovo",
    category: "massas"
  )
end

belly_king_products.each do |dish|
  store = Store.find_by(name: "Belly King")
  Product.find_or_create_by!(
    title: dish,
    store: store,
    price: 10,
    description: "produto delicioso da vovo",
    category: "massas"
  )
end

products = Product.all

30.times do
  store = Store.order("RANDOM()").first
  order = Order.create!(
    buyer: buyer,
    store: store,
    state: 'created',
    created_at: random_date(DateTime.new(2024, 5, 17), DateTime.new(2024, 6, 16))
  )

  store_products = store.products.sample(2)
  store_products.each do |product|
    OrderItem.create!(
      order: order,
      product: product,
      amount: rand(1..5),
      price: product.price
    )
  end
end

puts "Seeds criadas com sucesso!"
