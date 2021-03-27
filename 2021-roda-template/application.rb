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

  route do |r|
    r.public if opts[:serve_static]
    r.hash_branches

    r.root do
      view('root')
    end
  end
end
