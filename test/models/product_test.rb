require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  
  def setup
    @category = categories(:test_category)
    @product = Product.new(name: "Computer", category: @category, price: 0, stores: [stores(:test_store)])
  end

  test "should be valid" do
    assert @product.valid?
  end

  test "category id should be present" do
    @product.category = nil
    assert_not @product.valid?
  end
  
end
