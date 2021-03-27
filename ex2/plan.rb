# frozen_string_literal: true

# Class that describes tariff plan for clients
class Plan
  # If minutes is infinite, then pass -1
  attr_reader :minutes
  attr_reader :month_pay
  attr_reader :over_pay
  attr_reader :plan_name

  def initialize(min, month, over, name)
    @minutes = Integer(min)
    @month_pay = Float(month)
    @over_pay = Float(over)
    @plan_name = name
  end
end
