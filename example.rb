require './okami'

class Window < Okami::Window
  def initialize
    super 800, 600, false
  end
  
  def update
    puts @dt
  end
  
  def draw
    
  end
end

Window.new.show