# frozen_string_literal: true

require 'roda'
require 'json'
require_relative 'models/tree_item'
require_relative 'models/tree_store'

# Main app class that manipulate with requests
class App < Roda
  opts[:store] = TreeStore.new

  opts[:root] = __dir__

  plugin :environments
  configure :development do
    plugin :public
    opts[:serve_static] = true
  end

  plugin :render

  route do |r|
    r.public if opts[:serve_static]

    r.root do
      r.redirect '/welcome'
    end

    r.on 'welcome' do
      @json_str ||= ''

      r.get do
        view('welcome')
      end
      r.post do
        @json_str = if r.params['default'] == 'true'
                      File.read('public/default.json')
                    else
                      r.params['tree'] || ''
                    end
        @error = opts[:store].init_tree(@json_str)

        if @error.nil? && !opts[:store].current.nil?
          r.redirect 'tree'
        else
          view('welcome')
        end
      end
    end

    r.on 'tree' do
      r.redirect 'welcome' if opts[:store].current.nil?
      pp r.params
      r.get do
        @tree = opts[:store].current
        if @tree.nil?
          r.redirect 'welcome'
        else
          r.is do
            view 'tree'
            pp @tree
          end
        end
      end

      r.post do
        if !r.params['go_up'].nil? && !opts[:store].current.nil?
          opts[:store].go_up
        elsif !r.params['go_down'].nil? && !opts[:store].current.nil?
          opts[:store].go_down(Integer(r.params['go_down']))
        end
        @tree = opts[:store].current
        view('tree')
      end
    end
  end
end
