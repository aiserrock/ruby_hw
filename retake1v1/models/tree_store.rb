# frozen_string_literal: true

require 'json'

# Store that contains root tree item and current watching item
class TreeStore
  attr_reader :root, :current

  # Init tree with specifying root item by parsing data from input json.
  # If error occurs, returns error string, else nil.
  def init_tree(json_str)
    parsed = JSON.parse(json_str)
    @root = TreeItem.new(parsed, nil)
    @current = @root
    nil
  rescue StandardError
    'Некорректный json'
  end

  # Go up if possible and set up parent of current item. Return nil
  def go_up
    @current = @current.parent unless @current.parent.nil?
    nil
  end

  # Go down trhought the tree with specified index of child
  # If index incorrect, return error string else nil
  def go_down(index)
    length = @current.children.length()
    if index >= 0 && index <= length
      @current = @current.children[index]
      nil
    else
      'Некорректный аргумент'
    end
  end
end
