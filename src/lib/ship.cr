require "raylib-cr"
require "./vector-sprite"
require "./shape"
require "./bullet"

class Ship < VectorSprite
  @thrust = 1
  @rotate_speed = 6
  @vel_max = 3

  def initialize(position : Rl::Vector2, @virtual_screen_width, @virtual_screen_height)
    @ship_body = Shape.new([{-8.0, 10.0}, {0.0, -12.0}, {8.0, 10.0}, {6.0, 6.0}, {-6.0, 6.0}], visible: true)
    @ship_thrust = Shape.new([{-4.5, 6.0}, {0.0, 12.5}, {4.5, 6.0}], visible: false)
    super(position, [@ship_body, @ship_thrust], @virtual_screen_width, @virtual_screen_height)
  end

  def accelerate(delta_time : Float64)
    new_velocity = Rl::Vector2.zero
    new_velocity.x = @velocity.x + Math.sin(@rotation) * @thrust * delta_time
    new_velocity.y = @velocity.y - Math.cos(@rotation) * @thrust * delta_time

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

  def rotate_cl(delta_time : Float64)
    rotate(@rotate_speed * delta_time)
  end

  def rotate_ccl(delta_time : Float64)
    rotate(-1 * @rotate_speed * delta_time)
  end
end
