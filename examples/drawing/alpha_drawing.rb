require_relative '../../lib/okami'

Okami::Image.tileable = false
Okami::Image.load_path = './images'

class Window < Okami::Window
  def initialize
    super 200, 100, false
    load_sprite_and_image
    @image.alpha = 0.5
  end
  
  def update
    @sprite.alpha -= 0.002
    @sprite.update
  end
  
  def draw
    @sprite.draw
    @image.draw
  end
  
  
  def load_sprite_and_image
    @image = Okami::Image.new 'box.png'
    @image.x = 23
    @image.y = 23
    
    @images = Okami::ImageTilesCache['tiles.png', 16, 16]
    @sprite = Okami::Sprite.new images: @images, # must be set to an Array
                                fps: 20 # must be set to a Numeric
    @sprite.x = 62
    @sprite.y = 23
  end
end

Window.new.show