class Bullet
  @@speed : Float64 = 3
  @@size : Float64 = 1.5
  @@life_span : Float32 = 1.5

  @virtual_screen_width : Float64
  @virtual_screen_height : Float64
  @time_alive : Float32 = 0
  @position : Rl::Vector2 = Rl::Vector2.zero
  getter die : Bool = false

  def initialize(ship_position : Rl::Vector2, ship_velocity : Rl::Vector2, @direction : Float64, @virtual_screen_width, @virtual_screen_height)
    x_dx = Math.sin(@direction)
    y_dx = -Math.cos(@direction)

    # Start the bullet at the front tip of the ship
    @position.x = ship_position.x + x_dx * 5
    @position.y = ship_position.y + y_dx * 5

    @velocity = Rl::Vector2.zero
    @velocity.x = ship_velocity.x + x_dx * @@speed
    @velocity.y = ship_velocity.y + y_dx * @@speed
  end

  def update(dt)
    @time_alive += dt

    if @time_alive > @@life_span
      @die = true
    end

    # Todo make the following code DRY
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
    Rl.draw_circle_v(@position, @@size, Rl::WHITE)
  end
end
