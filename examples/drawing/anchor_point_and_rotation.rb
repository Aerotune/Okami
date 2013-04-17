require_relative '../../lib/okami'

Okami::Image.tileable = false
Okami::Image.load_path = './images'

class Window < Okami::Window
  def initialize
    super 200, 100, false
    load_sprite_and_image
    @sprite.center_x = 0.5
    @sprite.center_y = 0.5
    
    @image.center_x = 0.5
    @image.center_y = 0.5
    @image.degrees = 45
  end
  
  def update
    @sprite.rotate_degrees 1
    ## or
    #@sprite.degrees += 1
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
                                fps: 5 # must be set to a Numeric
    @sprite.x = 62
    @sprite.y = 23
  end
end

Window.new.show