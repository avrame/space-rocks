require "raylib-cr"
require "./lib/game"
require "./lib/ship"
require "./lib/large_rock"

space_rocks = SpaceRocksGame.new
# space_rocks.scale = 1.5
space_rocks.run

class SpaceRocksGame < Game
  def initialize
    super()
    center_of_screen = Rl::Vector2.new
    center_of_screen.x = virtual_screen_width / 2
    center_of_screen.y = virtual_screen_height / 2
    @ship = Ship.new(center_of_screen, virtual_screen_width, virtual_screen_height)

    @lg_rock = LargeRock.new(virtual_screen_width, virtual_screen_height)
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

    @ship.move
    @lg_rock.move
    @lg_rock.rotate(dt)
  end

  def draw(dt)
    @ship.draw
    @lg_rock.draw
  end
end
