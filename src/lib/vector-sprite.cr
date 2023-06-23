require "raylib-cr"
require "../space-rocks"
require "./shape"

class VectorSprite
  @virtual_screen_width : Float64
  @virtual_screen_height : Float64
  property position
  property velocity = Rl::Vector2.zero
  property rotation : Float64 = 0

  def initialize(@position : Rl::Vector2, @shapes : Array(Shape), @virtual_screen_width, @virtual_screen_height)
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
      @position.x = @virtual_screen_width
    elsif @position.x > @virtual_screen_width
      @position.x = 0
    end

    if @position.y < 0
      @position.y = @virtual_screen_height
    elsif @position.y > @virtual_screen_height
      @position.y = 0
    end
  end

  def draw
    @shapes.each do |shape|
      shape.draw(@position)
    end
  end
end
