require "rails_helper"

RSpec.describe Product, type: :model do
  describe "person create" do
    it "is not valid without a name" do
      product_rec = build(:product, name: nil)
      product_rec.should_not be_valid
      expect(product_rec.errors[:name].first).to eq "can't be blank"
    end

    it "is not valid without a price" do
      product_rec = build(:product, price: nil)
      product_rec.should_not be_valid
      expect(product_rec.errors[:price].first).to eq "can't be blank"
    end

    it "is valid without description" do
      product_rec = build(:product, description: nil)
      product_rec.should be_valid
    end

    it "should have views as zaro after create" do
      product_rec = create(:product)
      product_rec.should be_valid
      expect(product_rec.views).to eq 0
    end

    it "should have active as true after create" do
      product_rec = create(:product)
      product_rec.should be_valid
      expect(product_rec.active).to be true
    end
  end

  describe "Validate views and active" do
    it "should increment views" do
      product_rec = create(:product)
      product_rec.should be_valid
      expect(product_rec.views).to eq 0
      product_rec.update_view_and_save
      expect(product_rec.views).to eq 1
    end

    it "should increment views" do
      product_rec = create(:product)
      product_rec.should be_valid
      expect(product_rec.active).to be true
      product_rec.mark_inactive
      expect(product_rec.active).to be false
    end
  end

  describe "Validate currency convertor service" do
    it "should return nil response for incorrect key" do
      product_rec = build(:product, description: nil)
      product_rec.should be_valid
      res = product_rec.get_url_resp("ABCD")
      expect(res).to be nil
    end

    it "should return valid response" do
      product_rec = build(:product, description: nil)
      product_rec.should be_valid
      res = product_rec.get_url_resp("USD_EUR")
      expect(res).not_to be nil
    end

    it "should not convert to target currency if same as source" do
      product_rec = build(:product, description: nil)
      product_rec.should be_valid
      res = product_rec.convert_currency(product_rec.price, "USD", "USD")
      expect(res).to include("USD")
    end

    it "should return convert to target currency" do
      product_rec = build(:product, description: nil)
      product_rec.should be_valid
      res = product_rec.convert_currency(product_rec.price, "USD", "EUR")
      expect(res).to include("EUR")
    end
  end
end
