# frozen_string_literal: true

require 'date'
require 'forme'
require 'roda'

require_relative 'models'

# The application class
class Application < Roda
  opts[:root] = __dir__
  plugin :environments
  plugin :forme
  plugin :hash_routes
  plugin :path
  plugin :render
  plugin :status_handler
  plugin :view_options

  configure :development do
    plugin :public
    opts[:serve_static] = true
  end

  status_handler(404) do
    view('not_found')
  end

  opts[:results] = []

  route do |r|
    r.public if opts[:serve_static]
    r.hash_branches

    r.root do
      view('root')
    end


    r.on 'input' do
      r.get do
        @params = {}
        view('input')
      end

      r.post do
        @params = r.params
        @results = opts[:results]
        unless @params.nil?
          pp(@params)
          val1 = @params['value1'].to_s
          val2 = @params['value2'].to_s
          sum = val1.to_i + val2.to_i
          @results.append({ date: Time.new.inspect, value1: val1, value2: val2, result: sum })
          r.redirect('/result')
        end
      end
    end

    r.on 'history' do
      @list = opts[:results]
      view('history')
    end

    r.on 'result' do
      @result = opts[:results]
      @last = @result.last
      view('result')
    end
  end
end
