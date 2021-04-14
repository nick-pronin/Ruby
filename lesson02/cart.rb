cart = {}
puts "Введите наименование товара или слово стоп для окончания ввода покупок"
product = gets.chomp
while (product.upcase || product)!= "СТОП"
  puts "Введите цену за единицу товара"
  product_price = gets.to_f
  puts "Введите кол-во товара"
  product_count = gets.to_f
  cart[product] = { price: product_price, quantity: product_count }
  puts "Введите наименование товара или слово стоп для окончания ввода покупок"
  product = gets.chomp
end
total_cost = 0
cart.each do |name, amount|
  cost = amount[:price] * amount[:quantity]
  total_cost += cost
  puts "Продукт: #{name}, цена: #{amount[:price]}, кол-во: #{amount[:quantity]} стоимость #{cost}"
end

puts "Итоговая стоимость товаров в корзине: #{total_cost}"
