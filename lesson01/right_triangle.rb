puts "Введите значения сторон треугольника:"
first_side = gets.chomp.to_i
second_side = gets.chomp.to_i
third_side = gets.chomp.to_i

if first_side > second_side && first_side > third_side # Поиск максимального значения сторон. Ниже аналогично
  hypotenuse = first_side == Math.sqrt(second_side**2 + third_side**2) # Если квадрат максимальной стороны равен сумме квадратов других сторон, то hypotenuse = true
elsif second_side > first_side && second_side > third_side
  hypotenuse = second_side == Math.sqrt(first_side**2 + third_side**2)
else
  hypotenuse = third_side**2 == Math.sqrt(first_side**2 + second_side**2)
end

if hypotenuse
  puts "Треугольник прямоугольный"
elsif first_side == second_side && first_side == third_side
  puts "Треугольник равносторонний"
elsif (first_side == second_side || second_side == third_side) || first_side == third_side
  puts "Треугольник равнобедренный"
else
  puts "Треугольник не является ни прямоугольниым, ни равносторонним, ни равнобедренным"
end
