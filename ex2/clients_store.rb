# frozen_string_literal: true

require 'json'
require_relative 'plan'
require_relative 'client'

# Class that store information about clients and handle it
class ClientsStore # rubocop:disable Metrics/ClassLength
  attr_reader :plans
  attr_reader :clients
  attr_reader :plan_names

  def initialize
    @clients = []
    @plans = [
      Plan.new(-1, 420, 0, 'unlimited'),
      Plan.new(350, 300, 0.34, 'combined'),
      Plan.new(0, 180, 0.38, 'time-based')
    ]
    @plan_names = []
    @plans.each do |p|
      @plan_names.append(p.plan_name)
    end
  end

  # Return the plan which name is plan_name
  def take_p(plan_name)
    @plans.each do |p|
      return p if p.plan_name == plan_name
    end
    nil
  end

  # Read clients data from json file.
  # Raise TypeError if some data is incorrect
  def read_clients_json(file_name)
    cl_list = JSON.parse(File.read(file_name))
    cl_list.each do |cl|
      if verify_client_json(cl)
        c = Client.new(cl['name'], cl['last_name'], cl['phone_number'], cl['minutes'], cl['plan_name'])
        @clients.append(c)
      else
        raise TypeError, "Wrong client data: #{cl}"
      end
    end
  end

  # Verify is json client data is correct
  def verify_client_json(cl_json)
    if cl_json['name'].is_a?(String) && cl_json['last_name'].is_a?(String) &&
       cl_json['phone_number'].is_a?(String) && (cl_json['phone_number'].length == 6) &&
       cl_json['minutes'].is_a?(Integer) &&
       cl_json['plan_name'].is_a?(String) && @plan_names.include?(cl_json['plan_name'])
      return true
    end

    false
  end

  # Add a client to store and assign not busy phone number.
  # Return created client. Task 1
  def add_client(name, last_name, tariff)
    number = take_free_number
    plan = take_p(tariff)
    raise TypeError, "Wrong plan name: #{tariff}" if plan.nil?

    client = Client.new(name, last_name, number, 0, plan.plan_name)
    @clients.append(client)
    client
  end

  # Return a free 6-sign phone-number which is not used by anyone
  def take_free_number
    n = random_number
    n = random_number until free_number?(n)
    n
  end

  # Check is input number is free for usage
  def free_number?(number)
    @clients.each do |c|
      return false if c.phone_number == number
    end
    true
  end

  # Generate a random 6-sign phone number
  def random_number
    number = ''
    0.upto(5) { |_| number += rand(10).to_s }
    number
  end

  # Remove client from store by phone number. Task 2
  def remove_client(phone_number)
    @clients.reject! { |cl| cl.phone_number == phone_number }
  end

  # Return the list of clients where name_or_phone included in phone or name. Task 3
  def search(last_or_phone)
    @clients.each do |cl|
      return cl if cl.phone_number == last_or_phone || cl.last_name == last_or_phone
    end
    ''
  end

  # Task 4
  def group_by_plan
    plan_client = Hash.new { |h, k| h[k] = [] }
    @clients.each do |c|
      plan_client[c.plan_name].append(c)
    end
    plan_client.each do |_key, array|
      array.sort! { |a, b| a.last_name <=> b.last_name }
    end
    hash_to_s(plan_client)
  end

  # Conert hash object to string
  def hash_to_s(hash)
    res = ''
    hash.each do |key, list|
      res += "#{key}\n"
      list.each do |v|
        res += "\t#{v}\n"
      end
    end
    res
  end

  # Returns the list of strings which show clients pay for month with plan_name. Task 5
  def calculate_by_plan(plan_name)
    plan = take_p(plan_name)
    raise TypeError, "Wrong plan name: #{plan_name}" if plan.nil?

    cl = @clients.select { |c| c.plan_name == plan_name }
    cl.map do |c|
      pay = client_price(c)
      "#{c.last_name} #{c.name}, #{c.phone_number} = #{pay} руб."
    end
  end

  # Get string statistic by clients. Task 6
  def statistic
    min_count = 0
    pay_price = 0
    size = @clients.length
    @clients.each do |c|
      pay_price += client_price(c)
      min_count += c.minutes
    end

    "Av. price = #{pay_price / size}, Av. minutes = #{min_count / size}, from #{size} clients"
  end

  # Return the price user should pay for month
  def client_price(client)
    plan = take_p(client.plan_name)
    over_min = plan.minutes.negative? ? 0 : client.minutes - plan.minutes
    over_pay = over_min.negative? ? 0 : over_min * plan.over_pay
    Float(plan.month_pay + over_pay)
  end

  def to_s
    @clients.join('\n').to_s
  end
end
