def main
  puts 'I am working!'
  puts "My arguments are: #{ARGV}"
  p ARGV # See them like Ruby sees them.
  if ARGV.first.nil?
    puts "Данное приложение производит проверку числа. Передайте число в качестве первого аргумента"
  else
    check_number(ARGV.first.to_i)
  end
end

def check_number(number)
  if number > 0
    puts "положительное число"
  elsif number < 0
    puts "не положительное, а отрицательное число"
  else
    puts "непонятное число"
  end
end

# Keep it in the bottom of the file
if __FILE__ == $0
  main
end