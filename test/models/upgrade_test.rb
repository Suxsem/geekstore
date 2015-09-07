require 'test_helper'

class UpgradeTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  
  def setup
    @product = products(:test_product)
    @upgrade = Upgrade.new(name: "Example upgrade", price: 0, product: @product)
  end
  
  test "should be valid" do
    assert @upgrade.valid?
  end
  
  test "name should be present" do
    @upgrade.name = "     "
    assert_not @upgrade.valid?
  end
  
  test "price should be present" do
    @upgrade.price = nil
    assert_not @upgrade.valid?
  end
  
  test "product should be present" do
    @upgrade.product = nil
    assert_not @upgrade.valid?
  end  
  
  test "name should not be too long" do
    @upgrade.name = "a" * 151
    assert_not @upgrade.valid?
  end  
  
  test "name should be unique for the same product" do
    duplicate_upgrade = @upgrade.dup
    @upgrade.save
    assert_not duplicate_upgrade.valid?
  end
  
  test "orders should be removed if upgrade is removed" do
    @order = orders(:test_order)
    assert_difference '@order.upgrades.count' do
      @order.upgrades << @upgrade
    end
    assert_difference 'Order.count', -1 do
      @upgrade.destroy
    end
  end
  
end
