puts "Введите коэффициент a:"
a = gets.to_i
puts "Введите коэффициент b:"
b = gets.to_i
puts "Введите коэффициент c:"
c = gets.to_i

d = (b**2 - 4 * a * c)

puts "Дискриминант равен #{d}"

if d > 0
  discriminant = Math.sqrt(d)
	x1 = (-b + discriminant) / (2 * a)
	x2 = (-b - discriminant) / (2 * a)
	puts "Корни уравнения равны #{x1} и #{x2}"
elsif c == 0
	x1 = -b / (2 * a)
	puts "Корень уравнения равен #{x1}"
else
	puts "Корней нет"
end
