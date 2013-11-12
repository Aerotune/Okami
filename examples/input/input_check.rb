require_relative '../../lib/okami'

class Window < Okami::Window  
  def initialize
    super 200, 100, false
  end
  
  def update
    puts "Return down!" if Okami::Keyboard.key_down? :return
    puts "Mouse click!" if Okami::Mouse.key_down? :left
    
    puts "Some arrow key is down" if Okami::Keyboard.any_key_down? :left, :right, :up, :down
    puts "1, 2, and 3 pressed down simultaneously" if Okami::Keyboard.keys_down? 1,2,3
  end
end

Window.new.show