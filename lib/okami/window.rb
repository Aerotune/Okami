module Okami
  class Window < Gosu::Window
    
    def initialize *args
      $window = super *args
    end
    
    attr_accessor :cursor_visible
    def show_cursor;   @cursor_visible = true  end
    def hide_cursor;   @cursor_visible = false end
    def needs_cursor?; @cursor_visible         end
  
    def button_down id
      Okami::Keyboard .button_down  id
      Okami::Mouse    .button_down  id
    end

    def button_up   id
      Okami::Keyboard .button_up    id
      Okami::Mouse    .button_up    id
    end
    
    def fill color, z=0, mode=:default
      draw_quad 0,      0,      color,
                width,  0,      color,
                0,      height, color,
                width,  height, color,
                z, mode
    end
    
    def calculate_dt
      update_interval   = self.update_interval / 1000.0
      seconds           = Time.now.to_f
      @_current_time    = seconds
      @_previous_time ||= @_current_time - update_interval
      dt                = @_current_time - @_previous_time
      @_previous_time   = @_current_time
      dt = update_interval if dt < update_interval
      return dt, seconds
    end
    
  end # Window
end # Okami
