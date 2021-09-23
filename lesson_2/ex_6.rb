product_list = {}
product_list_sum = {}
puts "Enter product name: "
until ((product_name = gets.chomp) == 'stop')
  puts "Enter price per unit:"
  product_price_per_unit = gets.chomp.to_f
  puts "Enter product volume:"
  product_volume = gets.chomp.to_f
  product_list[product_name] = {product_price_per_unit => product_volume}
  product_list_sum[product_name] = product_price_per_unit * product_volume
  puts "Enter product name: "
end
puts product_list
puts product_list_sum
puts "Total price of all items is #{product_list_sum.values.sum}"

