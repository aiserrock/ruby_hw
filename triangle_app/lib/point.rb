# frozen_string_literal: true

# Structure for describing a point
Point = Struct.new(:x, :y) do
  def distance_to(point)
    Math.sqrt((x - point.x)**2 + (y - point.y)**2)
  end

  def to_s
    "(#{x},#{y})"
  end
end
