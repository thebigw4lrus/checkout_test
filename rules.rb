=begin
  * Name: Rule 
  * Description: Represents the superclass for the rules.
  * Input: Rule.new(item_id:string, quantity:integer[optional], price:double[optional])
  *        If there is only 2 parameters, it will be read as > Rule.new(item_id, price), quantity will be 1 by default
  *        If there is only 1 parameter, it will be read as > Rule.new(item_id), price will be 0 as default
  * Author: Javier A. Contreras V.
  * Date: Jan 14, 2013
=end 
class Rule
  attr_accessor :item_id
  def initialize(*args)
    raise "the product object is required" if args.count == 0
    self.item_id, @price = args[0].id, args[0].price
    (args.count >= 2)? @qty = args[1].to_i : @qty = 1
    #if a third parameter is found, the class take it as the price 
    #and overrides the product price
    @price = args[2] if args.count >= 3
  end
  
  def totalize(*items)
    0
  end
end


=begin
  * Name: ProductRule 
  * Description: Every Product on the stock has to be represented using this class
  *              In other words, every product is a rule itself
  * Input: ProductRule.new(Product.new(p_id, price))
  * Author: Javier A. Contreras V.
  * Date: Jan 14, 2013
=end 
class ProductRule < Rule
  def totalize(items) 
    items.count(item_id)*@price
  end
end

=begin
  * Name: DiscountBulkPurchaseRule 
  * Description: This is a Rule Sublcass. Represent the Bulk Purchase Rule
  * Input: DiscountBulkPurchaseRule.new(Product.new(p_id, price), bulk_factor, new_price)
  * Author: Javier A. Contreras V.
  * Date: Jan 14, 2013
=end 
class DiscountBulkPurchaseRule < Rule
  def totalize(items)
    items_to_totalize = items.count(item_id)
    (items_to_totalize >= @qty)? items_to_totalize*@price : 0 
  end
end

=begin
  * Name: DiscountBOGAFRule 
  * Description: This is a Rule Sublcass. Represent the Buy-one-get-one-free rule.
  * Input: DiscountBOGAFRule.new(Product.new(p_id, price))
  * Author: Javier A. Contreras V.
  * Date: Jan 14, 2013
=end 
class DiscountBOGAFRule < Rule
  def totalize(items)
    (items.count(item_id)/2).to_i*@price
  end
end