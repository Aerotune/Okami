require_relative '../../lib/okami'

Okami::Image.tileable = false
Okami::Image.load_path = './images'

class Window < Okami::Window
  def initialize
    super 200, 100, false
    display_info_message
    
    @images = Okami::ImageTilesCache['tiles.png', 16, 16]
    @ping_pong = Okami::Sprite.new images: @images,
                                   fps: 5,
                                   animation_mode: :ping_pong
    @ping_pong.x = 23
    @ping_pong.y = 23   
                                
    @loop = Okami::Sprite.new images: @images,
                              fps: 5,
                              animation_mode: :loop
    @loop.x = 62
    @loop.y = 23
    
    @forward = Okami::Sprite.new images: @images,
                                 fps: 1.5,
                                 animation_mode: :forward
    @forward.x = 101
    @forward.y = 23
  end
  
  def update
    @ping_pong.update
    @loop.update
    @forward.update
    ## You can check if the animation is finished
    #puts @forward.finished?
  end
  
  def draw
    @ping_pong.draw
    @loop.draw
    @forward.draw
  end
  
  
  
  
  def display_info_message
    puts "AnimationModes:"
    p Okami::Sprite::AnimationModes
    
    puts "\n:forward stops when reaching the last image."
    puts ":backward stops when reaching the first image."
    puts ":loop loops."
    puts ":backward_loop loops backward."
    puts ":ping_pong goes forward until reaching the last image then goes backward to the first image and loops like that."
  end
end

Window.new.show