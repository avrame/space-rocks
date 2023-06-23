require "raylib-cr"
require "./line"

class Shape
  property visible : Bool

  def initialize(@points : Array(Rl::Vector2), visible : Bool)
    @visible = visible
  end

  def draw(parent_pos : Rl::Vector2)
    if !@visible
      return
    end

    absolute_points = @points.map do |line|
      line.add(parent_pos)
    end

    Rl.draw_line_strip(absolute_points, absolute_points.size, Rl::WHITE)
  end

  def rotate(deg : Float64)
    # @lines.each do |line|
    #   line.rotate(deg)
    # end
    @points = @points.map do |point|
      point.rotate(deg)
    end
  end
end
