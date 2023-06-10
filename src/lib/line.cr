require "raylib-cr"

alias Rl = Raylib

class Line
  def initialize(x1 : Float64, y1 : Float64, x2 : Float64, y2 : Float64, @color : Rl::Color = Rl::WHITE)
    @p1 = Rl::Vector2.new(x: x1, y: y1)
    @p2 = Rl::Vector2.new(x: x2, y: y2)
  end

  def rotate(deg : Float64)
    @p1 = @p1.rotate(deg)
    @p2 = @p2.rotate(deg)
  end

  def draw
    Rl.draw_line(@p1.x, @p1.y, @p2.x, @p2.y, @color)
  end

  def draw(x_offset, y_offset)
    Rl.draw_line(@p1.x + x_offset, @p1.y + y_offset, @p2.x + x_offset, @p2.y + y_offset, @color)
  end
end
