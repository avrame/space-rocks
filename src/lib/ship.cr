require "./vector-sprite"
require "./shape"

class Ship < VectorSprite
  @thrust = 0.025
  @rotate_speed = 0.1
  @vel_max = 3

  def initialize(position : Rl::Vector2)
    @ship_body = Shape.new([
      Line.new(0, -12, 8, 10),
      Line.new(0, -12, -8, 10),
      Line.new(-6, 6, 6, 6),
    ], true)
    @ship_thrust = Shape.new([
      Line.new(-4.5, 6, 0, 12.5),
      Line.new(4.5, 6, 0, 12.5),
    ], false)
    super(position, [@ship_body, @ship_thrust])
  end

  def accelerate
    new_velocity = Rl::Vector2.zero
    new_velocity.x = @velocity.x + Math.sin(@rotation) * @thrust
    new_velocity.y = @velocity.y - Math.cos(@rotation) * @thrust

    if new_velocity.length < @vel_max
      @velocity = new_velocity
    end
  end

  def show_thrust
    @ship_thrust.visible = true
  end

  def hide_thrust
    @ship_thrust.visible = false
  end
end
