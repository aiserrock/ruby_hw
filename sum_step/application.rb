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

  opts[:sum] = Summator.new

  status_handler(404) do
    view('not_found')
  end

  route do |r|
    r.public if opts[:serve_static]
    r.hash_branches

    r.root do
      view('root')
    end

    r.on('expression') do
      r.get do
        @params = {}
        view('expression')
      end

      r.post do
        @str = r.params['expression']
        pp(@str)
        opts[:sum] = Summator.new(@str)

        r.redirect('result')
      end
    end

    r.on('result') do
      @obj_sum = opts[:sum]

      @log_list = @obj_sum.log

      view('result')
    end
  end
end
