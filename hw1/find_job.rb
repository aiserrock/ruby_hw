require 'optparse'

def main
  puts 'I am working!'
  puts "My arguments are: #{ARGV}"
  p ARGV # See them like Ruby sees them.
  if ARGV.first.nil? or ARGV.first === "--help"
    puts "Приложение подбирает работу для вас на основании введённых данных find_job.rb" \
        " --name=NAME --surname=SURNAME --mail=MAIL --age=AGE --experience=EXPERIENCE"
  else
    options = {}
    OptionParser.new do |opt|
      opt.on('--name NAME') { |o| options[:name] = o }
      opt.on('--surname SURNAME') { |o| options[:surname] = o }
      opt.on('--mail MAIL') { |o| options[:mail] = o }
      opt.on('--age AGE') { |o| options[:age] = o }
      opt.on('--experience EXPERIENCE') { |o| options[:experience] = o }
    end.parse!
    find_job(options)
  end
end

def find_job(options)
  unless options.length === 5
    puts "Введены не все аргументы для корректной работы программы #{options.length}"
    return
  end
  job = "Ваш список должностей:"
  if options[:name] === 'Петр' and options[:surname] === 'Петрович'
    job += "\nРуководитель"
  end
  if options[:mail].include? "code"
    job += "\nИнженер"
  end
  if options[:experience].to_i < 2
    job += "\nСтажер"
  end
  if options[:age].to_i > 44 and options[:age].to_i < 60
    job += "\nБывалый"
  end
  if options[:experience].to_i > 15
    job = add_word_into_string("Заслуженный", job)
  elsif options[:experience].to_i > 5
    job = add_word_into_string("Известный", job)
  end
  puts job
end

def validator (string) end

def add_word_into_string (word, str)
  job_arr = str.split("\n")
  for value in 1..job_arr.length - 1
    job_arr[value] = "#{word} " + job_arr[value]
  end
  str = job_arr.join("\n")
end

# Keep it in the bottom of the file
if __FILE__ == $0
  main
end

