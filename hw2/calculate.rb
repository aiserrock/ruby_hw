def main
  amount = 0.0
  puts 'I am working!'
  puts "My arguments are: #{ARGV}"
  puts "Приложение калькулятор, складывает вещественные числа.Для выхода напишите over"
  while true
    print "Введите данные >"
    data = gets
    #Trap for ctrl-z
    break unless data
    if data == "over"
      break
    end
    data = Float(data)
    amount += data
    puts data
    puts amount
  end
end


# Keep it in the bottom of the file
if __FILE__ == $0
  main
end


