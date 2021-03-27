# frozen_string_literal: true

require_relative 'clients_store'

def main
  store = ClientsStore.new

  return unless read_store(store)

  user_inp = 0

  loop do
    print_menu
    user_inp = action

    begin
      case user_inp
      when 1
        add_user_a(store)
      when 2
        remove_user_a(store)
      when 3
        find_a(store)
      when 4
        puts store.group_by_plan
      when 5
        plan_info_a(store)
      when 6
        puts store.statistic
      when 7
        return
      else
        puts 'Некорректный номер, введите от 1 до 7'
      end
    rescue StandardError => e
      puts "Ошибка: #{e}"
    end
  end
end

# Get user input action
def action
  Integer(gets)
rescue StandardError
  0
end

# Read store from file
def read_store(store)
  store.read_clients_json('clients.json')
  true
rescue StandardError
  puts 'Ошибка чтения файла'
  false
end

# Add a client to store
def add_user_a(store)
  print 'Введите имя клиента: '
  name = gets
  print 'Введите фамилию клиента: '
  last = gets
  print 'Введите план из предложенных: '
  puts store.plan_names.join(' ')
  plan = gets
  store.add_client(name, last, plan)
  put_sep
end

# Remove a client from store
def remove_user_a(store)
  print 'Введите телефон клиента: '
  phone = gets
  store.remove_client(phone.strip)
  puts 'Удален!'
end

def plan_info_a(store)
  puts "Введите название тарифа из следующих: #{store.plan_names.join(' ')}"
  plan = gets
  puts store.calculate_by_plan(plan.strip)
end

def find_a(store)
  print 'Введите номер телефона или фамилию: '
  s = gets
  puts "Найден: #{store.search(s.strip)}"
end

# Print separator for actions
def put_sep
  puts '--------'
end

# Print menu for user
def print_menu
  puts '1. Добавить абонента'
  puts '2. Удалить абонента'
  puts '3. Найти абонента по номеру телефона или фамилии'
  puts '4. Вывести список всех абонентов'
  puts '5. Расчёт оплаты по тарифу за месяц'
  puts '6. Статистика за месяц'
  puts '7. Выход'
  print 'Введите действие: '
end

main
