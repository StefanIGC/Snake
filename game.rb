class Game
    def initialize
      @ball_x = 10
      @ball_y = 10
      @score = 0
      @finished = false
      @pause = false
      @high_score = load_high_score
    end
  
    def draw
      Square.new(x: @ball_x * SQUARE_SIZE, y: @ball_y * SQUARE_SIZE, size: SQUARE_SIZE, color: 'yellow')
      Text.new(text_message, color: 'green', x: 10, y: 10, size: 25, z: 1)
    end
  
    def snake_hit_ball?(x, y)
      @ball_x == x && @ball_y == y
    end
  
    def record_hit
      @score += 1
      @ball_x = rand(Window.width / SQUARE_SIZE)
      @ball_y = rand(Window.height / SQUARE_SIZE)
      update_high_score(@score) # Add this line
    end
  
    def toggle_pause
        @paused = !@paused
    end
    
    def paused?
        @paused
    end

    def finish
      @finished = true
    end
  
    def finished?
      @finished
    end
  
    def load_high_score
        if File.exist?('high_score.txt')
          File.read('high_score.txt').to_i
        else
          0
        end
      end
    
      def save_high_score
        File.write('high_score.txt', @high_score)
      end
    
      # Add a method to update the high score
      def update_high_score(score)
        if score > @high_score
          @high_score = score
          save_high_score
        end
      end    

    private
  

    def text_message
      if finished?
        "Game over, Your Score was #{@score}. Highest Score: #{@high_score}\nPress 'R' to restart."
      elsif paused?
        "Paused. Press 'Space' to resume."
      else
        "Score: #{@score} - Highest Score: #{@high_score}"
      end
    end


  end