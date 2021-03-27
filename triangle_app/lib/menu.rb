# frozen_string_literal: true

require_relative 'triangles'
require 'tty-prompt'

# Class for displaying menu and interacting with the user
class Menu
  def initialize
    @prompt = TTY::Prompt.new
    @triangles = Triangles.new
    @triangles.read_in_csv_data(File.expand_path('../data/triangles.csv', __dir__))
  end

  TASK = "Ваша задача добавить в меню два дополнительных пункта, соблюдая следующие условия:
* Всё взаимодействие с пользователем (ввод/вывод) должно происходить в классе Menu
* Запрещается добавлять attr_reader/attr_acceccor и создавать любые методы, возвращающие переменные экземпляра класса
* Не должно быть ошибок при проверке rubocop

1. Фильтрация по цвету границы.
  Требуется запросить у пользователя цвет границы и вывести все треугольники, удовлетворяющие условию.
  Помните, что цвет может быть введён пользователем с пробелами и без заглавной буквы, \
но «Gold», «gold», «  gold  », «GOLD» и «gOLD» – это одно и то же.
2. Вывести все прямоугольные треугольники.
  Треугольник считается прямоугольным, если у него все длины сторон положительные \
и квадрат одной стороны равен сумме квадратов двух других сторон. \
Помните, что у треугольника возможно три комбинации сторон, \
но удовлетворять свойству будет ровно одна из комбинаций."



  def show_menu
    loop do
      choice = @prompt.select('Выберите дейтвие:') do |menu|
        menu.choice '1) Общая информация', 1
        menu.choice '2) Полный список треугольников', 2
        menu.choice '3) Завершить работу', 3
        menu.choice '4) Фильтрация по цвету границы',4
        menu.choice '5) Вывести все прямоугольные треугольники',5
      end
      case choice
      when 1
        show_info
      when 2
        triangles_list
      when 3
        exit
      when 4
        filter_on_color
      when 5
        get_all_triangles
      end
    end
  end

  def triangles_list
    print @triangles
  end

  def filter_on_color
    print("Введите Цвет границы: ")
    color = String(gets).downcase #trim
    pp(color)
    print(@triangles.get_matches(color))
  end

  def get_all_triangles
    print @triangles.get_all_rectangle_triangles
  end

  def show_info
    triangle = @triangles.random_triangle
    print "Добрый день!
Вы запустили приложение для работы с треугольниками.
Список треугольников хранится в массиве @triangles_list, являющемся переменной экземпляра класса Triangles.
Каждый треугольник описывается классом Triangle. \
Он состоит из трёх вершин, описывающихся структурой Point, цвета границы и заливки, нескольких вычисляемых полей.
Инициализация данных происходит из файла data/triangles.csv.
На данный момент файл содержит #{@triangles.number_of_triangles} треугольников
Случайний треугольник: #{triangle}
Его периметр: #{triangle.perimeter.floor(2)}, площадь: #{triangle.area.floor(2)}
--------------------
#{TASK}
\n"
  end
end
