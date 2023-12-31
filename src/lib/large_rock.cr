require "../space-rocks"
require "./vector-sprite"
require "./shape"

class LargeRock < VectorSprite
  @rotate_speed : Float64

  def initialize(virtual_screen_width, virtual_screen_height)
    rock_shape = Shape.new([{-11.494, -16.504}, {3.633, -21.65},
                            {16.587, -15.164}, {24.604, -17.548}, {28.889, -1.851},
                            {21.131, 9.785}, {25.957, 19.163}, {14.573, 26.617},
                            {4.272, 17.683}, {-0.849, 27.133}, {-15.179, 18.081},
                            {-17.077, 5.739}, {-23.27, 1.132}, {-21.354, -13.933},
                            {-11.494, -16.504}], true)

    position = Rl::Vector2.new(
      x: Random.rand(virtual_screen_width),
      y: Random.rand(virtual_screen_height)
    )
    @velocity = Rl::Vector2.new(x: Random.rand(-2.0..2.0), y: Random.rand(-2.0..2.0))
    @rotate_speed = Random.new.rand(-4.0..4.0)
    super(position, [rock_shape], virtual_screen_width, virtual_screen_height)
  end

  def rotate(delta_time)
    super(@rotate_speed * delta_time)
  end
end
