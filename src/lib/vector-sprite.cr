require "raylib-cr"
require "../space-rocks"
require "./shape"

class VectorSprite
  property position
  property velocity = Rl::Vector2.zero
  property rotation : Float64 = 0

  def initialize(@position : Rl::Vector2, @shapes : Array(Shape))
  end

  def rotate(deg)
    @rotation += deg
    @shapes.each do |shape|
      shape.rotate(deg)
    end
  end

  def move
    @position.x += @velocity.x
    @position.y += @velocity.y

    if @position.x < 0
      @position.x = SpaceRocks.virtual_screen_width.to_f64
    elsif @position.x > SpaceRocks.virtual_screen_width
      @position.x = 0
    end

    if @position.y < 0
      @position.y = SpaceRocks.virtual_screen_height.to_f64
    elsif @position.y > SpaceRocks.virtual_screen_height
      @position.y = 0
    end
  end

  def draw
    @shapes.each do |shape|
      shape.draw(@position.x, @position.y)
    end
  end
end
