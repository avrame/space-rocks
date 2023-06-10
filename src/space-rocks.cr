require "raylib-cr"

# TODO: Write documentation for `Space::Rocks`
module Space::Rocks
  alias Rl = Raylib

  screen_width = 960
  screen_height = 540

  virtual_screen_width = 640
  virtual_screen_height = 360

  virtual_width_ratio = screen_width.to_f / virtual_screen_width.to_f
  virtual_height_ratio = screen_height.to_f / virtual_screen_height.to_f

  Rl.init_window(screen_width, screen_height, "Hello World")

  world_space_camera = Rl::Camera2D.new
  world_space_camera.zoom = 1.0_f32

  screen_space_camera = Rl::Camera2D.new
  screen_space_camera.zoom = 1.0_f32

  target = Rl.load_render_texture(virtual_screen_width, virtual_screen_height)

  rec01 = Rl::Rectangle.new x: 70.0_f32, y: 35.0_f32, width: 20.0_f32, height: 20.0_f32
  rec02 = Rl::Rectangle.new x: 90.0_f32, y: 55.0_f32, width: 30.0_f32, height: 10.0_f32
  rec03 = Rl::Rectangle.new x: 80.0_f32, y: 65.0_f32, width: 15.0_f32, height: 25.0_f32

  source_rec = Rl::Rectangle.new x: 0.0_f32, y: 0.0_f32, width: target.texture.width.to_f, height: -target.texture.height.to_f
  dest_rec = Rl::Rectangle.new x: -virtual_width_ratio, y: -virtual_height_ratio, width: screen_width + (virtual_width_ratio*2), height: screen_height + (virtual_height_ratio*2)

  origin = Rl::Vector2.new(x: 0.0_f32, y: 0.0_f32)
  rotation = 0.0_f32
  camera_x = 0.0_f32
  camera_y = 0.0_f32

  Rl.set_target_fps(60)

  class VectorSprite
    property x : Float64
    property y : Float64
    property velocity = Rl::Vector2.zero
    property rotation : Float64 = 0

    def initialize(@x, @y, @shapes : Array(Shape))
    end

    def add_line(line)
      @lines << line
    end

    def rotate(deg)
      @rotation += deg
      @shapes.each do |shape|
        shape.rotate(deg)
      end
    end

    def move(screen_width, screen_height)
      @x += @velocity.x
      @y += @velocity.y
      if @x < 0
        @x = screen_width.to_f64
      elsif @x > screen_width
        @x = 0
      end

      if @y < 0
        @y = screen_height.to_f64
      elsif @y > screen_height
        @y = 0
      end
    end

    def draw
      @shapes.each do |shape|
        shape.draw(@x, @y)
      end
    end
  end

  class Ship < VectorSprite
    @thrust = 0.025
    @rotate_speed = 0.1
    @vel_max = 2.5

    def initialize(x : Float64, y : Float64)
      @ship_body = Shape.new([
        Line.new(0, -6, 4, 5),
        Line.new(0, -6, -4, 5),
        Line.new(-2.25, 3, 2.25, 3),
      ], true)
      @ship_thrust = Shape.new([
        Line.new(-2.25, 3, 0, 6.25),
        Line.new(2.25, 3, 0, 6.25),
      ], false)
      super(x, y, [@ship_body, @ship_thrust])
    end

    def rotate
      super.rotate(@rotate_speed)
    end

    def accelerate
      @velocity.x = @velocity.x + Math.sin(@rotation) * @thrust
      @velocity.y = @velocity.y - Math.cos(@rotation) * @thrust

      if @velocity.length > @vel_max
        @velocity.x = Math.sin(@rotation) * @vel_max
        @velocity.y = -Math.cos(@rotation) * @vel_max
      end
    end

    def show_thrust
      @ship_thrust.visible = true
    end

    def hide_thrust
      @ship_thrust.visible = false
    end
  end

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

  class Line
    def initialize(@x1 : Float64, @y1 : Float64, @x2 : Float64, @y2 : Float64, @color : Rl::Color = Rl::WHITE)
    end

    def rotate(deg : Float64)
      deg_cos = Math.cos(deg)
      deg_sin = Math.sin(deg)

      x1 = @x1 * deg_cos - @y1 * deg_sin
      y1 = @y1 * deg_cos + @x1 * deg_sin
      x2 = @x2 * deg_cos - @y2 * deg_sin
      y2 = @y2 * deg_cos + @x2 * deg_sin

      @x1 = x1
      @y1 = y1
      @x2 = x2
      @y2 = y2
    end

    def draw
      Rl.draw_line(@x1, @y1, @x2, @y2, @color)
    end

    def draw(x_offset, y_offset)
      Rl.draw_line(@x1 + x_offset, @y1 + y_offset, @x2 + x_offset, @y2 + y_offset, @color)
    end
  end

  ship = Ship.new(virtual_screen_width / 2, virtual_screen_height / 2)

  until Rl.close_window?
    if Rl.key_pressed? Rl::KeyboardKey::F
      Rl.toggle_fullscreen
      if Rl.window_fullscreen?
        monitor_width = Rl.get_monitor_width(0)
        monitor_height = Rl.get_monitor_height(0)
        Rl.set_window_size(monitor_width, monitor_height)
        dest_rec = Rl::Rectangle.new x: 0, y: 0, width: monitor_width, height: monitor_height
      else
        Rl.set_window_size(screen_width, screen_height)
        dest_rec = Rl::Rectangle.new x: -virtual_width_ratio, y: -virtual_height_ratio, width: screen_width + (virtual_width_ratio*2), height: screen_height + (virtual_height_ratio*2)
      end
    end

    if Rl.key_down? Rl::KeyboardKey::Up
      ship.accelerate
      ship.show_thrust
    elsif ship.hide_thrust
    end

    if Rl.key_down? Rl::KeyboardKey::Left
      ship.rotate(-0.1)
    elsif Rl.key_down? Rl::KeyboardKey::Right
      ship.rotate(0.1)
    end

    ship.move(virtual_screen_width, virtual_screen_height)

    Rl.begin_texture_mode(target)
    Rl.clear_background(Rl::BLACK)
    Rl.begin_mode_2d(world_space_camera)
    ship.draw
    Rl.end_mode_2d
    Rl.end_texture_mode

    Rl.begin_drawing
    Rl.clear_background(Rl::BLACK)
    Rl.begin_mode_2d(screen_space_camera)
    Rl.draw_texture_pro(target.texture, source_rec, dest_rec, origin, 0.0_f32, Rl::WHITE)
    Rl.end_mode_2d
    Rl.end_drawing
  end
  Rl.unload_render_texture(target)

  Rl.close_window
end
