require "raylib-cr"
require "./lib/game"
require "./lib/ship"
require "./lib/large_rock"

space_rocks = SpaceRocksGame.new(scale: 1.5)
space_rocks.run

class SpaceRocksGame < Game
  def initialize(screen_width = 960, screen_height = 540, scale = 1.0, target_fps = 60.to_i8)
    super(screen_width, screen_height, scale, target_fps)
    center_of_screen = Rl::Vector2.new
    center_of_screen.x = virtual_screen_width / 2
    center_of_screen.y = virtual_screen_height / 2
    @ship = Ship.new(center_of_screen, virtual_screen_width, virtual_screen_height)

    @rocks = [] of LargeRock
    (0..2).each do |_|
      @rocks << LargeRock.new(virtual_screen_width, virtual_screen_height)
    end
  end

  def update(dt)
    if Rl.key_down? Rl::KeyboardKey::Up
      @ship.accelerate(dt)
      @ship.show_thrust
    else
      @ship.hide_thrust
    end

    if Rl.key_down? Rl::KeyboardKey::Left
      @ship.rotate_ccl(dt)
    elsif Rl.key_down? Rl::KeyboardKey::Right
      @ship.rotate_cl(dt)
    end

    @ship.update
    @rocks.each do |rock|
      rock.update(dt)
    end
  end

  def draw(dt)
    @ship.draw
    @rocks.each do |rock|
      rock.draw
    end
  end
end
