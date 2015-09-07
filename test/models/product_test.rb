require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  
  def setup
    @category = categories(:test_category)
    @store = stores(:test_store)
    @product = Product.new(name: "Example Product", category: @category, price: 0, discount: 30, stores: [@store])
  end

  test "should be valid" do
    assert @product.valid?
  end
  
  test "name should be present" do
    @product.name = "     "
    assert_not @product.valid?
  end
  
  test "name should not be too long" do
    @product.name = "a" * 151
    assert_not @product.valid?
  end
  
  test "name should be unique" do
    duplicate_product = @product.dup
    @product.save
    assert_not duplicate_product.valid?
  end  

  test "category should be present" do
    @product.category = nil
    assert_not @product.valid?
  end
  
  test "price should be present" do
    @product.price = nil
    assert_not @product.valid?
  end
  
  test "discount should be valid" do
    @product.discount = nil
    assert_not @product.valid?
    @product.discount = 101
    assert_not @product.valid?
    @product.discount = "a"
    assert_not @product.valid?
  end  
  
  test "final price should be correct" do
    @product.price = 0
    @product.discount = 0    
    assert_equal @product.price * (100 - @product.discount) / 100, @product.final_price
    @product.price = 9.9
    @product.discount = 9.9
    assert_equal @product.price * (100 - @product.discount) / 100, @product.final_price
  end
  
end
