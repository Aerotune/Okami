require_relative '../../lib/okami'

Okami::Image.tileable = false
Okami::Image.load_path = './images'

class Window < Okami::Window
  def initialize
    super 800, 600, false

    @image = Okami::Image.new 'box.png'
    @image.x = 23
    @image.y = 23
  end
  
  def draw
    @image.draw
  end
end

Window.new.show