require_relative '../../lib/okami'

class Window < Okami::Window  
  def initialize
    super 200, 100, false
    Okami::Mouse.add_key_down_listener    method(:mouse_down)
    Okami::Mouse.add_key_up_listener      method(:mouse_up)
    Okami::Keyboard.add_key_down_listener method(:key_down)
    Okami::Keyboard.add_key_down_listener method(:key_up)
  end
  
  def mouse_down key
    puts "Mouse down: #{key.inspect}"
  end
  
  def mouse_up key
    puts "Mouse up: #{key.inspect}"
  end
  
  def key_down key
    puts "Key down: #{key.inspect}"
  end
  
  def key_up key
    puts "Key down: #{key.inspect}"
  end
end

Window.new.show