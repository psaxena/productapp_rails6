require "rails_helper"

RSpec.describe "Products", type: :request do
  describe "GET /products" do
    it "should return products list" do
      get "/products"
      expect(response).to have_http_status(200)
    end
  end

  # describe "POST /products" do
  #   it "should not create a new product" do
  #     get "/products"
  #     expect(response).to have_http_status(422)
  #   end

  #   it "should create new product" do
  #     get "/products"
  #     expect(response).to have_http_status(200)
  #   end
  # end

  # describe "PUT /products/:id" do
  #   it "should give error while updating an existing products" do
  #     get "/products"
  #     expect(response).to have_http_status(200)
  #   end

  #   it "should update an existing products" do
  #     get "/products"
  #     expect(response).to have_http_status(200)
  #   end
  # end

  # describe "GET /product/:id" do
  #   it "should return products list" do
  #     get "/products"
  #     expect(response).to have_http_status(200)
  #   end
  # end
end
