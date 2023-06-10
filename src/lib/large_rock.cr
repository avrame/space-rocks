require "../space-rocks"
require "./vector-sprite"
require "./shape"

class LargeRock < VectorSprite
  @rotate_speed : Float64

  def initialize
    rock_shape = Shape.new([
      Line.new(-12, -12, 0, -14),
      Line.new(0, -14, 12, -12),
      Line.new(12, -12, 16, -4),
      Line.new(16, -4, 12, 12),
      Line.new(12, 12, -12, 12),
      Line.new(-12, 12, -12, -12),
    ], true)

    position = Rl::Vector2.new(x: Random.rand(x: SpaceRocks.virtual_screen_width), y: Random.rand(SpaceRocks.virtual_screen_height))
    @velocity = Rl::Vector2.new(x: Random.rand(-2.0..2.0), y: Random.rand(-2.0..2.0))
    @rotate_speed = Random.new.rand(-0.05..0.05)
    super(position, [rock_shape])
  end

  def rotate
    super(@rotate_speed)
  end
end
