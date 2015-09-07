require 'test_helper'

class OrderTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  
  def setup
    @user = users(:test_user)
    @product = products(:test_product)
    @upgrade = upgrades(:test_upgrade)
    @order = Order.new(user: @user, product: @product, upgrades: [@upgrade])
  end
  
  test "should be valid" do
    assert @order.valid?
  end
  
  test "user should be present" do
    @order.user = nil
    assert_not @order.valid?
  end
  
  test "product should be present" do
    @order.product = nil
    assert_raises(Exception) do
      @order.valid?
    end
  end

  test "final price should be valid" do
    @order.valid?
    assert_operator @order.price, :>=, 0
  end
  
end
