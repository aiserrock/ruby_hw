def main
  puts 'I am working!'
  puts "My arguments are: #{ARGV}"
  p ARGV # See them like Ruby sees them.
  if ARGV.first.nil?
    puts "Приложение эмитирует игру на рынке. Передайте стартовый капитал и количество дней в качестве аргументов приложения.\n\n market_game.rb CAPITAl DAYS"
  else
  market_game(ARGV[0].to_i, ARGV[1].to_i )
  end
end

def market_game(capital,days)
  unless validator(capital)
    return
  end
  unless validator(days)
    return
  end
  capital = validator(capital)
  days = validator(days)
  days.times do |value|
    puts "day #{value +1 } #####################"
    randval = rand(15)
    case randval
    when randval > 14
      capital = capital*1.1
    when randval > 12
      capital = capital*1.02
    when randval > 9
      capital = capital
    when randval > 7
      capital = capital*0.98
    when randval > 5
      capital = capital*0.9
    else
      capital = capital * 0.5
    end
    puts "Текущее состояние счета : #{capital}"
  end
end

def validator (string)
  if string.nil?
    puts "input nothing;error"
    return false
  elsif string.to_i < 0
    puts "negative input; error"
    return false
  end
  string.to_i
end

# Keep it in the bottom of the file
if __FILE__ == $0
  main
end
