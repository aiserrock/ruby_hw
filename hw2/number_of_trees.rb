def main
  count_trees = 0
  puts 'I am working!'
  puts "My arguments are: #{ARGV}"
  puts "Приложение cчитает кол-во слов дерево в строке.Для выхода напишите:'конец'"
  while true
    print "Введите данные >"
    data = gets
    #Trap for ctrl-z
    unless data
      print_exit_info(count_trees)
      break
    end
    data = data.encode('UTF-8')
    if data == "конец"
      print_exit_info(count_trees)
      break
    end
    for elem in data.split(" ")
      if elem == "дерево"
        count_trees += 1
      end
    end
  end
end

def print_exit_info(count_trees)
  puts "count trees:#{count_trees}"
end


# Keep it in the bottom of the file
if __FILE__ == $0
  main
end



