module Okami::Mouse  
  DefaultKeySymbols = {
    Gosu::MsLeft      => :left,
    Gosu::MsRight     => :right,
    Gosu::MsMiddle    => :middle,
    Gosu::MsWheelUp   => :wheel_up,
    Gosu::MsWheelDown => :wheel_down
  }.freeze

  @@key_symbols = DefaultKeySymbols.dup
  @@key_down_listeners = {}
  @@key_up_listeners   = {}

  class << self
    def key_symbols;       @@key_symbols end
    def key_symbols= hash; @@key_symbols = hash end
    
    def x; $window.mouse_x end
    def y; $window.mouse_y end
    def x=value; $window.mouse_x = value end
    def y=value; $window.mouse_y = value end
    
    def onscreen?
      if x > 0
        if y > 0
          if x < $window.width
            if y < $window.height
              return true
            end
          end
        end
      end
      
      return false
    end
    
    def offscreen?
      not onscreen?
    end

    def show; $window.cursor_visible = true  end
    def hide; $window.cursor_visible = false end
    
    def add_key_down_listener listener_method
      @@key_down_listeners[ listener_method.receiver ] = listener_method
    end
    
    def add_key_up_listener listener_method
      @@key_up_listeners[ listener_method.receiver ] = listener_method
    end
  
    def remove_key_up_listener listener
      if listener.class == Method
        @@key_up_listeners.delete @@key_up_listeners.key(listener)
      else
        @@key_up_listeners.delete listener
      end
    end
    
    def remove_key_down_listener listener
      if listener.class == Method
        @@key_down_listeners.delete @@key_down_listeners.key(listener)
      else
        @@key_down_listeners.delete listener
      end
    end
  
    def key_down? key_symbol
      case key_symbol
      when :any_key; any_key_down? *@@key_symbols.values
      else;   $window.button_down? @@key_symbols.key( key_symbol )
      end
    end
  
    ## Returns true if all key_symbols is down
    def keys_down? *key_symbols
      key_symbols.each do |key_symbol|
        return false unless key_down? key_symbol
      end
      return nil if key_symbols.empty?
      return true
    end
  
    ## Returns true if one of the key_symbols is down
    def any_key_down? *key_symbols
      key_symbols << :any_key if key_symbols.empty?
      key_symbols.each do |key_symbol|
        return true if key_down? key_symbol
      end
      return nil if key_symbols.empty?
      return false
    end
    alias any_of_keys_down? any_key_down?
  
    def button_down id
      key = @@key_symbols[id]
      return unless key
      @@key_down_listeners.each { |listener, method| method.call key }
    end

    def button_up id
      key = @@key_symbols[id]
      return unless key
      @@key_up_listeners.each { |listener, method| method.call key }
    end
  end

end