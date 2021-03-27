# frozen_string_literal: true

# Creating point of triangle
# Input param is json object of point
class TrianglePoint
  attr_reader :x
  attr_reader :y
  attr_reader :color

  def initialize(point_hash)
    cords = point_hash['coordinates']
    @x = cords[0]
    @y = cords[1]
    @color = point_hash['color']
  end

  def to_s
    "(#{@x}, #{@y})"
  end

  # Returns the x and y in list
  def to_l
    [x, y]
  end

  # Is point inside rect
  def inside_rect(x_one, y_one, x_two, y_two)
    correct_x = x_one <= x && x <= x_two
    correct_y = y_one <= y && y <= y_two
    correct_x && correct_y
  end

  # Comparing point to other one
  def ==(other)
    other.x == @x and other.y == @y
  end
end
