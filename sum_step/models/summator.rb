# frozen_string_literal: true

require 'forwardable'

# The list of tests to manage
class Summator
  attr_reader :str_sum, :log_list

  def initialize(str_sum = '')
    @str_sum = str_sum
    @log_list = []
  end

  def log
    return [] if str_sum == ''

    @log_list.clear
    @log_list.append("Исходное: #{@str_sum}")
    temp = @str_sum.split('+')
    i = 1
    while temp.length != 1
      t = temp.shift.to_i
      t += temp.shift.to_i unless temp.empty?
      temp.unshift(t.to_s)
      @log_list.append("Шаг#{i}: #{temp.join('+')}")
      i += 1
    end
    @log_list
  end
end
