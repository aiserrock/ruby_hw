def main
  puts 'I am working!'
  puts "My arguments are: #{ARGV}"
  puts "Приложение повторитель, работает со строкой.Для выхода напишите stop, please"
  while true
    print "Введите данные >"
    data = gets.strip
    data.encode('UTF-8')
    if data == "stop, please"
      break
    end
    puts data
    print data
    printf data
    p data
  end
end


# Keep it in the bottom of the file
if __FILE__ == $0
  main
end

