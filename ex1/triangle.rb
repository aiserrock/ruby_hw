# frozen_string_literal: true

require_relative 'triangle_point'

# Triangle class takes as input json object of triangle
class Triangle
  attr_reader :points
  attr_reader :border_c
  attr_reader :field_c

  def initialize(triangle_json)
    @border_c = triangle_json['border-color']
    @field_c = triangle_json['field-color']
    @points = []
    triangle_json['points'].each do |p_j|
      point = TrianglePoint.new(p_j)
      @points.append(point)
    end
  end

  def to_s
    "Triangle:\nBorder: #{@border_c}, Field: #{@field_c}\nPoints:#{@points.join(', ')}\n"
  end

  # Returns the perimeter by points
  def take_p
    l1 = take_p_l(points[0], points[1])
    l2 = take_p_l(points[1], points[2])
    l3 = take_p_l(points[0], points[2])
    l1 + l2 + l3
  end

  # Checks is all points inside rect
  def inside_rect(x_one, y_one, x_two, y_two)
    p_x = [x_one, x_two]
    p_y = [y_one, y_two]
    points.all? { |p| p.inside_rect(p_x.min, p_y.min, p_x.max, p_y.max) }
  end

  # Returns the square of triangle
  def sqr
    l1 = take_p_l(points[0], points[1])
    l2 = take_p_l(points[1], points[2])
    l3 = take_p_l(points[0], points[2])
    p = (l1 + l2 + l3) / 2.0
    Math.sqrt(p * (p - l1) * (p - l2) * (p - l3))
  end

  # Returns the left bottom point of triangle
  def b_l_point
    less_y = @points.sort { |p1, p2| p1.y <=> p2.y }
    l_y = less_y[0].y
    less_y = less_y.select { |p| p.y == l_y }

    return less_y[0] if less_y.length == 1

    less_x = less_y.sort { |p1, p2| p1.x <=> p2.x }
    less_x[0]
  end

  # Checks is self and other_tr has at least one shared point
  def shared_p?(other_tr)
    other_tr.points.each do |p1|
      @points.each do |p2|
        return true if p1 == p2
      end
    end

    false
  end

  private

  # Returns the length between two points
  def take_p_l(point1, point2)
    Math.sqrt((point1.x - point2.x)**2 + (point1.y - point2.y)**2)
  end
end
