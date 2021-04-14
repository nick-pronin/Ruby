puts "Приветствую! Как тебя зовут?"
name = gets.chomp
puts "#{name}, я помогу тебе узнать твой идеальный вес! Введи свой рост в сантиметрах:"
height = gets.chomp.to_i

ideal_weight = (height - 110) * 1.15

if ideal_weight <= 0
  puts "Твой вес уже оптимален"
else
  puts "Твой идеальный вес равен #{ideal_weight}"
end
