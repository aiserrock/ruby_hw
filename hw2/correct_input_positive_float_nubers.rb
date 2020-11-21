def main
  count_correct = 0
  count_incorrect = 0
  puts 'I am working!'
  puts "My arguments are: #{ARGV}"
  puts "Приложение cчитает кол-во правильного и неправильного ввода вещественного положительного числа.Для выхода напишите 99.999"
  while true
    print "Введите данные >"
    data = gets
    #Trap for ctrl-z
    unless data
      print_exit_info(count_correct,count_incorrect)
      break
    end
    if data == "99.999"
      print_exit_info(count_correct,count_incorrect)
      break
    end
    begin
    data = Integer(data)
    if data <=0
      puts "incorrect input :'number <=0'"
      count_incorrect +=1
    else
      puts "correct input!!! >#{data}"
      count_correct +=1
    end
    rescue ArgumentError
      puts "incorrect input :'number with trash'"
    end
  end
end

def print_exit_info(count_correct,count_incorrect)
  puts "count correct input:#{count_correct}"
  puts "count incorrect input:#{count_incorrect}"
end


# Keep it in the bottom of the file
if __FILE__ == $0
  main
end



