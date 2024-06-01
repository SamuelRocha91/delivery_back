admin = User.find_by(email: "admin@example.com")
if !admin
  admin = User.new(
    email: "admin@example.com",
    password: "123456",
    password_confirmation: "123456",
    role: :admin
    )
  admin.save!
end
["Orange Curry", "Belly King"].each do |store|
  user = User.new(
    email: "#{store.split.map { |s| s.downcase }.join(".")}@example.com",
    password: "123456",
    password_confirmation: "123456",
    role: :seller
  )
  user.save!
  Store.find_or_create_by!(name: store, user: user)
end

[
  "Massaman Curry",
  "Risotto with Seafood",
  "Tuna Sashimi",
  "Fish and Chips",
  "Pasta Carbonara"
].each do |dish|
  store = Store.find_by(name: "Orange Curry")
  Product.find_or_create_by!(
    title: dish, store: store, price: 10, description: "produto delicioso da vovo", category: "massas"
)
end

[
  "Mushroom Risotto",
  "Caesar Salad",
  "Tuna Sashimi",
  "Chicken Milanese"
].each do |dish|
  store = Store.find_by(name: "Belly King")
  Product.find_or_create_by!(
    title: dish, store: store, price: 10, description: "produto delicioso da vovo", category: "massas"
  )
end