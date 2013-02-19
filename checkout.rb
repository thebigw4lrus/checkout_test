=begin
  * Name: Checkout 
  * Description: Checkout System
  * Input: Checkout.new(Rule.new)
  * Author: Javier A. Contreras V.
  * Date: Jan 14, 2013
=end
class Checkout
  def initialize(*rules)
    @shopping_cart = []
    @rules = rules
  end

  def scan(item)
    @shopping_cart << item
  end

  def total
    total_order = 0
    @rules.each do |rule|
      rule_totalized = rule.totalize(@shopping_cart)
      @shopping_cart.delete rule.item_id if rule_totalized > 0  
      total_order += rule_totalized
    end
    total_order
  end
  
  def clear_cart
    @shopping_cart = []  
  end
  
end



