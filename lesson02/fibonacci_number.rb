fibonacci_numbers = [0, 1] # Задаём начальные значения

next_value = 1 # 0, 1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89 - следующее значение после "0, 1" идет 1

while next_value < 100 do
  fibonacci_numbers << next_value
  next_value = fibonacci_numbers[-2] + fibonacci_numbers[-1] # Сумма предыдущего и текущего значений
end

puts fibonacci_numbers
