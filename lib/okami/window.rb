module Okami
  class Window < Gosu::Window
    include Gosu
    include Okami
    attr_accessor :cursor_visible
    
    def initialize *args
      @prev_t = Gosu::milliseconds
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
    
    def fill color, z=0
      color = case color
      when :white then 0xFFFFFFFF
      when :black then 0xFF000000
      end
      
      draw_quad 0,      0,      color,
                width,  0,      color,
                0,      height, color,
                width,  height, color,
                z, mode = :default
    end
    
    def calculate_dt
      @t       = Gosu::milliseconds
      @dt      = (@t-@prev_t)/1000.0
      @prev_t  = @t
    end
    
    def self.inherited(subclass)
      def subclass.method_added(name)
        if name == :update
          return if caller.first.match(/^(.+?):(\d+)(?::in `(.*)')?/)[1].match /eval/i
          class_eval "def update_hook\n calculate_dt\n update_without_hook\nend"
          class_eval "alias update_without_hook update"
          class_eval "alias update update_hook"
        end
      end
    end
    
  end # Window
end # Okami

