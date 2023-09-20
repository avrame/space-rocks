require "raylib-cr"
require "./lib/game"
require "./lib/ship"
require "./lib/large_rock"
require "./lib/bullet"

space_rocks = SpaceRocksGame.new(scale: 1.0)
space_rocks.run

class SpaceRocksGame < Game
  def initialize(screen_width = 960, screen_height = 593, scale = 1.0, target_fps = 60.to_i8)
    super(screen_width, screen_height, scale, target_fps)
    center_of_screen = Rl::Vector2.new
    center_of_screen.x = virtual_screen_width / 2
    center_of_screen.y = virtual_screen_height / 2
    @ship = Ship.new(center_of_screen, virtual_screen_width, virtual_screen_height)

    @rocks = [] of LargeRock
    (0..2).each do |_|
      @rocks << LargeRock.new(virtual_screen_width, virtual_screen_height)
    end

    @bullets = [] of Bullet
  end

  def update(dt)
    if Rl.key_down? Rl::KeyboardKey::Up
      @ship.accelerate(dt)
      @ship.show_thrust
    else
      @ship.slow_down()
      @ship.hide_thrust
    end

    if Rl.key_down? Rl::KeyboardKey::Left
      @ship.rotate_ccl(dt)
    elsif Rl.key_down? Rl::KeyboardKey::Right
      @ship.rotate_cl(dt)
    end

    if Rl.key_released? Rl::KeyboardKey::Space
      @bullets << Bullet.new(@ship.position, @ship.velocity, @ship.rotation, virtual_screen_width, virtual_screen_height)
    end

    @ship.update
    @rocks.each do |rock|
      rock.update(dt)
    end
    @bullets.each do |bullet|
      bullet.update(dt)
    end
    @bullets.reject! { |bullet| bullet.die }
  end

  def draw(dt)
    @ship.draw
    @rocks.each do |rock|
      rock.draw
    end
    @bullets.each do |bullet|
      bullet.draw
    end
  end
end
