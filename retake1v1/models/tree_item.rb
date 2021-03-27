# frozen_string_literal: true

require 'forwardable'

# Item of tree that describes one element with its children
class TreeItem
  extend Forwardable
  def_delegator :@children, :each_with_index, :each_child
  attr_reader :title, :description, :parent, :children

  # Set up values or defaults
  def initialize(json_item, parent)
    @title = json_item['title'] || ''
    @description = json_item['description'] || ''
    @parent = parent

    @children = []
    if json_item['children'].nil?
      json_item['children'].each do |child|
        @children << TreeItem.new(child, self)
      end
    end
  end

  # Getting length of tree from current item
  def tree_length
    length = 0
    active_child = self

    until active_child.parent.nil?
      length += 1
      active_child = active_child.parent
    end

    length
  end
end
