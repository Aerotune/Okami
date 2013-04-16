$LOAD_PATH << '../lib'
require 'okami'

class Window < Okami::Window
  def initialize
    super 800, 600, false
    Mouse.add_key_down_listener method(:mouse_down)
    Mouse.add_key_up_listener method(:mouse_up)
    Keyboard.add_key_down_listener method(:key_down)
  end
  
  def update
    ## Use this to get the delta time in seconds between each frame
    #puts @dt
    p $window.current_time
    puts "W down!"  if Keyboard.key_down? :w
    puts "S down!"      if Keyboard.key_down?   :s
    puts "Command key down!" if Keyboard.key_down? :cmd
    
    puts "Arrow key pressed down!" if Keyboard.any_key_down? :left, :right, :up, :down
    
    #puts "Left mouse button released!" if Mouse.key_up? :left
  end
  
  def mouse_down key
    puts case key
    when :left;   "Left mouse button pressed!"
    when :right;  "Right mouse button pressed!"
    when :middle; "Middle mouse button pressed!"
    end
  end
  
  def mouse_up key
    puts case key
    when :left;   "Left mouse button released!"
    when :right;  "Right mouse button released!"
    when :middle; "Middle mouse button released!"
    end
  end
  
  def key_down key
    puts "Key down: #{key}!"
    
    if key == :q
      puts "Stopped listening for key down!"
      Keyboard.remove_key_down_listener method(:key_down)
      # or
      #Keyboard.remove_key_down_listener self if key == :q
    end
  end
  
  def draw
    
  end
end

Window.new.show