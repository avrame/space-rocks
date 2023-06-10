require "./line"

class Shape
  property visible : Bool

  def initialize(@lines : Array(Line), visible : Bool)
    @visible = visible
  end

  def draw(parent_x : Float64, parent_y : Float64)
    if !@visible
      return
    end
    @lines.each do |line|
      line.draw(parent_x, parent_y)
    end
  end

  def rotate(deg : Float64)
    @lines.each do |line|
      line.rotate(deg)
    end
  end
end
