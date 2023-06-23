require "raylib-cr"
require "./line"

alias Point2D = Tuple(Float64, Float64)

class Shape
  property visible : Bool
  @points : Array(Rl::Vector2)

  def initialize(points : Array(Point2D), visible : Bool)
    @points = points.map do |p|
      Rl::Vector2.new(x: p[0], y: p[1])
    end
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
    @points = @points.map do |point|
      point.rotate(deg)
    end
  end
end
