def find_item_by_name_in_collection(name, collection)
  counter=0
  while counter < collection.length
    if collection[counter][:item]== name
      return collection[counter]
    end
    counter += 1
  end
end
def consolidate_cart(cart)
  new_cart=[]
  counter=0
  while counter < cart.length
    new_cart_item = find_item_by_name_in_collection(cart[counter][:item],new_cart)
    if new_cart_item != nil
      new_cart_item[:count] += 1
    else
      new_cart_item = {
        :item => cart[counter][:item],
        
      }
end

def apply_coupons(cart, coupons)
items_in_the_cart = {
    "AVOCADO" => {:price => 3.0, :clearance => true, :count => 3},
    "KALE"    => {:price => 3.0, :clearance => false, :count => 1}
  }
  item_in_the_coupon = [{:item => "AVOCADO", :num => 2, :cost => 5.0}]
  the_expected_outcome = {
    "AVOCADO" => {:price => 3.0, :clearance => true, :count => 1},
    "KALE"    => {:price => 3.0, :clearance => false, :count => 1},
    "AVOCADO W/COUPON" => {:price => 5.0, :clearance => true, :count => 1},
  }
  coupons.each do |coupon|
    name = coupon[:item]
    if cart[name] && cart[name][:count] >= coupon[:num]
      if cart["#{name} W/COUPON"]
        cart["#{name} W/COUPON"][:count] += 1
      else
        cart["#{name} W/COUPON"] = {:count => 1, :price => coupon[:cost]}
        cart["#{name} W/COUPON"][:clearance] = cart[name][:clearance]
      end
      cart[name][:count] -= coupon[:num]
    end
  end
  return cart
end

def apply_clearance(cart)
    cart.collect do |item, item_description|
    if item_description[:clearance] == true
      # 20% of something, multiply by 20%, get a number, then subtract it from original
      twenty_percent = item_description[:price] * 0.2
      item_description[:price] -= twenty_percent
    end
  end
  cart
end

def checkout(cart, coupons)
  cart_1 = consolidate_cart(cart: cart)
  # cart_1["BEETS"][:price]
  cart_2 = apply_coupons(cart: cart_1, coupons: coupons)
  cart_3 = apply_clearance(cart: cart_2)
  # coupon_1 = coupons
  total = 0
  cart_3.each do |name, properties|
     total += properties[:price] * properties[:count]
   end
   total = total * 0.9 if total > 100
   total
end
end
