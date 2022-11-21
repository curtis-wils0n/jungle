require 'rails_helper'

RSpec.describe Product, type: :model do
  
  describe 'Validations' do

    it 'is valid when all fields are filled' do
      @product = Product.new
      @category = Category.new
      
      @product.name = 'Test Product'
      @product.category = @category
      @product.price_cents = 1234
      @product.quantity = 100

      expect(@product.valid?).to be true
    end
    
    it 'has a name' do
      @product = Product.new
      @category = Category.new

      @product.name = nil # invalid
      @product.category = @category
      @product.price_cents = 123456789
      @product.quantity = 100

      @product.valid?
      expect(@product.errors.full_messages).to include("Name can't be blank")

      @product.name = 'Test Product'
      
      @product.valid?
      expect(@product.errors.full_messages).to be_empty
    end

    it 'has a price' do
      @product = Product.new
      @category = Category.new

      @product.name = 'Test Product'
      @product.category = @category
      @product.price_cents = nil  # invalid
      @product.quantity = 100

      @product.valid?
      expect(@product.errors.full_messages).to include("Price can't be blank")

      @product.price_cents = 123456789

      @product.valid?
      expect(@product.errors.full_messages).to be_empty
    end

    it 'has a quantity' do
      @product = Product.new
      @category = Category.new

      @product.name = 'Test Product'
      @product.category = @category
      @product.price_cents = 123456789
      @product.quantity = nil # invalid

      @product.valid?
      expect(@product.errors.full_messages).to include("Quantity can't be blank")

      @product.quantity = 100

      @product.valid?
      expect(@product.errors.full_messages).to be_empty
    end

    it 'has a category' do
      @product = Product.new
      @category = Category.new

      @product.name = 'Test Product'
      @product.category = nil # invalid
      @product.price_cents = 123456789
      @product.quantity = 100

      @product.valid?
      expect(@product.errors.full_messages).to include("Category can't be blank")

      @product.category = @category

      @product.valid?
      expect(@product.errors.full_messages).to be_empty
    end

  end

end
