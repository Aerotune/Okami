require_relative '../lib/okami'

Keyboard = Okami::Keyboard
Mouse = Okami::Mouse
Image = Okami::Image
Sprite = Okami::Sprite

class GameWindow < Okami::Window
  def initialize
    ## Same parameters as for the Gosu::Window
    super 800, 600, false
    Keyboard.add_key_down_listener method(:key_down)
    Keyboard.add_key_up_listener method(:key_up)
    Mouse.add_key_down_listener method(:mouse_down)
    Mouse.add_key_up_listener method(:mouse_up)
    Mouse.hide
    Mouse.show
    
    Image.tileable = false
    Image.retrofy
    Image.load_path = "./images/"
    
    ## Returns an Okami::Image instance that is exactly like a Gosu::Image
    ## Okami::Image just caches the images
    ## The parameters are also the same as with Gosu::Image except you don't have to pass the window
    @image = Image['box.png']
    ## Or
    #@image = Image.require 'box.png'
    
    ## Tiles are also cached
    @images = Image.require_tiles 'tiles.png', 16, 16
    
    ## Loads and caches regardless of if it's already cached
    #@image = Image.reload 'box.png'
    #@images = Image.reload_tiles 'tiles.png', 16, 16
    
    ## Without caching
    #@image = Image.new 'box.png'
    #@images = Image.load_tiles 'tiles.png', 16, 16
    
    ## Modes are :loop, :loop_backward, :forward, :backward and :ping_pong
    @sprite = Sprite.new images: @images, fps: 1, mode: :forward
    @ping_pong_sprite = Sprite.new images: @images, fps: 20, mode: :ping_pong
    puts "Sprite modes: #{Sprite::Modes}"
  end
  
  def key_down key
    case key
    when :q, :escape
      puts "Closing!"
      close
    when Integer
      puts "Key down #{key.inspect}. The number keys are integers."
    when Symbol
      puts "Key down #{key.inspect}"
    end
  end
  
  def key_up key
    puts "Key up   #{key.inspect}"
  end
  
  def mouse_down key; puts "Mouse down #{key}" end
  def mouse_up key;   puts "Mouse up   #{key}" end
  
  def update
    ## @dt, the delta time from last update in seconds. It's calculated before each update call.
    ## It is used by Sprite so you can set fps of the animation and is also available to use for
    ## you to use in your game logic.
    #puts @dt
    #puts $window.dt ## Same as line above
    #puts $window.current_time
    
    #Mouse.x = 13
    #Mouse.y = 37
    #puts Mouse.x
    #puts Mouse.y
    #puts "Mouse offscreen!" if Mouse.offscreen?
    #puts "Mouse onscreen!" if Mouse.onscreen?
    
    puts "Return key down"     if Keyboard.key_down? :return
    puts "1, 2 and 3 down"     if Keyboard.keys_down? 1, 2, 3
    puts "Some arrow key down" if Keyboard.any_key_down? :left, :right, :up, :down
    #puts "Any key down"        if Keyboard.any_key_down?
    
    puts "Left mouse key down"            if Mouse.key_down? :left
    puts "Left and right mouse key down"  if Mouse.keys_down? :left, :right
    #puts "Some mouse key pressed"         if Mouse.any_key_down? :left, :right, :middle
    ## Or
    #puts "Some mouse key pressed"         if Mouse.any_key_down?
    
    @sprite.update
    @ping_pong_sprite.update
    
    ## When the animation reaches the end in :forward and :backward mode the
    ## method finished? will return true
    puts "@sprite animation in progress!" unless @sprite.finished?
  end
  
  def draw
    #color_fill color, z=0 fills the window with the color 
    color_fill 0xFF334455
    @image.draw 10, 10, z
    @sprite.draw 36, 10, z
    @ping_pong_sprite.draw 62, 10, z
  end
end

GameWindow.new.show