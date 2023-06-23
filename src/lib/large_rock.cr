require "../space-rocks"
require "./vector-sprite"
require "./shape"

class LargeRock < VectorSprite
  @rotate_speed : Float64

  def initialize
    rock_shape = Shape.new([
      Rl::Vector2.new(x: -12, y: 12),
      Rl::Vector2.new(x: 0, y: -14),
      Rl::Vector2.new(x: 12, y: -12),
      Rl::Vector2.new(x: 16, y: -4),
      Rl::Vector2.new(x: 12, y: 12),
      Rl::Vector2.new(x: -12, y: 12),
      Rl::Vector2.new(x: -12, y: -12),
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
