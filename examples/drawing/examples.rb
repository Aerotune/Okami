require 'gosu'
require_relative '../../lib/okami'

# This is default values and it's best practice to only set them once
Okami::Image.tileable = false
# The images are cached by their path relative to the load path so
# changing the load path on the run might prevent you from loading
# images with the same name
Okami::Image.load_path = './images'

class Window < Okami::Window
  def initialize
    super 800, 600, false
    load_images_and_sprite
    load_attribute_blocks
  end
  
  def update
    dt, time = calculate_dt
    @sprite.update dt
  end
  
  def draw
    # Both Okami::Sprite and Okami::Image use the same draw and draw_rot
    # parameters as Gosu::Image
    @sprite.draw 0, 32, 0
    @image.draw 32, 32, 0
    @images[0].draw 64, 32, 0
    
    @image.draw_using @image_attributes
    @sprite.draw_using @sprite_attributes
  end
  
  
  def load_images_and_sprite
    @image  = Okami::Image['box.png']    
    @images = Okami::ImageTiles['tiles.png', 16, 16]
    @sprite = Okami::Sprite.new images: @images, # must be set to an Array of images
                                fps: 6,          # must be set to a Numeric
                                mode: :ping_pong
    puts "Accepted modes:"
    p Okami::Sprite.modes.keys
  end
  
  def load_attribute_blocks
    ## Okami::ImageAttributes.new options are called the same as Gosu::Image.draw_rot parameters
    @image_attributes = Okami::ImageAttributes.new x: 10, y: 10, z: 0
    @image_attributes.x = 20
    @image_attributes.y = 100
    @image_attributes.center_x = 0
    @image_attributes.angle = 10
    # color is of type Gosu::Color
    @image_attributes.color.alpha = 150
    @image_attributes.mode = :additive
    @image_attributes.factor_y = 0.5
    
    @sprite_attributes = Okami::ImageAttributes.new x: 64, y: 100, mode: :additive, factor_y: 1.5, angle: -10
  end
end

Window.new.show