require "raylib-cr"

class Game
  property scale : Float64
  property screen_width : Int32
  property screen_height : Int32
  property target_fps : Int8

  def initialize(@screen_width, @screen_height, @scale, @target_fps)
    puts "Game.initialize virtual_screen_width, virtual_screen_height", virtual_screen_width, virtual_screen_height
  end

  def run
    puts "Game.run virtual_screen_width, virtual_screen_height", virtual_screen_width, virtual_screen_height
    virtual_width_ratio = @screen_width.to_f / virtual_screen_width.to_f
    virtual_height_ratio = @screen_height.to_f / virtual_screen_height.to_f

    Rl.init_window(screen_width, screen_height, "Space Rocks!")

    world_space_camera = Rl::Camera2D.new
    world_space_camera.zoom = 1.0_f32

    screen_space_camera = Rl::Camera2D.new
    screen_space_camera.zoom = 1.0_f32

    target = Rl.load_render_texture(virtual_screen_width, virtual_screen_height)

    source_rec = Rl::Rectangle.new x: 0.0_f32, y: 0.0_f32, width: target.texture.width.to_f, height: -target.texture.height.to_f
    dest_rec = Rl::Rectangle.new x: -virtual_width_ratio, y: -virtual_height_ratio, width: screen_width + (virtual_width_ratio*2), height: screen_height + (virtual_height_ratio*2)

    origin = Rl::Vector2.new(x: 0.0_f32, y: 0.0_f32)
    rotation = 0.0_f32
    camera_x = 0.0_f32
    camera_y = 0.0_f32

    Rl.set_target_fps(@target_fps)

    until Rl.close_window?
      dt = Rl.get_frame_time

      if Rl.key_pressed? Rl::KeyboardKey::F
        Rl.toggle_fullscreen
        if Rl.window_fullscreen?
          monitor_width = Rl.get_monitor_width(0)
          monitor_height = Rl.get_monitor_height(0)
          dest_rec = Rl::Rectangle.new x: 0, y: 0, width: monitor_width, height: monitor_height
        else
          Rl.set_window_size(screen_width, screen_height)
          dest_rec = Rl::Rectangle.new x: -virtual_width_ratio, y: -virtual_height_ratio, width: screen_width + (virtual_width_ratio*2), height: screen_height + (virtual_height_ratio*2)
        end
      end

      update(dt)

      # Begin Texture Mode
      Rl.begin_texture_mode(target)

      Rl.clear_background(Rl::BLACK)
      Rl.begin_mode_2d(world_space_camera)

      draw(dt)

      Rl.end_mode_2d
      Rl.end_texture_mode
      # End Texture Mode

      Rl.begin_drawing
      Rl.clear_background(Rl::BLACK)
      Rl.begin_mode_2d(screen_space_camera)
      Rl.draw_texture_pro(target.texture, source_rec, dest_rec, origin, 0.0_f32, Rl::WHITE)
      # Rl.draw_fps(10, 10)
      Rl.end_mode_2d
      Rl.end_drawing
    end

    Rl.unload_render_texture(target)

    Rl.close_window
  end

  def update(dt : Float64)
  end

  def draw(dt : Float64)
  end

  def virtual_screen_width
    @screen_width / @scale
  end

  def virtual_screen_height
    @screen_height / @scale
  end
end
