module Okami
  class Window < Gosu::Window
    attr_reader :dt, :current_time
    attr_accessor :cursor_visible
    
    def initialize *args
      $window = super *args
    end
  
    def show_cursor;   @cursor_visible = true  end
    def hide_cursor;   @cursor_visible = false end
    def needs_cursor?; @cursor_visible         end
  
    def button_down id
      Okami::Keyboard.button_down id
      Okami::Mouse.button_down id
    end

    def button_up id
      Okami::Keyboard.button_up id
      Okami::Mouse.button_up id
    end
    
    def color_fill color, z=0
      color = case color
      when :white then 0xFFFFFFFF
      when :black then 0xFF000000
      when Symbol
        raise ArgumentError, "Unknown color #{color.inspect}"
      else
        color
      end
      
      draw_quad 0,      0,      color,
                width,  0,      color,
                0,      height, color,
                width,  height, color,
                z, mode = :default
    end
    
    def calculate_dt
      @current_time    = Gosu::milliseconds/1000.0
      @previous_time ||= @current_time - update_interval/1000.0
      @dt              = @current_time - @previous_time
      @previous_time   = @current_time
    end
    
    def self.inherited(subclass)
      def subclass.method_added(name)
        if name == :update
          ## Prevent infinite loop
          return if caller.first.match(/^(.+?):(\d+)(?::in `(.*)')?/)[1].match /eval/i
          ## Calculate_dt before update
          class_eval "def update_hook\n calculate_dt\n update_without_hook\nend"
          class_eval "alias update_without_hook update"
          class_eval "alias update update_hook"
        end
      end
    end
    
  end # Window
end # Okami
