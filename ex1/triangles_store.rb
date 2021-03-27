# frozen_string_literal: true

require 'json'
require_relative 'triangle'

# Store of triangles that read it from json and
# do some calculations
class TrianglesStore
  attr_reader :triangles

  def initialize
    @triangles = []
  end

  def read_triangles_json(file_name)
    tr_list = JSON.parse(File.read(file_name))
    tr_list.each do |t|
      @triangles.append(Triangle.new(t))
    end
  end

  # Returns the color statistic, 0 - border, 1 - field, 2 - points
  def color_statistic
    colors = Hash.new { |h, k| h[k] = [0, 0, 0] }
    @triangles.each do |t|
      colors[t.border_c][0] += 1
      colors[t.field_c][1] += 1

      t.points.each do |p|
        colors[p.color][2] += 1
      end
    end

    colors
  end

  # Search pairs with shared vertex
  def find_shared_pairs
    @triangles.length.times do |i|
      start = i + 1
      (@triangles.length - i - 1).times do |_|
        if @triangles[i].shared_p?(@triangles[start])
          puts 'Pair:'
          puts @triangles[i]
          puts @triangles[start]
          puts '---------'
        end
        start += 1
      end
    end
  end

  # Return count of triangles in rectangle
  def c_in_rect(x_o, y_o, width, height)
    x2 = x_o + width
    y2 = y_o + height
    @triangles.count { |t| t.inside_rect(x_o, y_o, x2, y2) }
  end

  def to_s
    triangles.join('\n').to_s
  end
end
