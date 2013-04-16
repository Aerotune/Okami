require_relative '../../lib/okami'

Okami::Image.tileable = false
Okami::Image.load_path = './images'

class Window < Okami::Window
  def initialize
    super 800, 600, false
    
    @images = Okami::ImageTilesCache['tiles.png', 16, 16]
    @sprite = Okami::Sprite.new images: @images, # must be set to an Array
                                fps: 5 # must be set to a Numeric
    @sprite.x = 23
    @sprite.y = 23
  end
  
  def update
    @sprite.update
  end
  
  def draw
    @sprite.draw
  end
end

Window.new.show