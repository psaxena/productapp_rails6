require "rails_helper"

RSpec.describe "Products", type: :request do
  describe "GET /products" do
    it "should return products list" do
      get "/products"
      expect(response).to have_http_status(200)
    end
  end

  describe "POST /products" do
    it "should not create a new product with invalid params" do
      headers = { "ACCEPT" => "application/json" }
      post "/products", :params => { :product => { :name => "My invalid product" } }, :headers => headers

      expect(response.content_type).to eq("application/json; charset=utf-8")
      expect(response).to have_http_status(:unprocessable_entity)
    end

    it "should create new product" do
      # send a POST request to /products, with these parameters
      headers = { "ACCEPT" => "application/json" }
      post "/products", :params => { :product => { :name => "New Product", :price => "123.45" } }, :headers => headers

      # response should have HTTP Status 201 Created
      expect(response.status).to eq(201)

      json = JSON.parse(response.body).deep_symbolize_keys

      # check the value of the returned response hash
      expect(json[:name]).to eq("New Product")
      expect(json[:price]).to eq("123.45 USD")

      # 1 new product record is created
      expect(Product.count).to eq(1)

      # Optionally, you can check the latest record data
      expect(Product.last.name).to eq("New Product")
    end
  end

  describe "PUT /products/:id" do
    let!(:product) { Product.create(name: "New Product", price: "249") }

    it "should give error while updating a non existing products" do
      # # send put request to /products/:id
      # headers = { "ACCEPT" => "application/json" }
      # put "/products/#{12345}", :params => { :product => { :name => "", :price => "123.45" } }, :headers => headers

      # # response should have HTTP Status 200 OK
      # expect(response.status).to eq(404)
    end

    it "should give error while updating an existing product with invalid attributes" do
      # send put request to /productss/:id
      headers = { "ACCEPT" => "application/json" }
      put "/products/#{product.id}", :params => { :product => { :name => "", :price => "123.45" } }, :headers => headers

      # response should have HTTP Status 200 OK
      expect(response.status).to eq(422)

      # response should contain JSON of the updated object
      json = JSON.parse(response.body).deep_symbolize_keys
      # check the value of the returned response hash
      expect(json[:name]).to eq(["can't be blank"])
    end

    it "should update an existing product" do
      # send put request to /productss/:id
      headers = { "ACCEPT" => "application/json" }
      put "/products/#{product.id}", :params => { :product => { :name => "New Product updated", :price => "123.45" } }, :headers => headers

      # response should have HTTP Status 200 OK
      expect(response.status).to eq(200)

      # response should contain JSON of the updated object
      json = JSON.parse(response.body).deep_symbolize_keys
      # check the value of the returned response hash
      expect(json[:name]).to eq("New Product updated")
      expect(json[:price]).to eq("123.45 USD")

      # The products title and url should be updated
      expect(product.reload.name).to eq("New Product updated")
      expect(product.reload.price).to eq(0.12345e3)
    end
  end

  describe "DELETE /product/:id" do
    #Create a product before delete oprtaion

    let!(:product) { Product.create(name: "New Product", price: "249") }
    it "should return products list" do
      delete "/products/#{product.id}"
      # response should have HTTP Status 404 Not found
      expect(response.status).to eq(200)

      # The products active should set to false
      expect(product.reload.active).to be false
    end
  end
end
