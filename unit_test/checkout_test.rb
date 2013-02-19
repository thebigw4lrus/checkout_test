=begin
  * Name: CheckoutTest 
  * Description: Checkout Unit Tests
  * Author: Javier A. Contreras V.
  * Date: Jan 14, 2013
=end 
require 'test/unit'
require '../checkout'
require '../rules'
require '../product'

class CheckoutTest < Test::Unit::TestCase
  #This list of constants represents the products wich we are going to use for 
  #configure the rules. 
  PRODUCT_FR1 = Product.new("FR1", 3.11)
  PRODUCT_SR1 = Product.new("SR1", 5.00)
  PRODUCT_CF1 = Product.new("CF1", 11.23)
  
  def test_should_totalize_zero_to_empty_shopping_cart_and_no_rule
    checkout = Checkout.new()
    assert_equal 0, checkout.total
  end
  
  #Declare the Product itself as a Single Rule is a must for scan it.
  def test_should_totalize_zero_with_items_and_no_rules
    checkout = Checkout.new()
    checkout.scan "FR1"
    checkout.scan "SR1"
    #It is zero because there is no ProductRule declared for those items
    assert_equal 0, checkout.total
  end

  def test_should_totalize_zero_empty_shopping_cart_but_with_rules
    checkout = Checkout.new(ProductRule.new(PRODUCT_FR1), 
                            ProductRule.new(PRODUCT_SR1))
    assert_equal 0, checkout.total
  end
  
  def test_should_totalize_scan_products_basic
    checkout = Checkout.new(ProductRule.new(PRODUCT_FR1), 
                            ProductRule.new(PRODUCT_SR1))
    checkout.scan "FR1"
    checkout.scan "SR1"
    assert_equal 8.11, checkout.total
  end
  
  def test_should_totalize_scan_products_bulk_purchase_strawberry
    checkout = Checkout.new(DiscountBulkPurchaseRule.new(PRODUCT_SR1,3, 4.50),
                            ProductRule.new(PRODUCT_FR1), 
			    ProductRule.new(PRODUCT_SR1),
                            ProductRule.new(PRODUCT_CF1))
    checkout.scan "SR1"
    checkout.scan "SR1"
    checkout.scan "SR1"
    checkout.scan "FR1"
    assert_equal 16.61, checkout.total
  end
  
  
  def test_should_totalize_scan_products_buy_one_get_another_free_fruit_tea
     checkout = Checkout.new(DiscountBOGAFRule.new(PRODUCT_FR1),
                            ProductRule.new(PRODUCT_FR1), 
			    ProductRule.new(PRODUCT_SR1),
                            ProductRule.new(PRODUCT_CF1))
    checkout.scan "FR1"
    checkout.scan "FR1"
    checkout.scan "CF1"
    checkout.scan "SR1"
    assert_equal 19.34, checkout.total
  end
  
  def test_should_get_the_same_result_if_the_scan_gets_shuffle
    checkout = Checkout.new(DiscountBOGAFRule.new(PRODUCT_FR1), 
                            DiscountBulkPurchaseRule.new(PRODUCT_SR1,3, 4.50),
                            ProductRule.new(PRODUCT_FR1), 
			    ProductRule.new(PRODUCT_SR1),
                            ProductRule.new(PRODUCT_CF1))
    
    scan_array = ["SR1", "SR1", "SR1", "FR1"]
    result_array = []
    iterations_to_test = 5
    1.upto(iterations_to_test).each do |rule|
      scan_array.shuffle!
      scan_array.map{|item| checkout.scan item}
      result_array << checkout.total
      checkout.clear_cart
    end
    assert_equal iterations_to_test, result_array.count(result_array[0])
  end
  
  
end