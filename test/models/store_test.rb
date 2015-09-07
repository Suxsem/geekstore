require 'test_helper'

class StoreTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  
  def setup
    @store = Store.new(place: "Example place")
  end

  test "should be valid" do
    assert @store.valid?
  end
  
end
