require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do

    it 'saves a product when all required fields are set' do
      @category = Category.create!(name: "my_category")
      @product = Product.create!(name: "my_product", category_id: @category.id, quantity: 3, price_cents: 999)
      expect(Product.count).to eq(1) 
    end

    it "doesn't save a product when the name field is missing" do
      @category = Category.create!(name: "my_category")
      @product = Product.create(name: nil, category_id: @category.id, quantity: 3, price_cents: 999)
      expect(@product.errors.full_messages).to include("Name can't be blank") 
    end
    it "doesn't save a product when the category field is missing" do
      @category = Category.create!(name: "my_category")
      @product = Product.create(name: "my_product", category_id: nil, quantity: 3, price_cents: 999)
      expect(@product.errors.full_messages).to include("Category can't be blank") 
    end
    it "doesn't save a product when the quantity field is missing" do
      @category = Category.create!(name: "my_category")
      @product = Product.create(name: "my_product", category_id: @category.id, quantity: nil, price_cents: 999)
      expect(@product.errors.full_messages).to include("Quantity can't be blank") 
    end
    it "doesn't save a product when the price field is missing" do
      @category = Category.create!(name: "my_category")
      @product = Product.create(name: "my_product", category_id: @category.id, quantity: 3, price_cents: nil)
      expect(@product.errors.full_messages).to include("Price cents is not a number") 
    end
  end
end
