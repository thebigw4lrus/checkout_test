=begin
  * Name: Product 
  * Description: This is the product class.
  * Input: Product.new(p_id, price)
  * Author: Javier A. Contreras V.
  * Date: Jan 14, 2013
=end 
class Product
  attr_accessor :id, :price
  def initialize(product_id, price)
    self.id, self.price = product_id, price 
  end
end