=begin
  * Name: CheckoutReevoTestCases 
  * Description: Checkout Unit Tests
  * Author: Javier A. Contreras V.
  * Date: Jan 14, 2013
=end 
require 'test/unit'
require '../checkout'
require '../rules'
require '../product'

class CheckoutAcceptanceTestCases < Test::Unit::TestCase
  #This list of constants represents the products wich we are going to use for 
  #configure the rules. 
  PRODUCT_FR1 = Product.new("FR1", 3.11)
  PRODUCT_SR1 = Product.new("SR1", 5.00)
  PRODUCT_CF1 = Product.new("CF1", 11.23) 
  CHECKOUT =  Checkout.new(DiscountBOGAFRule.new(PRODUCT_FR1), 
                           DiscountBulkPurchaseRule.new(PRODUCT_SR1,3, 4.50),
                           ProductRule.new(PRODUCT_FR1), 
                           ProductRule.new(PRODUCT_SR1),
                           ProductRule.new(PRODUCT_CF1))
  #I don't know if i missed something, but 
  #according the rules required, this total 
  #should be 19.34.
  def test_case_fr1_sr1_fr1_cf1
    checkout = CHECKOUT
    checkout.scan "FR1"
    checkout.scan "SR1"
    checkout.scan "FR1"
    checkout.scan "CF1"
    assert_equal 22.25, checkout.total
  end
  
  def test_case_fr1_fr1
    checkout = CHECKOUT
    checkout.scan "FR1"
    checkout.scan "FR1"
    assert_equal 3.11, checkout.total
  end

  def test_case_sr1_sr1_fr1_sr1
    checkout = CHECKOUT
    checkout.scan "SR1"
    checkout.scan "SR1"
    checkout.scan "FR1"
    checkout.scan "SR1"
    assert_equal 16.61, checkout.total
  end 
  
end
