class Window < Okami::Window
  def initialize
    super 800, 600, false
    
    Keyboard.add_key_down_listener method(:key_down)
    Keyboard.add_key_up_listener method(:key_up)
    Mouse.add_key_down_listener method(:mouse_down)
    Mouse.add_key_up_listener method(:mouse_up)
    show_cursor
  end
  
  def key_down key
    
  end
  
  def key_up key
    
  end
  
  def mouse_down key
    
  end
  
  def mouse_up key
    
  end
  
  def update
    #puts @dt
  end
  
  def draw
    fill :white
  end
end