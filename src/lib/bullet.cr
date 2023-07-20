class Bullet
  @@speed : Float64 = 3
  @@size : Float64 = 1.5
  @@life_span : Float32 = 1.5

  @virtual_screen_width : Float64
  @virtual_screen_height : Float64
  @time_alive : Float32 = 0
  getter die : Bool = false

  def initialize(@position : Rl::Vector2, @direction : Float64, @virtual_screen_width, @virtual_screen_height)
    @velocity = Rl::Vector2.zero
    @velocity.x = @velocity.x + Math.sin(@direction) * @@speed
    @velocity.y = @velocity.y - Math.cos(@direction) * @@speed
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
