require 'rails_helper'

RSpec.describe "Products", type: :request do
  let(:user) { create(:user, :seller)}

  let(:admin) { create(:user, :admin)}

  let(:store) { create(:store, user: user)}

  before {sign_in(admin)}

  before { create(:product, store: store)}

  describe "GET /listing" do
    it "renders a successful response" do
      get listing_url
      expect(response). to be_successful
    end

    it "displays the product details" do
      product = create(:product, title: "Test Product", store: store)
      get listing_url(product)
      expect(response).to be_successful
      expect(response.body).to include("Test Product")
    end
  end

  describe "POST /products" do
    it "creates a new product" do
      product_params = {
        title: "New Product",
        price: 29.99,
        description: "This is a new product",
        category: "bebidas"
      }
      post store_products_url(store_id: store.id), params: { product: product_params }
      expect(response).to have_http_status(:found)
      follow_redirect!
      expect(response).to have_http_status(:ok)
      expect(Product.last.title).to eq("New Product")
      expect(Product.last.price).to eq(29.99)
      expect(Product.last.description).to eq("This is a new product")
    end

     it "does not create a new product with invalid parameters" do
      product_params = {
        title: "",
        price: 29.99,
        description: "This is a new product",
        user_id: user.id
      }

      expect {
        post store_products_url(store_id: store.id), params: { product: product_params }
      }.to_not change(Product, :count)

      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe "PUT /products/:id" do
    it "updates an existing product" do
     product = create(:product, title: "Old Product", price: 9.99, description: "This is an old product", store: store)
     product_params = {
      title: "Updated Product",
      price: 19.99,
      description: "This is an updated product"
      }
      put store_product_url(store_id: store.id, id: product.id), params: { product: product_params }
      expect(response).to have_http_status(:found) 
      follow_redirect!
      expect(response).to have_http_status(:ok) #
      expect(product.reload.title).to eq("Updated Product")
    end

    it "does not update a product with invalid parameters" do
      product = create(:product, title: "Old Product", price: 9.99, description: "This is an old product", store: store )
      product_params = {
        title: "",
        price: 19.99,
        description: "This is an updated product"
      }
       put store_product_url(store_id: store.id, id: product.id), params: { product: product_params }
       expect(response).to have_http_status(:unprocessable_entity)
       expect(Product.find(product.id).title).to eq("Old Product") 
    end
  end

    describe "DELETE /products/:id" do
      it "deletes an existing product" do
        product = create(:product, store: store)
        delete store_product_url(store_id: store.id, id: product.id)
        expect(response).to have_http_status(:found) 
        follow_redirect!
        expect(response).to have_http_status(:ok) 
        expect(Product.find(product.id).discarded?).to be true
      end
    end
  
end