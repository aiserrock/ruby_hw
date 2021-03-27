# frozen_string_literal: true

require_relative 'triangles_store'

def main
  store = TrianglesStore.new

  begin
    store.read_triangles_json('triangles.json')
  rescue _
    puts 'Ошибка чтения файла'
    return
  end

  user_inp = 0

  while user_inp != 11
    print_menu
    user_inp = Integer(gets)
    case user_inp
    when 1
      print_a store
    when 2
      puts 'Не реализовано'
    when 3
      puts 'Не реализовано'
    when 4
      perim_a store
    when 5
      puts 'Не реализовано'
    when 6
      in_rect_a store
    when 7
      sort_sq_a store
    when 8
      sort_b_l store
    when 9
      store.find_shared_pairs
      put_sep
    when 10
      color_stat store
    else
      puts 'Некорректный номер, введите от 1 до 11'
    end

  end
end

# Print triangles
def print_a(store)
  puts store.triangles.join("\n")
  put_sep
end

# Show triangles which requires perim range
def perim_a(store)
  print 'Введите верхнюю границу периметра: '
  top = Integer(gets)
  print 'Введите нижнюю границу периметра: '
  bottom = Integer(gets)
  t = store.triangles.select do |tr|
    p = tr.take_p
    bottom <= p and p <= top
  end
  puts t.join("\n")
  put_sep
end

# Check how many triangles in rect
def in_rect_a(store)
  print 'Введите координату x: '
  x = Integer(gets)
  print 'Введите координату y: '
  y = Integer(gets)
  print 'Введите ширину: '
  width = Integer(gets)
  print 'Введите высоту: '
  height = Integer(gets)
  puts "Подходит #{store.c_in_rect(x, y, width, height)} треугольников"
  put_sep
end

# Sorting by square
def sort_sq_a(store)
  t = store.triangles.sort { |t1, t2| t1.sqr <=> t2.sqr }
  puts t.join("\n")
  put_sep
end

# Sort triangles by left-down point
def sort_b_l(store)
  t = store.triangles.sort { |t1, t2| t1.b_l_point.to_l <=> t2.b_l_point.to_l }
  puts t.join("\n")
  put_sep
end

# Print the color statistic
def color_stat(store)
  colors = store.color_statistic
  colors.each do |color, list|
    print "Цвет: #{color}. "
    print "Граница: #{list[0]}, "
    print "Заполнение: #{list[1]}, "
    print "Точки: #{list[2]}\n\n"
  end
  put_sep
end

def put_sep
  puts '--------'
end

def print_menu
  puts '1. Список треугольников'
  puts '2. Фильтр по цвету границы'
  puts '3. Фильтр по цвету вершин'
  puts '4. Фильтр по периметру треугольника'
  puts '5. Фильтр по типу треугольника'
  puts '6. Количество треугольников внутри прямоугольника'
  puts '7. Сортировка по площади треугольника'
  puts '8. Сортировка по нижней левой вершине'
  puts '9. Поиск пар треугольников с общей вершиной'
  puts '10. Статистика по цветам'
  puts '11. Выход'
  print 'Введите действие: '
end

main
