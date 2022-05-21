# frozen_string_literal: true

indx = 1
product_names = {}
loop do
  puts "Enter the #{indx} product name (or stop):"
  product_name = gets.chomp
  break if product_name.downcase == 'stop'

  puts 'Enter the unit price:'
  price = gets.chomp.to_f
  puts 'Enter the quantity:'
  quantity = gets.chomp.to_f
  product_names[product_name] = { price => quantity }
  indx += 1
end
puts "\nShopping cart:
product   price   quantity   total amount\n\n"
grand_total = 0.0
product_names.each do |prod, price_quant|
  price_quant.each do |price, quantity|
    puts "#{prod}   #{price}   #{quantity}   #{price * quantity}"
    grand_total += price * quantity
  end
end
puts "\ngrand total:                 #{grand_total}"
