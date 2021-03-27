# frozen_string_literal: true

require 'csv'
require_relative 'triangle'
require_relative 'point'

# Class for describing a list of triangles
class Triangles
  def initialize
    @triangles_list = []
  end

  def read_in_csv_data(file_name)
    CSV.foreach(file_name, col_sep: ', ', row_sep: :auto, headers: true) do |row|
      triangle = Triangle.new(
        Point.new(row['ax'].to_i, row['ay'].to_i),
        Point.new(row['bx'].to_i, row['by'].to_i),
        Point.new(row['cx'].to_i, row['cy'].to_i),
        row['Цвет заливки'], row['Цвет границы']
      )
      @triangles_list.append(triangle)
    end
  end

  def number_of_triangles
    @triangles_list.length
  end

  def random_triangle
    @triangles_list.sample
  end

  def get_matches(color)
    matches = []
    for triangle in @triangles_list
      if triangle.check_color(color)
        matches.append(triangle)
      end
    end
    matches
  end

  def to_s
    @triangles_list.join("\n")
  end

  def get_all_rectangle_triangles
    matches = []
    for triangle in @triangles_list
      if triangle.check_rectangle_triangle
        matches.append(triangle)
      end
    end
    matches
  end
end
