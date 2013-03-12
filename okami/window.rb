module Okami
  def self.method_missing *args
    Gosu.send *args
  end
  
  def self.const_missing const
    Gosu.const_get const
  end
  
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
  
    def retrofy
      Gosu::enable_undocumented_retrofication \
      rescue puts "Unable to use Gosu::enable_undocumented_retrofication"
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
    
    
  end
end

