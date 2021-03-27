# frozen_string_literal: true

# Class that describes one client which is uses our tariff
class Client
  attr_reader :name
  attr_reader :last_name
  attr_reader :phone_number
  attr_reader :plan_name
  attr_reader :minutes

  def initialize(name, last, phone, min, plan)
    @name = name
    @last_name = last
    @phone_number = phone
    @minutes = min
    @plan_name = plan
  end

  def to_s
    "#{last_name} #{name}, tel:#{phone_number}, #{minutes} min. #{plan_name} plan"
  end
end
