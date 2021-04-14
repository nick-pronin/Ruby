monthes = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

feb_leap_year = 29

puts "Введите число:"
day_of_month = gets.to_i

puts "Введите месяц:"
number_of_month = gets.to_i

puts "Введите год:"
year = gets.to_i

monthes[1] = feb_leap_year if year % 4 == 0 && (year % 400 == 0 || year % 100 != 0)


index_number_of_day = monthes.take(number_of_month - 1).sum(day_of_month)

puts "Порядковый номер даты #{index_number_of_day}"
