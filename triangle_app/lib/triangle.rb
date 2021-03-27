# frozen_string_literal: true

require_relative 'point'

# Class for describing a triangle
class Triangle
  def initialize(point_a, point_b, point_c, fill_color, border_color)
    @vertex_a = point_a
    @vertex_b = point_b
    @vertex_c = point_c
    @fill_color = fill_color
    @border_color = border_color

    @edge_ab = @vertex_a.distance_to(@vertex_b)
    @edge_ac = @vertex_a.distance_to(@vertex_c)
    @edge_bc = @vertex_b.distance_to(@vertex_c)
  end

  def perimeter
    @edge_ab + @edge_ac + @edge_bc
  end

  def area
    semiperimeter = perimeter / 2
    semiperimeter_ab = semiperimeter - @edge_ab
    semiperimeter_ac = semiperimeter - @edge_ac
    semiperimeter_bc = semiperimeter - @edge_bc
    Math.sqrt(semiperimeter * semiperimeter_ab * semiperimeter_ac * semiperimeter_bc)
  end

  def check_rectangle_triangle
    check = false
    if @edge_ab >= 0 and @edge_bc >= 0 and @edge_ac >=0
      if @edge_ac ** 2 == (@edge_bc ** 2 + @edge_ab ** 2) or
        @edge_bc ** 2 == (@edge_ab ** 2 + @edge_ac ** 2) or
        @edge_ab ** 2 == (@edge_ac ** 2 + @edge_bc ** 2)
        check = true
      end
    end
    check
  end

  def check_color(color)
    check = false
    if @border_color.downcase == color
      check = true
    end
    check
    end

  def to_s
    "#{@vertex_a}, #{@vertex_b}, #{@vertex_c}, цвет заливки: #{@fill_color}, цвет границы: #{@border_color}"
  end
end
