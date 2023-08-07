require 'ruby2d'
require_relative 'snake'
require_relative 'game'

set background: 'navy'
set fps_cap: 20

SQUARE_SIZE = 20
GRID_WIDTH = Window.width / SQUARE_SIZE
GRID_HEIGHT = Window.height / SQUARE_SIZE


snake = Snake.new
game = Game.new

update do
    clear
  
    unless game.finished? || game.paused?
      snake.move
    end
  
    snake.draw
    game.draw
  
    if game.snake_hit_ball?(snake.x, snake.y)
      game.record_hit
      snake.grow
    end
  
    if snake.hit_itself?
      game.finish
    end
  end
  
  

on :key_down do |event|
  if ['up', 'down', 'left', 'right'].include?(event.key)
    if snake.can_change_direction_to?(event.key)
      snake.direction = event.key
    end
  end

  if event.key == 'space'
    game.toggle_pause
  end

  if game.finished? && event.key == 'r'
    snake = Snake.new
    game = Game.new
  end
end

show